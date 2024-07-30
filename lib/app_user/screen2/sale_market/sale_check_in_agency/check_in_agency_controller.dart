import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';

import '../../../components/saha_user/dialog/dialog.dart';
import '../../../model/agency.dart';
import '../../../model/image_assset.dart';
import '../../../model/info_customer.dart';
import '../../../model/sale_check_in.dart';

class CheckInAgencyController extends GetxController {
  var infoCustomer = InfoCustomer().obs;
  var agency = Agency().obs;
  int agencyId;
  var loadInit = false.obs;
  var timeVisit = Duration().obs;
  var listImages = RxList<ImageData>([]);
  var saleCheckIn = SaleCheckIn(isAgencyOpen: true).obs;
  var noteTextEditingController = TextEditingController();
  double? longitude;
  double? latitude;

  CheckInAgencyController({required this.agencyId}) {
    getAgencyForSale();
  }

  Future<void> getAgencyForSale() async {
    loadInit.value = true;
    try {
      var data = await RepositoryManager.agencyRepository
          .getAgencyForSale(agencyId: agencyId);
      agency.value = data!.data!;
      infoCustomer.value = data.data!.customer!;
      countTimeVisit();
      noteTextEditingController.text =
          agency.value.staffSaleVisitAgency?.note ?? '';
      listImages((agency.value.staffSaleVisitAgency?.images ?? [])
          .map((e) => ImageData(linkImage: e))
          .toList());
      saleCheckIn.value.images = agency.value.staffSaleVisitAgency?.images;
      loadInit.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void countTimeVisit() {
    if (agency.value.staffSaleVisitAgency?.timeCheckout == null) {
      Timer.periodic(Duration(seconds: 1), (timer) {
        timeVisit.value = DateTime.now().difference(
            agency.value.staffSaleVisitAgency?.timeCheckin ?? DateTime.now());
      });
    } else {
      timeVisit.value = (agency.value.staffSaleVisitAgency?.timeCheckout ??
              DateTime.now())
          .difference(
              agency.value.staffSaleVisitAgency?.timeCheckin ?? DateTime.now());
    }
  }

  Future<void> checkOutAgency({bool? isCheckOut}) async {
    try {
      var res = await RepositoryManager.agencyRepository.checkOutAgency(
          saleCheckIn: saleCheckIn.value,
          idCheckIn: agency.value.staffSaleVisitAgency?.id ?? 0);
      if (isCheckOut == true) {
        SahaAlert.showSuccess(message: "Thành công");
        Get.back();
      }
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> initFind() async {
    Position position = await _getGeoLocationPosition();
    var location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
    latitude = position.latitude;
    longitude = position.longitude;
    saleCheckIn.value.longCheckout = longitude;
    saleCheckIn.value.latCheckout = latitude;
    print(location);
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      SahaAlert.showError(message: 'Chưa bật dịch vụ định vị');
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        SahaAlert.showError(
            message: 'Thiết bị chưa cho phép quyền truy cập vị trí');
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      SahaAlert.showError(
          message:
              'Quyền vị trí bị từ chối vĩnh viễn, chúng tôi không thể yêu cầu quyền');
      SahaDialogApp.showDialogYesNo(
          mess:
              "Bạn chưa cấp quyền truy cập vị trí,bạn có muốn bật quyền truy cập vị trí cho ứng dụng?",
          onOK: () async {
            await Geolocator.openLocationSettings();
          });
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
