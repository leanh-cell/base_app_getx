import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/info_address.dart';
import 'package:com.ikitech.store/app_user/model/ship_config.dart';
import 'package:com.ikitech.store/app_user/model/shipment.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';

import '../../model/location_address.dart';

class ConfigStoreAddressController extends GetxController {
  var isLoadingAddress = false.obs;
  var listAddressStore = InfoAddress().obs;
  var listShipmentStore = RxList<Shipment>();
  var shipConfig = ShipConfig().obs;
  List<LocationAddress> listLocationAddress = [];
  TextEditingController urbanTextEditingController = TextEditingController();
  TextEditingController suburbanTextEditingController = TextEditingController();
  TextEditingController desTextEditingController = TextEditingController();
  ConfigStoreAddressController() {
    getAllAddressStore();
    getAllShipmentStore();
    getConfigShip();
  }

  Future<void> addTokenShipment(
      int? shipmentId, ShipperConfig shipperConfig) async {
    try {
      var res = await RepositoryManager.addressRepository.addTokenShipment(
        shipmentId,
        shipperConfig,
      );
      getAllShipmentStore();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getAllAddressStore() async {
    isLoadingAddress.value = true;
    try {
      var res = await RepositoryManager.addressRepository.getAllAddressStore();
      res!.data!.forEach((element) {
        if (element.isDefaultPickup == true) {
          listAddressStore.value = element;
        }
      });
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingAddress.value = false;
  }

  Future<void> getAllShipmentStore() async {
    try {
      var res = await RepositoryManager.addressRepository.getAllShipmentStore();
      listShipmentStore(res!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getConfigShip() async {
    try {
      var res = await RepositoryManager.addressRepository.getConfigShip();
      shipConfig(res!.data!);
      urbanTextEditingController.text =
          SahaStringUtils().convertToUnit(shipConfig.value.feeUrban ?? 0);
      suburbanTextEditingController.text =
          SahaStringUtils().convertToUnit(shipConfig.value.feeSuburban ?? 0);
      desTextEditingController.text =
          shipConfig.value.feeDefaultDescription ?? '';
      listLocationAddress = (shipConfig.value.urbanListIdProvince ?? [])
          .map((e) => LocationAddress(id: e))
          .toList();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateConfigShip() async {
    shipConfig.value.feeUrban = double.tryParse(
        SahaStringUtils().convertFormatText(urbanTextEditingController.text));
    shipConfig.value.feeSuburban = double.tryParse(SahaStringUtils()
        .convertFormatText(suburbanTextEditingController.text));
    shipConfig.value.feeDefaultDescription = desTextEditingController.text;
    shipConfig.value.urbanListIdProvince =
        listLocationAddress.map((e) => e.id!).toList();
    try {
      var res = await RepositoryManager.addressRepository
          .updateConfigShip(shipConfig.value);
      shipConfig(res!.data!);
      SahaAlert.showSuccess(message: "Đã lưu");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void refreshData() async {
    await getAllShipmentStore();
    await getAllAddressStore();
    listShipmentStore.refresh();
  }
}
