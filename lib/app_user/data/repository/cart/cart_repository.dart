import 'package:com.ikitech.store/app_user/data/remote/response-request/cart/all_cart_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/cart/cart_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/order/order_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/success/success_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/model/cart.dart';
import 'package:com.ikitech.store/app_user/model/cart_info.dart';
import 'package:com.ikitech.store/app_user/model/order_request.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';

import '../handle_error.dart';

class CartRepository {
  Future<Cart?> getItemCart(String? codeVoucher, bool isUsePoints,
      bool isUseBalanceCollaborator) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getItemCart(UserInfo().getCurrentStoreCode(), {
        "code_voucher": codeVoucher,
        "is_use_points": isUsePoints,
        "is_use_balance_collaborator": isUseBalanceCollaborator
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CartRes?> updateInfoCart(int? cartId, CartInfo cartInfo) async {
    try {
      var res = await SahaServiceManager().service!.updateInfoCart(
            UserInfo().getCurrentStoreCode(),
            UserInfo().getCurrentIdBranch(),
            cartId,
            cartInfo.toJson(),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CartRes?> useVoucher(int? cartId, String voucherCode) async {
    try {
      var res = await SahaServiceManager().service!.useVoucher(
        UserInfo().getCurrentStoreCode(),
        UserInfo().getCurrentIdBranch(),
        cartId,
        {
          "code_voucher": voucherCode,
        },
      );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CartRes?> updateItemCart(
    int? cartId,
    int? lineItemId,
    int productId,
    int quantity,
    String? distributeName,
    String? elementDistributeName,
    String? subElementDistributeName,
  ) async {
    try {
      var res = await SahaServiceManager().service!.updateItemCart(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          cartId, {
        "line_item_id": lineItemId,
        "product_id": productId,
        "quantity": quantity,
        "distribute_name": distributeName,
        "element_distribute_name": elementDistributeName,
        "sub_element_distribute_name": subElementDistributeName,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CartRes?> noteItemCart(
    int? cartId,
    int? cartItemId,String? note
  ) async {
    try {
      var res = await SahaServiceManager().service!.noteItemCart(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          cartId,
          cartItemId,
          {
            "note":note
          }
         );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CartRes?> addItemCart(
    int? cartId,
    int productId,
    int quantity,
    String? distributeName,
    String? elementDistributeName,
    String? subElementDistributeName,
  ) async {
    try {
      var res = await SahaServiceManager().service!.addProductToCart(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          cartId, {
        "product_id": productId,
        "quantity": quantity,
        "distribute_name": distributeName,
        "element_distribute_name": elementDistributeName,
        "sub_element_distribute_name": subElementDistributeName,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllCartRes?> getAllCart({bool? hasCartDefault}) async {
    try {
      var res = await SahaServiceManager().service!.getAllCart(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          hasCartDefault);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllCartRes?> createCart(String name) async {
    try {
      var res = await SahaServiceManager().service!.createCart(
          UserInfo().getCurrentStoreCode(), UserInfo().getCurrentIdBranch(), {
        "name": name,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CartRes?> getCart(int cartId) async {
    try {
      var res = await SahaServiceManager().service!.getCart(
            UserInfo().getCurrentStoreCode(),
            UserInfo().getCurrentIdBranch(),
            cartId,
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllCartRes?> createCartSave(String nameCart) async {
    try {
      var res = await SahaServiceManager().service!.createCartSave(
        UserInfo().getCurrentStoreCode(),
        UserInfo().getCurrentIdBranch(),
        {
          "name": nameCart,
        },
      );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CartRes?> createCartOrder(String orderCode) async {
    try {
      var res = await SahaServiceManager().service!.createCartOrder(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          orderCode);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> deleteCart(int cartId) async {
    try {
      var res = await SahaServiceManager().service!.deleteCart(
            UserInfo().getCurrentStoreCode(),
            UserInfo().getCurrentIdBranch(),
            cartId,
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CartRes?> changeNameCart({required int cartId,String? name}) async {
    try {
      var res = await SahaServiceManager().service!.changeNameCart(
            UserInfo().getCurrentStoreCode(),
            UserInfo().getCurrentIdBranch(),
            cartId,
            {
              "name" : name
            }
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<OrderResponse?> createOrder(OrderRequest orderRequest) async {
    try {
      var res = await SahaServiceManager().service!.createOrder(
            UserInfo().getCurrentStoreCode(),
            orderRequest.toJson(),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> clearCart({required int cartId}) async {
    try {
      var res = await SahaServiceManager().service!.clearCart(
            UserInfo().getCurrentStoreCode(),
            UserInfo().getCurrentIdBranch(),
            cartId,
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<OrderResponse?> orderCart(
      int cartId, int paymentMethod, double amountMoney, int orderFrom) async {
    try {
      var res = await SahaServiceManager().service!.orderCart(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          cartId, {
        "payment_method_id": paymentMethod,
        "amount_money": amountMoney,
        "order_from": orderFrom
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
