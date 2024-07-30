import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/request_payment.dart';
import 'package:tiengviet/tiengviet.dart';

class ListRequestPaymentSaleController extends GetxController {
  var listRequestPaymentShow = RxList<RequestPayment>();

  var indexWidget = 0.obs;
  List<RequestPayment> listInit = [];

  var indexInit = RxList<int>();

  var isSearch = false.obs;
  var chooseAll = false.obs;
  TextEditingController inputTextEditingController = TextEditingController();
  var paymentOneOfMonth = false.obs;
  var payment16OfMonth = false.obs;
  bool? isSettlement;
  ListRequestPaymentSaleController({this.isSettlement}) {
    if (isSettlement == true) {
      indexWidget.value = 1;
    }
    getListRequestPaymentAgency();
    getConfigsCollabBonusAgency();
  }

  Future<void> getListRequestPaymentAgency() async {
    try {
      var data = await RepositoryManager.agencyRepository.getListRequestPaymentAgency();
      listInit = data!.data!;
      listRequestPaymentShow(data.data);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> changeStatusPayment(int status) async {
    try {
      print(indexInit);
      if (indexInit.isEmpty) {
        SahaAlert.showError(message: "Chưa chọn CTV cần quyết toán");
      } else {
        var data = await RepositoryManager.ctvRepository
            .changeStatusPayment(status, indexInit.value);
        SahaAlert.showSuccess(message: "Đã cập nhật");
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> settlementPayment() async {
    try {
      var data = await RepositoryManager.ctvRepository.settlementPayment();
      SahaAlert.showSuccess(message: "Đã lên yêu cầu thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void findRequestPayment({bool? isClose}) {
    if (isClose == true) {
      listRequestPaymentShow(listInit);
    } else {
      if (inputTextEditingController.text.isNum) {
        List<RequestPayment> output = listInit
            .where((itemRequest) => '${itemRequest.ctv!.accountNumber}'
                .contains(inputTextEditingController.text))
            .toList();
        listRequestPaymentShow(output);
      } else {
        List<RequestPayment> output = listRequestPaymentShow
            .where((itemRequest) =>
                TiengViet.parse('${itemRequest.ctv!.firstAndLastName!}')
                    .toLowerCase()
                    .contains(TiengViet.parse(inputTextEditingController.text)
                        .toLowerCase()))
            .toList();
        listRequestPaymentShow(output);
      }
    }
  }

  Future<void> checkBoxAction(int index) async {
    listRequestPaymentShow[index].checkChoose =
        !listRequestPaymentShow[index].checkChoose;
    listRequestPaymentShow.refresh();
    listRequestPaymentShow.forEach((find) {
      var index = listInit.indexWhere((init) => find.id == init.id);
      if (index != -1) {
        listInit[index] = find;
      }
    });
    indexInit([]);
    listInit.forEach((element) {
      if (element.checkChoose == true) {
        indexInit.add(element.id!);
      }
    });
  }

  Future<void> getConfigsCollabBonusAgency() async {
    try {
      var data = await RepositoryManager.agencyRepository.getConfigsCollabBonusAgency();
      paymentOneOfMonth.value = data!.data!.payment1OfMonth!;
      payment16OfMonth.value = data.data!.payment16OfMonth!;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  String checkSettlement() {
    var text =
        "Bạn đang bật tự động quyết toán vào ngày ${paymentOneOfMonth.value == true ? "1" : ""} ${paymentOneOfMonth.value == true && payment16OfMonth.value == true ? "và" : ""} ${payment16OfMonth.value == true ? "16" : ""} hàng tháng.\n\nBạn có muốn quyết toán luôn hôm nay không ?";
    return text;
  }
}
