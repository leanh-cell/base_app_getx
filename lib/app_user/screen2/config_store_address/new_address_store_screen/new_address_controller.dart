import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/address/address_request.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';

import '../../../model/location_address.dart';

class NewAddressController extends GetxController {
  var locationProvince = LocationAddress().obs;
  var locationDistrict = LocationAddress().obs;
  var locationWard = LocationAddress().obs;

  var isLoadingCreate = false.obs;
  var isDefaultPickup = true.obs;
  var isDefaultReturn = true.obs;

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController addressDetailTextEditingController =
      TextEditingController();

  Future<void> createAddressStore() async {
    isLoadingCreate.value = true;
    try {
      var res = await RepositoryManager.addressRepository
          .createAddressStore(AddressRequest(
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
      await Future.delayed(const Duration(seconds: 1), (){});
      SahaAlert.showSuccess(message: "Lưu thành công");
      Get.back(result: {"add":true});
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingCreate.value = false;
  }
}
