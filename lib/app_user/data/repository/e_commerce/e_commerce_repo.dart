import 'package:com.ikitech.store/app_user/model/product_commerce.dart';
import 'package:intl/intl.dart';

import '../../../model/e_commerce.dart';
import '../../../utils/user_info.dart';
import '../../remote/response-request/e_commerce/all_order_commerce_res.dart';
import '../../remote/response-request/e_commerce/all_product_commerce_res.dart';
import '../../remote/response-request/e_commerce/all_werehouses_res.dart';
import '../../remote/response-request/e_commerce/e_commerce_res.dart';
import '../../remote/response-request/e_commerce/e_commerces_res.dart';
import '../../remote/response-request/e_commerce/order_commerce_res.dart';
import '../../remote/response-request/e_commerce/product_commerce_res.dart';
import '../../remote/response-request/e_commerce/sync_res.dart';
import '../../remote/response-request/e_commerce/werehouse_res.dart';
import '../../remote/response-request/success/success_response.dart';
import '../../remote/saha_service_manager.dart';
import '../handle_error.dart';

class EcommerceRepo {
  Future<AllECommerceRes?> getAllEcommerce({String? platformName}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllEcommerce(UserInfo().getCurrentStoreCode(), platformName);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllProductCommerceRes?> getAllProductCommerce({
    required int page,
    required String shopId,
    required int skuPairType,
  }) async {
    try {
      var res = await SahaServiceManager().service!.getAllProductCommerce(
            UserInfo().getCurrentStoreCode(),
            page,
            UserInfo().getCurrentIdBranch(),
            skuPairType,
            shopId,
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SyncRes?> syncProduct(
      {required List<String> shopId, required int page}) async {
    try {
      var res = await SahaServiceManager().service!.syncProduct(
          UserInfo().getCurrentStoreCode(),
          {"page": page, "shop_ids": List<String>.from(shopId.map((e) => e))});
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ProductCommerceRes?> getProducCommerce(
      {required int id, required String shopId}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getProducCommerce(UserInfo().getCurrentStoreCode(), id, shopId);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ProductCommerceRes?> updateProductCommerce(
      {required int idProduct,
      required ProductCommerce productCommerce}) async {
    try {
      var res = await SahaServiceManager().service!.updateProductCommerce(
          UserInfo().getCurrentStoreCode(),
          idProduct,
          productCommerce.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SyncRes?> syncOrder(
      {required List<String> shopId, required int page}) async {
    try {
      var res = await SahaServiceManager().service!.syncOrder(
          UserInfo().getCurrentStoreCode(),
          {"page": page, "shop_ids": List<String>.from(shopId.map((e) => e))});
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllOrderCommerceRes?> getAllOrderCommerce(
      {required int page,
      required List<String> shopIds,
      String? orderStatus,
      DateTime? startDate,
      DateTime? endDate}) async {
    print(shopIds.toString().replaceAll("[", "").replaceAll("]", ""));
    try {
      var res = await SahaServiceManager().service!.getAllOrderCommerce(
          UserInfo().getCurrentStoreCode(),
          page,
          shopIds.toString().replaceAll("[", "").replaceAll("]", "").replaceAll(" ", ""),
          orderStatus,
          startDate == null ? null : DateFormat('yyyy-MM-dd').format(startDate),
          endDate == null ? null : DateFormat('yyyy-MM-dd').format(endDate));
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<OrderCommerceRes?> getOrderCommerce({required String oderCode}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getOrderCommerce(UserInfo().getCurrentStoreCode(), oderCode);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ECommerceRes?> updateCommerce(
      {required String shopId, required ECommerce eCommerce}) async {
    try {
      var res = await SahaServiceManager().service!.updateCommerce(
          UserInfo().getCurrentStoreCode(), shopId, eCommerce.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> deleteCommerce({required String shopId}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deleteCommerce(UserInfo().getCurrentStoreCode(), shopId);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllWarehousesRes?> getAllWarehouses({required String shopId}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllWarehouses(UserInfo().getCurrentStoreCode(), shopId);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<WarehousesRes?> updateWarehouses(
      {required int warehouseId, required bool allowSync}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateWarehouses(UserInfo().getCurrentStoreCode(), warehouseId, {
        "allow_sync": allowSync,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
