import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/handle_error.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/location_address.dart';
import 'package:com.ikitech.store/app_user/model/supplier.dart';

class AddSuppliersController extends GetxController {
  var locationProvince = LocationAddress().obs;
  var locationDistrict = LocationAddress().obs;
  var locationWard = LocationAddress().obs;

  var isLoadingCreate = false.obs;
  var supplier = Supplier().obs;
  Supplier? supplierInput;

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController addressDetailTextEditingController =
      TextEditingController();

  AddSuppliersController({this.supplierInput}) {
    if (supplierInput != null) {
      locationProvince.value = LocationAddress(
        id: supplierInput!.province,
        name: supplierInput!.provinceName,
      );
      locationDistrict.value = LocationAddress(
        id: supplierInput!.district,
        name: supplierInput!.districtName,
      );
      locationWard.value = LocationAddress(
        id: supplierInput!.wards,
        name: supplierInput!.wardsName,
      );
      supplier.value = supplierInput!;
    }

    nameTextEditingController.text = supplierInput?.name ?? "";
    phoneTextEditingController.text = supplierInput?.phone ?? "";
    addressDetailTextEditingController.text =
        supplierInput?.addressDetail ?? "";
  }

  Future<void> createSuppliers() async {
    supplier.value.name = nameTextEditingController.text;
    supplier.value.phone = phoneTextEditingController.text;
    supplier.value.addressDetail = addressDetailTextEditingController.text;
    supplier.value.province = locationProvince.value.id;
    supplier.value.district = locationDistrict.value.id;
    supplier.value.wards = locationWard.value.id;
    try {
      var data = await RepositoryManager.supplierRepository
          .createSuppliers(supplier.value);
      Get.back(result: "reload");
    } catch (err) {
      SahaAlert.showToastMiddle(message: err.toString());
    }
  }

  Future<void> updateSuppliers() async {
    try {
      supplier.value.name = nameTextEditingController.text;
      supplier.value.phone = phoneTextEditingController.text;
      supplier.value.addressDetail = addressDetailTextEditingController.text;
      supplier.value.province = locationProvince.value.id;
      supplier.value.district = locationDistrict.value.id;
      supplier.value.wards = locationWard.value.id;
      var data = await RepositoryManager.supplierRepository
          .updateSuppliers(supplier.value, supplierInput!.id!);
      SahaAlert.showSuccess(message: "Chỉnh sửa thành công");
      Get.back(result: "reload");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteSuppliers() async {
    try {
      var data = await RepositoryManager.supplierRepository
          .deleteSuppliers(supplierInput!.id!);
      SahaAlert.showSuccess(message: "Đã xoá");
      Get.back();
      Get.back(result: "reload");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
