import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';

import 'package:com.ikitech.store/app_user/model/mini_game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/remote/response-request/customer/all_group_customer_res.dart';
import '../../../../../model/agency_type.dart';
import '../../../../../model/image_assset.dart';

class AddMiniGameController extends GetxController {
  var miniGameReq = MiniGame().obs;
  var isLoadingCreate = false.obs;
  var group = 0.obs;
  var listImages = RxList<ImageData>([]);
  var uploadingImages = false.obs;
  var loadInit = false.obs;
  var groupCustomer = GroupCustomer().obs;
  var listProductParam = "";
  var listGroupCus = RxList<GroupCustomer>();
  var description = TextEditingController();

  ///
  var agencyType = AgencyType().obs;
  var listAgencyType = RxList<AgencyType>();
  ////
  var nameMiniGame = TextEditingController();
  var turnInOneDay = TextEditingController();
  ////
  DateTime dateStart = DateTime.now();
  bool checkDayStart = false;
  bool checkDayEnd = false;
  DateTime timeStart = DateTime.now().add(Duration(minutes: 1));
  DateTime dateEnd = DateTime.now();
  DateTime timeEnd = DateTime.now().add(Duration(hours: 2));
  var miniGameRes = MiniGame().obs;
  ////background image
  String? backgroundImageDefault;
  var backgroundImage;
  double? totalPercent;
  ///////
  void setUploadingImages(bool value) {
    uploadingImages.value = value;
  }

  AddMiniGameController() {
    miniGameReq.value.images = [];
    miniGameReq.value.timeStart = DateTime(dateStart.year, dateStart.month,
        dateStart.day, timeStart.hour, timeStart.minute, timeStart.second);
    miniGameReq.value.timeEnd = DateTime(dateEnd.year, dateEnd.month,
        dateEnd.day, timeEnd.hour, timeEnd.minute, timeEnd.second);
    miniGameReq.value.applyFor = group.value;
    getAllAgencyType();
    getAllGroupCustomer();
  }

  Future<void> addMiniGame() async {
    if (checkDayStart == true) {
      SahaAlert.showError(
          message:
              'Vui lòng nhập thời gian bắt đầu trò chơi sau thời gian hiện tại');
      return;
    }
    if (checkDayEnd == true) {
      SahaAlert.showError(
          message: 'Thời gian kết thúc phải sau thời gian bắt đầu');
      return;
    }
    if (miniGameReq.value.turnInDay == null) {
      SahaAlert.showError(message: 'Xin vui lòng nhập số lần chơi một ngày');
      return;
    }
    if (miniGameReq.value.isShake == null) {
      SahaAlert.showError(message: 'Xin vui lòng chọn loại trò chơi');
      return;
    }
    if (miniGameReq.value.typeBackgroundImage == null) {
      SahaAlert.showError(message: 'Xin vui lòng chọn loại hình nền');
      return;
    }
    if (miniGameReq.value.typeBackgroundImage == 0 &&
        backgroundImageDefault == null) {
      SahaAlert.showError(message: 'Xin vui lòng chọn ảnh nền');
      return;
    }
    if (miniGameReq.value.typeBackgroundImage == 1 && backgroundImage == null) {
      SahaAlert.showError(message: 'Xin vui lòng chọn ảnh nền');
      return;
    }
    try {
      if (miniGameReq.value.typeBackgroundImage == 0) {
        miniGameReq.value.backgroundImageUrl = backgroundImageDefault;
      }
      if (miniGameReq.value.typeBackgroundImage == 1) {
        miniGameReq.value.backgroundImageUrl = backgroundImage;
      }
      var res = await RepositoryManager.miniGameRepository
          .addMiniGame(miniGame: miniGameReq.value);
      miniGameRes.value = res!.data!;
      SahaAlert.showSuccess(message: 'Thành công');
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> updateMiniGame({required int id}) async {
    if (checkDayStart == true) {
      SahaAlert.showError(
          message:
          'Vui lòng nhập thời gian bắt đầu trò chơi sau thời gian hiện tại');
      return;
    }
    if (checkDayEnd == true) {
      SahaAlert.showError(
          message: 'Thời gian kết thúc phải sau thời gian bắt đầu');
      return;
    }
    if (miniGameReq.value.turnInDay == null) {
      SahaAlert.showError(message: 'Xin vui lòng nhập số lần chơi một ngày');
      return;
    }
    if (miniGameReq.value.isShake == null) {
      SahaAlert.showError(message: 'Xin vui lòng chọn loại trò chơi');
      return;
    }
    if (miniGameReq.value.typeBackgroundImage == null) {
      SahaAlert.showError(message: 'Xin vui lòng chọn loại hình nền');
      return;
    }
    if (miniGameReq.value.typeBackgroundImage == 0 &&
        backgroundImageDefault == null) {
      SahaAlert.showError(message: 'Xin vui lòng chọn ảnh nền');
      return;
    }
    if (miniGameReq.value.typeBackgroundImage == 1 && backgroundImage == null) {
      SahaAlert.showError(message: 'Xin vui lòng chọn ảnh nền');
      return;
    }
    if (miniGameReq.value.typeBackgroundImage == 0) {
      miniGameReq.value.backgroundImageUrl = backgroundImageDefault;
    }
    if (miniGameReq.value.typeBackgroundImage == 1) {
      miniGameReq.value.backgroundImageUrl = backgroundImage;
    }
    if (miniGameReq.value.isShake == null) {
      SahaAlert.showError(message: 'Xin vui lòng chọn loại trò chơi');
      return;
    }
    try {
      var res = await RepositoryManager.miniGameRepository
          .updateMiniGame(miniGame: miniGameReq.value, id: id);
      SahaAlert.showSuccess(message: 'Thành công');
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> deleteMiniGame({required int id}) async {
    try {
      var res =
          await RepositoryManager.miniGameRepository.deleteMiniGame(id: id);
      SahaAlert.showSuccess(message: 'Thành công');
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> getMiniGame({required int id}) async {
    loadInit.value = true;
    try {
      var res = await RepositoryManager.miniGameRepository.getMiniGame(id: id);
      miniGameReq.value = res!.data!;
      await getAllAgencyType();
      await getAllGroupCustomer();
      convertResponse();
      miniGameRes.value = res.data!;
      totalPercent = miniGameRes.value.listGift!
          .map((e) => e.percentReceived)
          .toList()
          .fold(0, (previousValue, element) => previousValue! + element!);
      loadInit.value = false;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> getAllAgencyType() async {
    try {
      var data = await RepositoryManager.agencyRepository.getAllAgencyType();
      listAgencyType(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void convertResponse() {
    dateStart = miniGameReq.value.timeStart!;
    dateEnd = miniGameReq.value.timeEnd!;
    timeStart = miniGameReq.value.timeStart!;
    timeEnd = miniGameReq.value.timeEnd!;
    group.value = miniGameReq.value.applyFor ?? 0;
    groupCustomer.value = listGroupCus.firstWhere(
        (e) => e.id == miniGameReq.value.groupCustomerId,
        orElse: () => GroupCustomer());
    agencyType.value = listAgencyType.firstWhere(
        (e) => e.id == miniGameReq.value.agencyId,
        orElse: () => AgencyType());

    listImages((miniGameReq.value.images ?? [])
        .map((e) => ImageData(linkImage: e))
        .toList());

    nameMiniGame.text = miniGameReq.value.name ?? '';
    turnInOneDay.text = miniGameReq.value.turnInDay.toString();
    description.text = miniGameReq.value.description ?? '';
    if (miniGameReq.value.typeBackgroundImage == 0) {
      backgroundImageDefault = miniGameReq.value.backgroundImageUrl;
    }
    if (miniGameReq.value.typeBackgroundImage == 1) {
      backgroundImage = miniGameReq.value.backgroundImageUrl;
    }
  }

  Future<void> getAllGroupCustomer() async {
    try {
      var res =
          await RepositoryManager.customerRepository.getAllGroupCustomer(page: 1);
      listGroupCus(res!.data!.data);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
