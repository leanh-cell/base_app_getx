import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/location_address.dart';
import 'package:sahashop_customer/app_customer/model/info_customer.dart';

class NewCustomerSaleController extends GetxController {
  var locationProvince = LocationAddress().obs;
  var locationDistrict = LocationAddress().obs;
  var locationWard = LocationAddress().obs;
  var hideSuggest = false.obs;
  var isLoadingCreate = false.obs;
  var listInfoCustomer = RxList<InfoCustomer>();
  var isShowAddress = false.obs;
  var search = "";
  var sortBy = "";
  var descending = false;
  var fieldBy = "";
  var fieldByValue = "";

  int? dayOfBirth;
  int? monthOfBirth;
  int? yearOfBirth;
  var timeInputSearch = DateTime.now();

  var isDoneLoadMore = false.obs;
  var isEndCustomer = false.obs;
  var pageLoadMore = 1;
  var isLoadInit = false.obs;
  var searching = false.obs;
  var voucherCodeChoose = "".obs;
  var customerChoose = InfoCustomer().obs;

  InfoCustomer? infoCustomerInput;
  TextEditingController nameTextEditingController =
      TextEditingController(text: "");
  TextEditingController phoneTextEditingController =
      TextEditingController(text: "");
  TextEditingController addressDetailTextEditingController =
      TextEditingController(text: "");
  TextEditingController emailTextEditingController =
      TextEditingController(text: "");

  NewCustomerSaleController({this.infoCustomerInput}) {
    if (infoCustomerInput != null) {
      locationProvince.value = LocationAddress(
        id: infoCustomerInput!.province,
        name: infoCustomerInput!.provinceName,
      );
      locationDistrict.value = LocationAddress(
        id: infoCustomerInput!.district,
        name: infoCustomerInput!.districtName,
      );
      locationWard.value = LocationAddress(
        id: infoCustomerInput!.wards,
        name: infoCustomerInput!.wardsName,
      );
      customerChoose.value = infoCustomerInput!;
    }

    nameTextEditingController.text = infoCustomerInput?.name ?? "";
    phoneTextEditingController.text = infoCustomerInput?.phoneNumber ?? "";
    addressDetailTextEditingController.text =
        infoCustomerInput?.addressDetail ?? "";
    emailTextEditingController.text = infoCustomerInput?.email ?? "";
  }

  Future<void> addCustomer() async {
    try {
      customerChoose.value.name = nameTextEditingController.text;
      customerChoose.value.phoneNumber = phoneTextEditingController.text;
      customerChoose.value.pass = "123456";
      customerChoose.value.addressDetail =
          addressDetailTextEditingController.text;
      customerChoose.value.email = emailTextEditingController.text;
      customerChoose.value.province = locationProvince.value.id;
      customerChoose.value.district = locationDistrict.value.id;
      customerChoose.value.wards = locationWard.value.id;
      if (customerChoose.value.province != null) {
        if (customerChoose.value.district == null ||
            customerChoose.value.wards == null ||
            customerChoose.value.addressDetail == null ||
            customerChoose.value.addressDetail == "") {
          SahaAlert.showToastMiddle(message: "Địa chỉ chọn chưa hợp lệ");
          return;
        }
      }
      var data = await RepositoryManager.customerRepository
          .addCustomerFromSale(customerChoose.value);
      customerChoose.value = data!.data!;
      Get.back(result: "reload");
      SahaAlert.showSuccess(message: "Thêm thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateCustomer() async {
    try {
      customerChoose.value.name = nameTextEditingController.text;
      customerChoose.value.phoneNumber = phoneTextEditingController.text;
      customerChoose.value.addressDetail =
          addressDetailTextEditingController.text;
      customerChoose.value.email = emailTextEditingController.text;
      customerChoose.value.province = locationProvince.value.id;
      customerChoose.value.district = locationDistrict.value.id;
      customerChoose.value.wards = locationWard.value.id;
      if (customerChoose.value.province != null) {
        if (customerChoose.value.district == null ||
            customerChoose.value.wards == null ||
            customerChoose.value.addressDetail == null ||
            customerChoose.value.addressDetail == "") {
          SahaAlert.showToastMiddle(message: "Địa chỉ chọn chưa hợp lệ");
          return;
        }
      }
      var data = await RepositoryManager.customerRepository
          .updateCustomerFromSale(infoCustomerInput!.id!, customerChoose.value);
      Get.back(result: "reload");
      SahaAlert.showSuccess(message: "Chỉnh sửa thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteCustomer() async {
    try {
      var data = await RepositoryManager.customerRepository
          .deleteCustomerFromSale(infoCustomerInput!.id!);
      SahaAlert.showSuccess(message: "Đã xoá");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
