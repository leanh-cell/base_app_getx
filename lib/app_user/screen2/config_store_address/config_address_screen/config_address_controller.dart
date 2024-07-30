import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/address/address_request.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/info_address.dart';

import '../../../model/location_address.dart';

class ConfigAddressController extends GetxController {
  final InfoAddress? infoAddress;

  ConfigAddressController(this.infoAddress) {
    nameTextEditingController.text = infoAddress!.name ??"";
    phoneTextEditingController.text = infoAddress!.phone ?? "0";
    addressDetailTextEditingController.text = infoAddress!.addressDetail ?? "";
    locationProvince.value.name = infoAddress!.provinceName;
    locationDistrict.value.name = infoAddress!.districtName;
    locationWard.value.name = infoAddress!.wardsName;
    locationProvince.value.id = infoAddress!.province;
    locationDistrict.value.id = infoAddress!.district;
    locationWard.value.id = infoAddress!.wards;
    isDefaultPickup.value = infoAddress!.isDefaultPickup!;
    isDefaultReturn.value = infoAddress!.isDefaultReturn!;
  }

  var locationProvince = LocationAddress().obs;
  var locationDistrict = LocationAddress().obs;
  var locationWard = LocationAddress().obs;
  var isLoadingUpdate = false.obs;
  var isDeletingAddressStore = false.obs;

  var isDefaultPickup = true.obs;
  var isDefaultReturn = true.obs;

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController addressDetailTextEditingController =
      TextEditingController();

  Future<void> updateAddressStore() async {
    isLoadingUpdate.value = true;
    try {
      var res = await RepositoryManager.addressRepository.updateAddressStore(
          infoAddress!.id,
          AddressRequest(
            name: nameTextEditingController.text,
            addressDetail: addressDetailTextEditingController.text,
            country: 1,
            province: locationProvince.value.id,
            district: locationDistrict.value.id,
            wards: locationWard.value.id,
            email: "",
            phone: phoneTextEditingController.text,
            isDefaultPickup: isDefaultPickup.value,
            isDefaultReturn: isDefaultReturn.value,
          ));
      Get.back();
      SahaAlert.showSuccess(message: "Lưu thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingUpdate.value = false;
  }

  Future<void> deleteAddressStore() async {
    isDeletingAddressStore.value = true;
    try {
      var res = await RepositoryManager.addressRepository
          .deleteAddressStore(infoAddress!.id);
      Get.back();
      SahaAlert.showSuccess(message: "Lưu thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isDeletingAddressStore.value = false;
  }
}
