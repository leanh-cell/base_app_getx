import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/gift.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddGiftController extends GetxController {
  var giftReq = Gift().obs;
  var loadInit = false.obs;
  int spinId;
  int? id;
  AddGiftController({this.id, required this.spinId}) {
    if (id != null) {
      getGift();
    }
  }
  ////
  var giftName = TextEditingController();
  var typeTextEditingController = TextEditingController();
  var amountCoin = TextEditingController();
  var text = TextEditingController();
  var amountGift = TextEditingController();
  var percentReceived = TextEditingController();

  ///
  ///
  Future<void> getGift() async {
    loadInit.value = true;
    try {
      var res = await RepositoryManager.miniGameRepository
          .getGift(id: id!, spinId: spinId);
      giftReq.value = res!.data!;
      convertResponse();
      loadInit.value = false;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> addGift({required int spinId}) async {
    // if (giftReq.value.imageUrl == null) {
    //   SahaAlert.showError(message: "Bạn chưa chọn ảnh");
    //   return;
    // }
    if ((giftReq.value.percentReceived ?? 0) >= 10000) {
      SahaAlert.showError(message: "Bạn không được nhập quá 10000 %");
      return;
    }
    try {
      giftReq.value.spinWheelId = spinId;
      var res = await RepositoryManager.miniGameRepository
          .addGift(gift: giftReq.value, spinId: spinId);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> updateGift() async {
    if (giftReq.value.imageUrl == null) {
      SahaAlert.showError(message: "Bạn chưa chọn ảnh");
      return;
    }
    if ((giftReq.value.percentReceived ?? 0) >= 10000) {
      SahaAlert.showError(message: "Bạn không được nhập quá 10000 %");
      return;
    }
    try {
      var res = await RepositoryManager.miniGameRepository
          .updateGift(id: id!, spinId: spinId, gift: giftReq.value);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> deleteGift() async {
    try {
      var res = await RepositoryManager.miniGameRepository
          .deleteGift(id: id!, spinId: spinId);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  void convertResponse() {
    giftName.text = giftReq.value.name ?? '';
    typeTextEditingController.text = giftReq.value.typeGift == 0
        ? 'Thưởng xu'
        : giftReq.value.typeGift == 1
            ? 'Quà trong hệ thống'
            : 'Quà khác';
    amountCoin.text = giftReq.value.amountCoin.toString();

    text.text = giftReq.value.text ?? '';
    amountGift.text = giftReq.value.amountGift.toString();

    percentReceived.text = giftReq.value.percentReceived.toString();
  }
}
