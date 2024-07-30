import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/combo/combo_request.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/combo/create_combo_reponse.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/combo/end_combo_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/combo/my_combo_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/delete_program_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/discount/create_discount_respone.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/discount/end_discount_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/discount/my_program_reponse.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/voucher/all_voucher_code_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/voucher/all_voucher_product_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/voucher/create_voucher_reponse.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/voucher/end_voucher_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/voucher/my_voucher_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/voucher/voucher_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/voucher_request.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/model/bonus_product.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';
import '../../../model/agency_type.dart';
import '../../remote/response-request/customer/all_group_customer_res.dart';
import '../../remote/response-request/marketing_chanel_response/bonus_product/all_bonus_product_res.dart';
import '../../remote/response-request/marketing_chanel_response/bonus_product/bonus_product_item.dart';
import '../../remote/response-request/marketing_chanel_response/bonus_product/bonus_product_res.dart';
import '../../remote/response-request/marketing_chanel_response/bonus_product/end_bonus_product_res.dart';
import '../../remote/response-request/success/success_response.dart';
import '../handle_error.dart';

class MarketingChanelRepository {
  Future<CreateDiscountResponse?> createDiscount(
    String name,
    String description,
    String imageUrl,
    String startTime,
    String endTime,
    double value,
    bool setLimitedAmount,
    int amount,
    List<int> group,
    List<AgencyType> agencyType,
    List<GroupCustomer> groupCustomer,

    // int agencyTypeId,
    // String agencyTypeName,
    // int groupTypeId,
    // String groupTypeName,
    String listIdProduct,
  ) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .createDiscount(UserInfo().getCurrentStoreCode(), {
        "name": name,
        "group_customers": group,
        "agency_types": List<dynamic>.from(agencyType.map((x) => x.toJson())),
        "group_types": List<dynamic>.from(groupCustomer.map((x) => x.toJson())),
        "description": description,
        "image_url": imageUrl,
        "start_time": startTime,
        "end_time": endTime,
        "value": value,
        "set_limit_amount": setLimitedAmount,
        "amount": amount,
        "product_ids": listIdProduct,
      });

      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CreateDiscountResponse?> updateDiscount(
    int? idDiscount,
    bool isEnd,
    String name,
    String description,
    String imageUrl,
    String startTime,
    String endTime,
    double value,
    bool setLimitedAmount,
    int amount,
    List<int> group,
    List<AgencyType> agencyType,
    List<GroupCustomer> groupCustomer,
    String listIdProduct,
  ) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateDiscount(UserInfo().getCurrentStoreCode(), idDiscount, {
        "is_end": isEnd,
        "name": name,
        "group_customers": group,
        "agency_types": List<dynamic>.from(agencyType.map((x) => x.toJson())),
        "group_types": List<dynamic>.from(groupCustomer.map((x) => x.toJson())),
        "description": description,
        "image_url": imageUrl,
        "start_time": startTime,
        "end_time": endTime,
        "value": value,
        "set_limit_amount": setLimitedAmount,
        "amount": amount,
        "product_ids": listIdProduct,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<BonusProductRes?> getBonusProduct(int bonusProductId) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getBonusProduct(UserInfo().getCurrentStoreCode(), bonusProductId);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllBonusProductRes?> getAllBonusProduct() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllBonusProduct(UserInfo().getCurrentStoreCode());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<MyProgramResponse?> getAllDiscount() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllDisCount(UserInfo().getCurrentStoreCode());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<MyVoucherResponse?> getAllVoucher() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllVoucher(UserInfo().getCurrentStoreCode());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<MyComboResponse?> getAllCombo() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllCombo(UserInfo().getCurrentStoreCode());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<EndVoucherResponse?> getEndVoucherFromPage(int numberPage) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getEndVoucherFromPage(UserInfo().getCurrentStoreCode(), numberPage);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<EndDiscountResponse?> getEndDiscountFromPage(int numberPage) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getEndDiscountFromPage(UserInfo().getCurrentStoreCode(), numberPage);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<EndBonusProductRes?> getEndBonusProduct(
      {required int numberPage}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getEndBonusProduct(UserInfo().getCurrentStoreCode(), numberPage);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<EndComboResponse?> getEndComboFromPage(int numberPage) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getEndComboFromPage(UserInfo().getCurrentStoreCode(), numberPage);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<DeleteProgramResponse?> deleteDiscount(int? idDiscount) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deleteDiscount(UserInfo().getCurrentStoreCode(), idDiscount);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<DeleteProgramResponse?> deleteVoucher(int? idVoucher) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deleteVoucher(UserInfo().getCurrentStoreCode(), idVoucher);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<DeleteProgramResponse?> deleteCombo(int? idCombo) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deleteCombo(UserInfo().getCurrentStoreCode(), idCombo);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CreateVoucherResponse?> createVoucher(
      VoucherRequest voucherRequest) async {
    try {
      var res = await SahaServiceManager().service!.createVoucher(
          UserInfo().getCurrentStoreCode(), voucherRequest.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CreateVoucherResponse?> updateVoucher(
      int? idVoucher, VoucherRequest voucherRequest) async {
    try {
      var res = await SahaServiceManager().service!.updateVoucher(
          UserInfo().getCurrentStoreCode(), idVoucher, voucherRequest.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CreateComboResponse?> updateCombo(
      int? idCombo, ComboRequest comboRequest) async {
    try {
      var res = await SahaServiceManager().service!.updateCombo(
          UserInfo().getCurrentStoreCode(), idCombo, comboRequest.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CreateComboResponse?> createCombo(ComboRequest comboRequest) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .createCombo(UserInfo().getCurrentStoreCode(), comboRequest.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<BonusProductRes?> createBonusProduct(BonusProduct bonusProduct) async {
    try {
      var res = await SahaServiceManager().service!.createBonusProduct(
          UserInfo().getCurrentStoreCode(), bonusProduct.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<BonusProductRes?> updateBonusProduct(
      int? bonusProductId, BonusProduct bonusProduct) async {
    try {
      var res = await SahaServiceManager().service!.updateBonusProduct(
          UserInfo().getCurrentStoreCode(),
          bonusProductId,
          bonusProduct.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> deleteBonusProduct(int? bonusProductId) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deleteBonusProduct(UserInfo().getCurrentStoreCode(), bonusProductId);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<BonusProductRes?> getBonusProductItem(
      {required int bonusProductId, required int groupProduct}) async {
    try {
      var res = await SahaServiceManager().service!.getBonusProductItem(
          UserInfo().getCurrentStoreCode(), bonusProductId, groupProduct);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<BonusProductRes?> addBonusProductItem(
      {required int bonusProductId, required BonusProduct bonusProduct}) async {
    try {
      var res = await SahaServiceManager().service!.addBonusProductItem(
          UserInfo().getCurrentStoreCode(),
          bonusProductId,
          bonusProduct.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<BonusProductRes?> updateBonusProductItem(
      {required int bonusProductId, required BonusProduct bonusProduct}) async {
    try {
      var res = await SahaServiceManager().service!.updateBonusProductItem(
          UserInfo().getCurrentStoreCode(),
          bonusProductId,
          bonusProduct.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> deleteBonusProductItem(
      {required int bonusProductId, required BonusProduct bonusProduct}) async {
    try {
      var res = await SahaServiceManager().service!.deleteBonusProductItem(
          UserInfo().getCurrentStoreCode(),
          bonusProductId,
          {"group_product": bonusProduct.groupProduct});
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllVoucherCodeRes?> getAllVoucherCode(
      {required int voucherId,
      required int page,
      int? status,
      String? search}) async {
    try {
      var res = await SahaServiceManager().service!.getAllVoucherCode(
          UserInfo().getCurrentStoreCode(), voucherId, page, status, search);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> endVoucherCode(
      {required int voucherId, required List<int> voucherIds}) async {
    try {
      var res = await SahaServiceManager().service!.endVoucherCode(
          UserInfo().getCurrentStoreCode(),
          voucherId,
          {"voucher_code_ids": voucherIds.toList()});
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<VoucherRes?> getVoucher({required int voucherId}) async {
    try {
      var res = await SahaServiceManager().service!.getVoucher(
            UserInfo().getCurrentStoreCode(),
            voucherId,
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllProductVoucherRes?> getAllProductVoucher(
      {required int page, required int voucherId}) async {
    try {
      var res = await SahaServiceManager().service!.getAllProductVoucher(
            page,
            UserInfo().getCurrentStoreCode(),
            voucherId,
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
