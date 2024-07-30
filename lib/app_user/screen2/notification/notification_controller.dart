import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/const/const_type_message.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/notification/all_notification_response.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/screen2/bill/bill_detail/bill_detail_screen.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';

import '../../const/noti_const.dart';
import '../../const/order_constant.dart';
import '../agency/agency_request_register/agency_request_register_screen.dart';
import '../chat/all_box_chat_user/all_box_chat_user_screen.dart';
import '../ctv/collaborator_register_request/collaborator_register_request_screen.dart';
import '../ctv/list_ctv/list_ctv_screen.dart';
import '../ctv/list_request_payment/list_request_payment_screen.dart';
import '../order_manage/order_detail_manage/order_detail_manage_screen.dart';

class NotificationController extends GetxController {
  NotificationController() {
    historyNotification();
  }

  var listNotificationUser = RxList<NotificationUser>();
  var isLoadMore = false.obs;
  int currentPage = 1;
  bool isEndOrder = false;
  var isLoading = false.obs;
  var isLoadRefresh = true.obs;

  Future<void> readAllNotification({bool? isRefresh}) async {
    try {
      var res =
          await RepositoryManager.notificationRepository.readAllNotification();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> historyNotification({bool? isRefresh}) async {
    if (isRefresh == true) {
      isLoadRefresh.value = true;
      listNotificationUser([]);
      currentPage = 1;
      isEndOrder = false;
    } else {
      isLoadMore.value = true;
    }

    try {
      if (isEndOrder == false) {
        var res = await RepositoryManager.notificationRepository
            .historyNotification(currentPage);

        res!.data!.listNotification!.data!.forEach((e) {
          listNotificationUser.add(e);
        });

        if (res.data!.listNotification!.nextPageUrl != null) {
          currentPage++;
          isEndOrder = false;
        } else {
          isEndOrder = true;
        }
      } else {
        isLoadMore.value = false;
        return;
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }

    isLoadMore.value = false;
    isLoadRefresh.value = false;
  }

  var orderShow = Order().obs;
  Future<void> getOneOrder(String orderCode) async {
    EasyLoading.show();
    isLoading.value = true;
    try {
      var res = await RepositoryManager.orderRepository.getOneOrder(orderCode);
      orderShow.value = res!.data!;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    EasyLoading.dismiss();
    isLoading.value = false;
  }

  void navigator(NotificationUser notificationUser) async {
    if (notificationUser.type == NEW_ORDER) {
      await getOneOrder(notificationUser.referencesValue ?? "");

      if (orderShow.value.orderFrom == ORDER_FROM_APP ||
          orderShow.value.orderFrom == ORDER_FROM_WEB ||
          orderShow.value.orderFrom == ORDER_FROM_POS_DELIVERY) {
        Get.to(() => OrderDetailScreen(
              order: orderShow.value,
            ));
      } else {
        Get.to(() => BillDetailScreen(
              orderCode: orderShow.value.orderCode ?? "",
            ));
      }
    }

    if (notificationUser.type == GET_CTV) {
      Get.to(() => ListCtvScreen());
    }

    if (notificationUser.type == NEW_PERIODIC_SETTLEMENT) {
      Get.to(() => ListRequestPaymentScreen(
            isSettlement: true,
          ));
    }
    if (notificationUser.type == NEW_MESSAGE) {
      Get.to(() => AllBoxChatUSerScreen())!.then((value) {
        //historyNotification(isRefresh: true);
      });
    }

    if (notificationUser.type == GET_AGENCY) {
      Get.to(() => AgencyRequestRegisterScreen())!.then((value) {
        //historyNotification(isRefresh: true);
      });
    }

    if (notificationUser.type == GET_CTV) {
      Get.to(() => CollaboratorRegisterRequestScreen())!.then((value) {
        //historyNotification(isRefresh: true);
      });
    }
    // if (typeNotification == NEW_POST) {}
    // if (typeNotification == NEW_PERIODIC_SETTLEMENT) {
    //   Get.to(() => ListRequestPaymentScreen())!.then((value) {
    //     //historyNotification(isRefresh: true);
    //   });
    // }
    // if (typeNotification == ORDER_STATUS) {
    //   Get.to(() => OrderManageScreen())!.then((value) {
    //     historyNotification(isRefresh: true);
    //   });
    // }
    // if (typeNotification == CUSTOMER_CANCELLED_ORDER) {
    //   Get.to(() => OrderManageScreen(
    //         initPageOrder: 6,
    //         stateManager: 0,
    //       ));
    // }
    // if (typeNotification. == CUSTOMER_PAID) {
    //   Get.to(() => OrderManageScreen(
    //         initPagePayment: 2,
    //         stateManager: 1,
    //       ))!.then((value) {
    //    // historyNotification(isRefresh: true);
    //   });
    // }
    // if (typeNotification == SEND_ALL) {}
    // if (typeNotification == TO_ADMIN) {}
  }
}
