import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/shipment.dart';

class AddTokenShipment extends GetxController {
  Shipment? shipment;

  AddTokenShipment({this.shipment});

  var tokenEditingController = new TextEditingController().obs;

  Future<void> addTokenShipment() async {
    try {
      var res = await RepositoryManager.addressRepository.addTokenShipment(
          shipment!.id,
          ShipperConfig(
              token: tokenEditingController.value.text, use: true, cod: true));
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
