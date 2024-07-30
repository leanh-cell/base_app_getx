import 'package:com.ikitech.store/app_user/data/remote/response-request/order/all_order_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/order/cancel_order_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/order/change_order_status_repose.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/order/change_pay_success_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/order/history_shipper_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/order/order_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/order/payment_history_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/order/refund_calculate_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/order/state_history_order_customer_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/order/state_history_order_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/success/success_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';
import '../../remote/response-request/order/calculate_fee_order_res.dart';
import '../handle_error.dart';
import '../../remote/response-request/order/refund_request.dart';

class OrderRepository {
  Future<AllOrderResponse?> getAllOrder({
    required int numberPage,
    String? search,
    String? fieldBy,
    String? filterByValue,
    String? sortBy,
    bool? descending,
    String? dateFrom,
    String? dateTo,
    int? agencyByCustomerId,
    int? collaboratorByCustomerId,
    String? phoneNumber,
    String? orderStatusCode,
    String? paymentStatusCode,
    bool? fromPos,
    int? branchId,
    String? listBranchId,
    String? listOrderFrom,
    String? listOrderStt,
    String? listPaymentStt,
    int? staffId,
  }) async {
    try {
      var res = await SahaServiceManager().service!.getAllOrder(
            UserInfo().getCurrentStoreCode()!,
            numberPage,
            search,
            fieldBy,
            filterByValue,
            sortBy,
            descending,
            dateFrom,
            dateTo,
            agencyByCustomerId,
            collaboratorByCustomerId,
            phoneNumber,
            orderStatusCode,
            paymentStatusCode,
            fromPos,
            null,
            listBranchId,
            listOrderFrom,
            listOrderStt,
            listPaymentStt,
            staffId,
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<StateHistoryOrderCustomerResponse?> getStateHistoryCustomerOrder(
      int? idOrder) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getStateHistoryCustomerOrder(
              UserInfo().getCurrentStoreCode(), idOrder);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<OrderResponse?> getOneOrderHistory(String? orderCode) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getOneOrderHistory(UserInfo().getCurrentStoreCode(), orderCode);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<HistoryShipperResponse?> getStateHistoryShipper(
      String? orderCode) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getStateHistoryShipper(UserInfo().getCurrentStoreCode(), {
        "order_code": orderCode,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<StateHistoryOrderResponse?> getStateHistoryOrder(int? idOrder) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getStateHistoryOrder(UserInfo().getCurrentStoreCode(), idOrder);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<OrderResponse?> getOneOrder(String orderCode) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getOneOrder(UserInfo().getCurrentStoreCode()!, orderCode);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<PaymentHistoryRes?> getPaymentHistory(String orderCode) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getPaymentHistory(UserInfo().getCurrentStoreCode()!, orderCode);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> payBill(
      {required String orderCode,
      required int paymentMethod,
      required double amountMoney}) async {
    try {
      var res = await SahaServiceManager().service!.payBill(
          UserInfo().getCurrentStoreCode()!,
          UserInfo().getCurrentIdBranch(),
          orderCode, {
        "payment_method_id": paymentMethod,
        "amount_money": amountMoney,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ChangeOrderStatusResponse?> changeOrderStatus(
      String? orderCode, String orderStatusCode) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .changeOrderStatus(UserInfo().getCurrentStoreCode(), {
        "order_code": orderCode,
        "order_status_code": orderStatusCode,
      });
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> refund(RefundRequest refundRequest) async {
    try {
      var res = await SahaServiceManager().service!.refund(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          refundRequest.toJson());
    } catch (err) {
      handleError(err);
    }
  }

  Future<RefundCalculateRes?> refundCalculate(
      RefundRequest refundRequest) async {
    try {
      var res = await SahaServiceManager().service!.refundCalculate(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          refundRequest.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> sendOrderEmail(
      String email, String orderCode) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .sendOrderEmail(UserInfo().getCurrentStoreCode(), {
        "email": email,
        "order_code": orderCode,
      });
    } catch (err) {
      handleError(err);
    }
  }

  Future<ChangePaySuccessResponse?> changePaymentStatus(
      String? orderCode, String orderStatusCode) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .changePaymentStatus(UserInfo().getCurrentStoreCode(), {
        "order_code": orderCode,
        "payment_status_code": orderStatusCode,
      });
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> updateOrder(String orderCode, int? partnerShipperId,
      double? totalShippingFee, int? branchId) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateOrder(UserInfo().getCurrentStoreCode()!, orderCode, {
        "partner_shipper_id": partnerShipperId,
        "total_shipping_fee": totalShippingFee,
        "branch_id": branchId,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CancelOrderResponse?> cancelOrder(
      String? orderCode, String reasonCancel) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .cancelOrder(UserInfo().getCurrentStoreCode(), {
        "order_code": orderCode,
        "note": reasonCancel,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> sendOrderToShipper(
    String? orderCode,
  ) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .sendOrderToShipper(UserInfo().getCurrentStoreCode(), {
        "order_code": orderCode,
      });
    } catch (err) {
      handleError(err);
    }
  }

  Future<OrderResponse?> updatePackage(
    String orderCode,
    double? height,
    double? width,
    double? length,
    double? weight,
    double? cod
  ) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updatePackage(UserInfo().getCurrentStoreCode(), orderCode, {
        "package_weight": weight,
        "package_length": length,
        "package_width": width,
        "package_height": height,
        "cod" : cod
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CalculateFeeOrderRes?> calculateFeeOrder(
    String orderCode,
  ) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .calculateFeeOrder(UserInfo().getCurrentStoreCode()!, orderCode,);
      return res;
    } catch (err) {
      handleError(err);
    }
  }


}
