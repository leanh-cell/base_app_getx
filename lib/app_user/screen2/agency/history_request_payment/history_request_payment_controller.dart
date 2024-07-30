import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/request_payment.dart';
import 'package:tiengviet/tiengviet.dart';

class HistoryRequestPaymentSaleController extends GetxController {
  var listRequestPaymentShow = RxList<RequestPayment>();

  var indexWidget = 0.obs;

  List<RequestPayment> listInit = [];

  List<int> indexInit = [];

  var isSearch = false.obs;
  TextEditingController inputTextEditingController = TextEditingController();

  HistoryRequestPaymentSaleController() {
    getListRequestPaymentAgency();
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

    indexInit = [];
    listInit.forEach((element) {
      if (element.checkChoose == true) {
        indexInit.add(element.id!);
      }
    });

  }
}
