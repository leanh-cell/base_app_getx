import 'package:com.ikitech.store/app_user/data/remote/response-request/address/add_token_shipment_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/address/address_request.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/address/address_respone.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/address/all_address_store_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/address/all_shipment_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/address/create_address_store_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/address/delete_address_store_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/address/login_vietnam_post_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/address/login_viettel_post_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/address/ship_config_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/address/shipment_calculate_req.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/model/ship_config.dart';
import 'package:com.ikitech.store/app_user/model/shipment.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/address_customer/all_address_customer_response.dart';

import '../../remote/response-request/address/shipment_calculate_res.dart';
import '../handle_error.dart';

class AddressRepository {
  Future<AddressResponse?> getProvince() async {
    try {
      var res = await SahaServiceManager().service!.getProvince();
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AddressResponse?> getDistrict(int? idProvince) async {
    try {
      var res = await SahaServiceManager().service!.getDistrict(idProvince);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AddressResponse?> getWard(int? idDistrict) async {
    try {
      var res = await SahaServiceManager().service!.getWard(idDistrict);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CreateAddressStoreResponse?> createAddressStore(
      AddressRequest addressRequest) async {
    try {
      var res = await SahaServiceManager().service!.createAddressStore(
            UserInfo().getCurrentStoreCode(),
            addressRequest.toJson(),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CreateAddressStoreResponse?> updateAddressStore(
      int? idAddressStore, AddressRequest addressRequest) async {
    try {
      var res = await SahaServiceManager().service!.updateAddressStore(
            UserInfo().getCurrentStoreCode(),
            idAddressStore,
            addressRequest.toJson(),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<DeleteAddressStoreResponse?> deleteAddressStore(
      int? idAddressStore) async {
    try {
      var res = await SahaServiceManager().service!.deleteAddressStore(
            UserInfo().getCurrentStoreCode(),
            idAddressStore,
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllAddressStoreResponse?> getAllAddressStore() async {
    try {
      var res = await SahaServiceManager().service!.getAllAddressStore(
            UserInfo().getCurrentStoreCode(),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllShipmentResponse?> getAllShipmentStore() async {
    try {
      var res = await SahaServiceManager().service!.getAllShipmentStore(
            UserInfo().getCurrentStoreCode(),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AddTokenShipmentResponse?> addTokenShipment(
      int? idShipment, ShipperConfig shipperConfig) async {
    try {
      var res = await SahaServiceManager().service!.addTokenShipment(
          UserInfo().getCurrentStoreCode(), idShipment, shipperConfig.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ConfigShipRes?> getConfigShip() async {
    try {
      var res = await SahaServiceManager().service!.getConfigShip(
            UserInfo().getCurrentStoreCode(),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ConfigShipRes?> updateConfigShip(ShipConfig shipConfig) async {
    try {
      var res = await SahaServiceManager().service!.updateConfigShip(
            UserInfo().getCurrentStoreCode(),
            shipConfig.toJson(),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ShipmentCalculateRes?> calculateShipment(
    ShipmentCalculateReq shipmentCalculateReq,
    int idShipment,
  ) async {
    try {
      var res = await SahaServiceManager().service!.calculateShipment(
            UserInfo().getCurrentStoreCode(),
            idShipment,
            shipmentCalculateReq.toJson(),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllIAddressCustomerResponse?> getAllAddressCustomer(
    String phone,
  ) async {
    try {
      var res = await SahaServiceManager().service!.getAllAddressCustomer(
        UserInfo().getCurrentStoreCode(),
        {
          "phone_number": phone,
        },
      );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<LoginVietNamPostRes?> loginVietnamPost(
      {required Map<String, dynamic> login}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .loginVietnamPost(UserInfo().getCurrentStoreCode(), login);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<LoginViettelPostRes?> loginViettelPost(
      {required Map<String, dynamic> login}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .loginViettelPost(UserInfo().getCurrentStoreCode(), login);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

   Future<LoginViettelPostRes?> loginNhatTin(
      {required Map<String, dynamic> login}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .loginNhatTin(UserInfo().getCurrentStoreCode(), login);
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
