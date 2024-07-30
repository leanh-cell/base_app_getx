import 'package:com.ikitech.store/app_user/model/guess_number_game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../components/saha_user/toast/saha_alert.dart';
import '../../../../../data/remote/response-request/customer/all_group_customer_res.dart';

import '../../../../../data/repository/repository_manager.dart';
import '../../../../../model/agency_type.dart';
import '../../../../../model/image_assset.dart';
import 'add_guess_number_game_screen.dart';

class AddGuessNumberGameController extends GetxController {
  var guessGameReq = GuessNumberGame(listGuessNumberResult: []).obs;
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
  var textResult = TextEditingController();
  var valueGift = TextEditingController();

  ///
  var agencyType = AgencyType().obs;
  var listAgencyType = RxList<AgencyType>();
  ////
  var nameMiniGame = TextEditingController();
  var turnInOneDay = TextEditingController();
  var rangeNumber = TextEditingController();
  ////
  DateTime dateStart = DateTime.now();
  bool checkDayStart = false;
  bool checkDayEnd = false;
  DateTime timeStart = DateTime.now().add(Duration(minutes: 1));
  DateTime dateEnd = DateTime.now();
  DateTime timeEnd = DateTime.now().add(Duration(hours: 2));
  var miniGameRes = GuessNumberGame().obs;
  var character = ResultType.typeNumber.obs;

  AddGuessNumberGameController() {
    guessGameReq.value.images = [];
    guessGameReq.value.timeStart = DateTime(dateStart.year, dateStart.month,
        dateStart.day, timeStart.hour, timeStart.minute, timeStart.second);
    guessGameReq.value.timeEnd = DateTime(dateEnd.year, dateEnd.month,
        dateEnd.day, timeEnd.hour, timeEnd.minute, timeEnd.second);
    guessGameReq.value.applyFor = group.value;
    getAllAgencyType();
    getAllGroupCustomer();
  }

  void setUploadingImages(bool value) {
    uploadingImages.value = value;
  }

  Future<void> getAllAgencyType() async {
    try {
      var data = await RepositoryManager.agencyRepository.getAllAgencyType();
      listAgencyType(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
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

  Future<void> getGuessNumberGame({required int id}) async {
    loadInit.value = true;
    try {
      var res =
          await RepositoryManager.miniGameRepository.getGuessNumberGame(id: id);
      guessGameReq.value = res!.data!;
      await getAllAgencyType();
      await getAllGroupCustomer();
      convertResponse();
      miniGameRes.value = res.data!;
      loadInit.value = false;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> addGuessNumberGame() async {
    if (guessGameReq.value.isGuessNumber == null) {
      SahaAlert.showError(
          message: 'Bạn chưa chọn loại trò chơi, vui lòng chọn lại');
      return;
    }
    if (guessGameReq.value.images!.isEmpty) {
      SahaAlert.showError(message: 'Bạn chưa chọn ảnh nào, vui lòng chọn lại');
      return;
    }
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
    if (guessGameReq.value.isGuessNumber == true &&
        guessGameReq.value.rangeNumber != textResult.text.length) {
      SahaAlert.showError(
          message: 'Mời bạn nhập đáp án với đúng số lượng chữ số đã chọn');
      return;
    }
    if (guessGameReq.value.turnInDay == null) {
      SahaAlert.showError(message: 'Xin vui lòng nhập số lần chơi một ngày');
      return;
    }
    if (guessGameReq.value.listGuessNumberResult!.isEmpty &&
        guessGameReq.value.isGuessNumber == false) {
      SahaAlert.showError(
          message: 'Bạn chưa tạo đáp án cho trò chơi này, vui lòng tạo thêm');
      return;
    }

    try {
      var res = await RepositoryManager.miniGameRepository
          .addGuessNumberGame(guessNumberGame: guessGameReq.value);
      miniGameRes.value = res!.data!;
      SahaAlert.showSuccess(message: 'Thành công');
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> updateGuessNumberGame({required int id}) async {
    try {
      var res = await RepositoryManager.miniGameRepository
          .updateGuessNumberGame(guessNumerGame: guessGameReq.value, id: id);
      SahaAlert.showSuccess(message: 'Thành công');
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> deleteGuessNumberGame({required int id}) async {
    try {
      var res = await RepositoryManager.miniGameRepository
          .deleteGuessNumberGame(id: id);
      SahaAlert.showSuccess(message: 'Thành công');
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  void convertResponse() {
    dateStart = guessGameReq.value.timeStart!;
    dateEnd = guessGameReq.value.timeEnd!;
    timeStart = guessGameReq.value.timeStart!;
    timeEnd = guessGameReq.value.timeEnd!;
    group.value = guessGameReq.value.applyFor ?? 0;
    groupCustomer.value = listGroupCus.firstWhere(
        (e) => e.id == guessGameReq.value.groupCustomerId,
        orElse: () => GroupCustomer());
    agencyType.value = listAgencyType.firstWhere(
        (e) => e.id == guessGameReq.value.agencyId,
        orElse: () => AgencyType());

    listImages((guessGameReq.value.images ?? [])
        .map((e) => ImageData(linkImage: e))
        .toList());

    nameMiniGame.text = guessGameReq.value.name ?? '';
    turnInOneDay.text = guessGameReq.value.turnInDay.toString();
    description.text = guessGameReq.value.description ?? '';
    textResult.text = '${guessGameReq.value.textResult ?? ''}';
    rangeNumber.text = '${guessGameReq.value.rangeNumber ?? ''}';
    valueGift.text = guessGameReq.value.valueGift ?? '';
    if (guessGameReq.value.isGuessNumber == false) {
      character.value = ResultType.typeListResult;
    } else {
      print('abc');
      character.value = ResultType.typeNumber;
    }
  }
}
