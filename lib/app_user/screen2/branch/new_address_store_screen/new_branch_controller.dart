import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/branch.dart';
import 'package:com.ikitech.store/app_user/model/location_address.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';
import 'package:com.ikitech.store/saha_data_controller.dart';

class NewStoreController extends GetxController {
  var locationProvince = LocationAddress().obs;
  var locationDistrict = LocationAddress().obs;
  var locationWard = LocationAddress().obs;
  var isLoadingCreate = false.obs;
  var isDefaultPickup = true.obs;
  var isDefaultReturn = true.obs;

  SahaDataController sahaDataController = Get.find();
  Branch? branchInput;
  Function? callBack;
  NewStoreController({this.branchInput, this.callBack}) {
    if (branchInput != null) {
      branchRequest.value = branchInput!;
      nameTextEditingController.text = branchInput!.name ?? "";
      phoneTextEditingController.text = (branchInput?.phone ?? "").toString();
      textEditingControllerDescription.text = branchInput!.addressDetail ?? "";
      textEditingControllerAddressDetail.text =
          branchInput!.addressDetail ?? "";
      locationProvince.value.name = branchInput!.provinceName;
      locationDistrict.value.name = branchInput!.districtName;
      locationWard.value.name = branchInput!.wardsName;
      locationProvince.value.id = branchInput!.province;
      locationDistrict.value.id = branchInput!.district;
      locationWard.value.id = branchInput!.wards;

      refresh();
    }
  }

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController streetNumberTextEditingController =
      TextEditingController();
  final TextEditingController textEditingControllerDescription =
      new TextEditingController();

  final TextEditingController textEditingControllerAddressDetail =
      new TextEditingController();
  var uploadingImages = false.obs;
  var branchRequest = Branch().obs;

  void setUploadingImages(bool value) {
    uploadingImages.value = value;
  }

  Future<void> addStore() async {
    try {
      branchRequest.value.addressDetail =
          textEditingControllerAddressDetail.text == ""
              ? null
              : textEditingControllerAddressDetail.text;
      branchRequest.value.province = locationProvince.value.id;
      branchRequest.value.district = locationDistrict.value.id;
      branchRequest.value.wards = locationWard.value.id;
      if (branchRequest.value.wards == null ||
          branchRequest.value.addressDetail == null) {
        SahaAlert.showError(message: "Địa chỉ không hợp lệ");
      } else {
        var data = await RepositoryManager.branchRepository
            .createBranch(branchRequest.value);
        SahaAlert.showSuccess(message: "Thêm thành công");
        sahaDataController.getAllBranch();
        Get.back(result: "success");
        if (callBack != null) {
          callBack!("success");
        }
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateStore(int idBranch) async {
    try {
      branchRequest.value.addressDetail =
          textEditingControllerAddressDetail.text;
      branchRequest.value.province = locationProvince.value.id;
      branchRequest.value.district = locationDistrict.value.id;
      branchRequest.value.wards = locationWard.value.id;
      if (branchRequest.value.wards == null) {
        SahaAlert.showError(message: "Chưa chọn địa chỉ");
      } else {
        var data = await RepositoryManager.branchRepository
            .updateBranch(idBranch, branchRequest.value);
        SahaAlert.showSuccess(message: "Sửa thành công");
        await sahaDataController.getAllBranch();
        if (idBranch == UserInfo().getCurrentIdBranch()) {
          sahaDataController.branchCurrent.value = sahaDataController.listBranch
              .where((e) => e.id == idBranch)
              .first;
          print(sahaDataController.branchCurrent.value.name);
          UserInfo().setCurrentNameBranch(
              sahaDataController.branchCurrent.value.name);
          UserInfo()
              .setCurrentBranchId(sahaDataController.branchCurrent.value.id);
        }
        Get.back(result: "success");
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
