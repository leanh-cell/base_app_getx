import 'package:com.ikitech.store/app_user/model/order_commerce.dart';
import 'package:get/get.dart';

import '../../../../components/saha_user/toast/saha_alert.dart';
import '../../../../data/remote/response-request/e_commerce/sync_res.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/e_commerce.dart';

class OrderShopCommerceController extends GetxController {
  var listOrderCommerce = RxList<OrderCommerce>();
  int currentPage = 1;
  bool isEnd = false;
  int pageCommerce = 1;
  var isLoading = false.obs;
  var loadInit = true.obs;
  var isSync = true;
  var dataSync = SyncData();
  var  shopIds = RxList<ECommerce>();
   List<ECommerce>  shopIdsInput = [];

  var fromDay = DateTime.now().obs;
  var toDay = DateTime.now().obs;
  var fromDayCP = DateTime.now().obs;
  var toDayCP = DateTime.now().obs;
  var isCompare = false.obs;
  var page = 0.obs;
  int indexTabTime = 0;
  int indexChooseTime = 0;

  ///////
  var orderStatus = RxList<String>();
  var listShop = RxList<ECommerce>();

  OrderShopCommerceController({required this.shopIdsInput}) {
    getAllOrderCommerce(isRefresh: true);
    shopIds(shopIdsInput.toList());
  }

  Future<void> getAllOrderCommerce({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var res = await RepositoryManager.eCommerceRepo.getAllOrderCommerce(
            page: currentPage,
            shopIds: shopIds.map((e) => e.shopId!).toList(),
            orderStatus: orderStatus.join(','),
            startDate: fromDay.value,
            endDate: toDay.value);

        if (isRefresh == true) {
          listOrderCommerce(res!.data!.data!);
        } else {
          listOrderCommerce.addAll(res!.data!.data!);
        }

        if (res.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      isLoading.value = false;
      loadInit.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> syncOrder() async {
    try {
      var res = await RepositoryManager.eCommerceRepo
          .syncOrder(shopId: shopIds.map((e) => e.shopId!).toList(), page: pageCommerce);
      dataSync = res!.data!;
    } on Exception catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  List<String> orderStatusLazada = [
    'pending',
    'ready_to_ship',
    'delivered',
    'topack',
    'shipping',
    'canceled',
    'failed',
    'returned',
    'lost'
  ];
  List<String> orderStatusTiki = [
    'queueing',
    'handover_to_partner',
    'processing',
    'delivered',
    'packaging',
    'picking',
    'shipping',
    'ready_to_ship',
    'finished_packing',
    'canceled',
    'closed',
    'holded',
    'returned'
  ];
}
