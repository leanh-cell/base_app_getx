import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/button/button_home.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/decentralization/decentralization_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/const/function_constant.dart';
import 'package:com.ikitech.store/app_user/screen2/agency/agency_main_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/branch/branch_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/chat/all_box_chat_user/all_box_chat_user_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/ctv/ctv_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/home/choose_customer/choose_customer_screen.dart';

import 'package:com.ikitech.store/app_user/screen2/inventory/suppliers/suppliers_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/navigator/navigator_controller.dart';
import 'package:com.ikitech.store/app_user/screen2/product_menu/product_menu_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/staff/staff_screen.dart';
import 'package:com.ikitech.store/saha_data_controller.dart';
import '../accountant/accountant_main.dart';
import '../community/comunity_screen.dart';
import '../education/course_list_screen.dart';

import '../operation_history/operation_history_screen.dart';
import '../order/order_controller.dart';
import '../posts/screen.dart';
import '../sale/sale_screen.dart';
import '../sale_market/sale_market_screen.dart';
import '../warehouse/warehouse_screen.dart';

class MapButtonFunction extends StatelessWidget {
  String typeFunction;

  MapButtonFunction({required this.typeFunction});

  SahaDataController sahaDataController = Get.find();
  NavigatorController navigatorController = Get.find();

  @override
  Widget build(BuildContext context) {
    if (typeFunction == PRODUCT_F) {
      return DecentralizationWidget(
        decent: true,
        child: ButtonHome(
          asset: 'assets/icons/products.svg',
          title: 'Sản phẩm',
          onTap: () {
            Get.back();
            Get.to(() => ProductMenuScreen());
          },
        ),
      );
    }
    if (typeFunction == REVENUE_EXPENDITURE_F) {
      return DecentralizationWidget(
        decent:
            (sahaDataController.badgeUser.value.decentralization?.addRevenue ??
                            false) ==
                        false &&
                    (sahaDataController.badgeUser.value.decentralization
                                ?.addExpenditure ??
                            false) ==
                        false
                ? false
                : true,
        child: ButtonHome(
          asset: 'assets/icons/money.svg',
          title: 'Tạo khoản thu chi',
          onTap: () {
            Get.back();
            SahaDialogApp.showChooseRevenueExpenditure();
          },
        ),
      );
    }
    if (typeFunction == STAFF_F) {
      return DecentralizationWidget(
        decent:
            sahaDataController.badgeUser.value.decentralization?.staffList ??
                false,
        child: ButtonHome(
          asset: 'assets/icons/staff.svg',
          title: 'Quản lý nhân viên',
          color: Colors.orange,
          onTap: () {
            Get.back();
            Get.to(() => StaffScreen());
          },
        ),
      );
    }
    if (typeFunction == CHAT_F) {
      return DecentralizationWidget(
        decent: sahaDataController.badgeUser.value.decentralization?.chatList ??
            false,
        child: ButtonHome(
          asset: 'assets/icons/chat.svg',
          title: 'Chat',
          onTap: () {
            Get.back();
            Get.to(() => AllBoxChatUSerScreen())!
                .then((value) => {sahaDataController.unread.value = 0});
          },
        ),
      );
    }
    if (typeFunction == AGENCY_F) {
      return DecentralizationWidget(
        decent: true,
        child: ButtonHome(
          asset: 'assets/icons/agency.svg',
          title: 'Đại lý',
          onTap: () {
            Get.back();
            Get.to(() => AgencyMainScreen());
          },
        ),
      );
    }
    if (typeFunction == COLLABORATOR_F) {
      return DecentralizationWidget(
        decent: true,
        child: ButtonHome(
          asset: 'assets/icons/ctv.svg',
          title: 'Cộng tác viên',
          color: Colors.green,
          onTap: () {
            Get.back();
            Get.to(() => CtvScreen());
          },
        ),
      );
    }
    if (typeFunction == SALE_F) {
      return DecentralizationWidget(
        decent: true,
        child: ButtonHome(
          asset: 'assets/icons/seller.svg',
          title: 'Sale',
          color: Colors.pink,
          onTap: () {
            Get.back();
            Get.to(() => SaleScreen());
          },
        ),
      );
    }
    if (typeFunction == POST_F) {
      return DecentralizationWidget(
        decent: sahaDataController.badgeUser.value.decentralization?.postList ??
            false,
        child: ButtonHome(
          asset: 'assets/icons/paper.svg',
          title: 'Tin tức - Bài viết',
          onTap: () {
            Get.back();
            Get.to(() => PostNaviScreen());
          },
        ),
      );
    }
    if (typeFunction == COMMUNITY_F) {
      return DecentralizationWidget(
        decent: sahaDataController
                .badgeUser.value.decentralization?.communicationList ??
            false,
        child: ButtonHome(
          asset: 'assets/icons/community.svg',
          title: 'Cộng đồng',
          color: Colors.deepOrange,
          onTap: () {
            Get.back();
            Get.to(() => CommunityScreen());
          },
        ),
      );
    }
    if (typeFunction == EDUCATION_F) {
      return DecentralizationWidget(
        decent:
            sahaDataController.badgeUser.value.decentralization?.train ?? false,
        child: ButtonHome(
          asset: 'assets/icons/education.svg',
          title: 'Đào tạo',
          color: Colors.deepOrange,
          onTap: () {
            Get.back();
            Get.to(() => CourseListScreen());
          },
        ),
      );
    }
    if (typeFunction == SUPPLIER_F) {
      return DecentralizationWidget(
        decent: sahaDataController.badgeUser.value.decentralization?.supplier ??
            false,
        child: ButtonHome(
          asset: 'assets/icons/store.svg',
          title: 'Nhà cung cấp',
          color: Colors.green,
          onTap: () {
            Get.back();
            Get.to(() => SuppliersScreen());
          },
        ),
      );
    }
    if (typeFunction == BRANCH_F) {
      return DecentralizationWidget(
        decent:
            sahaDataController.badgeUser.value.decentralization?.branchList ??
                false,
        child: ButtonHome(
          asset: 'assets/icons/office.svg',
          title: 'Chi nhánh',
          onTap: () {
            Get.back();
            Get.to(() => BranchScreen());
          },
        ),
      );
    }
    if (typeFunction == CREATE_ORDER_F) {
      return DecentralizationWidget(
        decent: sahaDataController
                .badgeUser.value.decentralization?.createOrderPos ??
            false,
        child: ButtonHome(
          asset: 'assets/icons/add_cart.svg',
          title: 'Tạo đơn',
          color: Colors.blue,
          onTap: () {
            Get.back();
            navigatorController.indexNav.value = 0;
          },
        ),
      );
    }
    if (typeFunction == ORDER_F) {
      return DecentralizationWidget(
        decent:
            sahaDataController.badgeUser.value.decentralization?.orderList ??
                false,
        child: ButtonHome(
          asset: 'assets/icons/list_order.svg',
          title: 'Đơn hàng',
          onTap: () {
            Get.back();
            OrderController orderController = Get.find();
            orderController.loadMoreOrder(isRefresh: true);
            navigatorController.indexNav.value = 1;
          },
        ),
      );
    }
    // if (typeFunction == IMPORT_STOCK_F) {
    //   return DecentralizationWidget(
    //     decent: sahaDataController
    //             .badgeUser.value.decentralization?.inventoryImport ??
    //         false,
    //     child: ButtonHome(
    //       asset: 'assets/icons/import_home.svg',
    //       title: 'Nhập hàng',
    //       color: Colors.orange,
    //       onTap: () {
    //         Get.back();
    //         Get.to(() => ImportStockScreen());
    //       },
    //     ),
    //   );
    // }
    // if (typeFunction == TALLY_SHEET_F) {
    //   return DecentralizationWidget(
    //     decent: sahaDataController
    //             .badgeUser.value.decentralization?.inventoryTallySheet ??
    //         false,
    //     child: ButtonHome(
    //       asset: 'assets/icons/check_inventory.svg',
    //       title: 'Kiểm kho',
    //       color: Colors.orange,
    //       onTap: () {
    //         Get.back();
    //         Get.to(() => CheckInventoryScreen());
    //       },
    //     ),
    //   );
    // }
    if (typeFunction == WAREHOUSE) {
      return DecentralizationWidget(
        decent: true,
        child: ButtonHome(
          asset: 'assets/icons/check_inventory.svg',
          title: 'Kho',
          color: Colors.orange,
          onTap: () {
            Get.back();
            Get.to(() => WarehouseScreen());
          },
        ),
      );
    }

    if (typeFunction == CUSTOMER_F) {
      return DecentralizationWidget(
        decent:
            sahaDataController.badgeUser.value.decentralization?.customerList ??
                false,
        child: ButtonHome(
          asset: 'assets/icons/customer.svg',
          title: 'Khách hàng',
          color: Colors.green,
          onTap: () {
            Get.back();
            Get.to(() => ChooseCustomerScreen(
                  hideSale: false,
                ));
          },
        ),
      );
    }

    // if (typeFunction == REVENUER_F) {
    //   return DecentralizationWidget(
    //     decent: sahaDataController
    //             .badgeUser.value.decentralization?.revenueExpenditure ??
    //         false,
    //     child: ButtonHome(
    //       asset: 'assets/icons/revenue.svg',
    //       title: 'Kế toán',
    //       onTap: () {
    //         Get.back();
    //         Get.to(() => AccountantMainScreen());
    //       },
    //     ),
    //   );
    // }

    if (typeFunction == HISTORY_OPERATION_F) {
      return DecentralizationWidget(
        decent: sahaDataController
                .badgeUser.value.decentralization?.historyOperation ??
            false,
        child: ButtonHome(
          asset: 'assets/icons/history_function.svg',
          title: 'Lịch sử thao tác',
          color: Colors.indigo,
          onTap: () {
            Get.back();
            Get.to(() => OperationHistoryScreen());
          },
        ),
      );
    }

    // if (typeFunction == CHANGE_INVENTORY_F) {
    //   return DecentralizationWidget(
    //     decent: sahaDataController
    //             .badgeUser.value.decentralization?.transferStock ??
    //         false,
    //     child: ButtonHome(
    //       asset: 'assets/icons/change_inventory.svg',
    //       title: 'Chuyển kho',
    //       color: Colors.orange,
    //       onTap: () {
    //         Get.back();
    //         Get.to(() => TransferStockScreen());
    //       },
    //     ),
    //   );
    // }

    // if (typeFunction == SALE_MARKET) {
    //   return DecentralizationWidget(
    //     decent: sahaDataController.badgeUser.value.isSale ?? false,
    //     child: ButtonHome(
    //       asset: 'assets/icons/seller.svg',
    //       title: 'Checkin đại lý',
    //       color: Colors.pink,
    //       onTap: () {
    //         Get.back();
    //         Get.to(() => SaleMarketScreen());
    //       },
    //     ),
    //   );
    // }

    return ButtonHome(
      asset: 'assets/icons/more.svg',
      title: 'Xem thêm',
      color: Colors.grey[350],
      onTap: () {
        SahaDialogApp.showDialogButtonHome();
      },
    );
  }
}
