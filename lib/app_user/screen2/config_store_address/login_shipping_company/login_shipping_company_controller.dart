import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/shipment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class LoginShippingCompanyController extends GetxController {
  final Shipment shipment;
  LoginShippingCompanyController({required this.shipment});
  var phone = TextEditingController();
  var password = TextEditingController();
  var customerCode = TextEditingController();
  var contractCode = TextEditingController();
  var partnerId = TextEditingController();
  String? token;
  Future<void> loginVietnamPost() async {
    try {
      var res =
          await RepositoryManager.addressRepository.loginVietnamPost(login: {
        "CONTRACTCODE": contractCode.text,
        "CUSTOMERCODE": customerCode.text,
        "PASSWORD": password.text,
        "USERNAME": phone.text
      });
      token = res!.data!.token;
      await addTokenShipment(shipment.id);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> loginViettelPost() async {
    try {
      var res = await RepositoryManager.addressRepository.loginViettelPost(
          login: {"PASSWORD": password.text, "USERNAME": phone.text});
      token = res!.data!.token;
      await addTokenShipment(shipment.id);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
    Future<void> loginNhatTin() async {
    try {
      var res = await RepositoryManager.addressRepository.loginNhatTin(
          login: {"PASSWORD": password.text, "USERNAME": phone.text,"PARTNERID" : partnerId.text});
      token = res!.data!.token;
      await addTokenShipment(shipment.id);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
    Future<void> addTokenShipment(
      int? shipmentId,) async {
    try {
      var res = await RepositoryManager.addressRepository.addTokenShipment(
        shipmentId,
        ShipperConfig(
          use: true,
          token: token
        ),
      );
     
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
