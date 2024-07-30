import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';

import '../../data/remote/response-request/payment_method/all_payment_method_res.dart';

class ConfigPaymentController extends GetxController {
  var loadInit =false.obs;
  // var listNamePaymentMethod = RxList<String?>();
  // var listUsePaymentMethod = RxList<bool?>();
  // var listIdPaymentMethod = RxList<int>();
  // var listDefineField = RxList<List<dynamic>?>();
  // var listFieldResponse = RxList<List<dynamic>?>();
  // var listFieldRequest = RxList<Map<String, dynamic>>();
  // List<List<dynamic>> listConfig = [];
  // var listTextEditingController = RxList<List<TextEditingController>>();
  var listPaymentMethod = RxList<PaymentMethod>();
  ConfigPaymentController() {
    getPaymentMethod();
  }

  Future<void> getPaymentMethod() async {
    // listNamePaymentMethod([]);
    // listUsePaymentMethod([]);
    // listIdPaymentMethod([]);
    // listDefineField([]);
    // listFieldResponse([]);
    // listFieldRequest([]);
    loadInit.value = true;
    try {
      var res = await RepositoryManager.paymentRepository.getPaymentMethod();
      listPaymentMethod.value = res!.data!;
      loadInit.value = false;
      // res!.data!.forEach((element) {
      //   listNamePaymentMethod.add(element["name"]);
      //   listUsePaymentMethod.add(element["use"]);
      //   listIdPaymentMethod.add(element["id"]);
      //   listDefineField.add(element["define_field"]);
      //   listFieldResponse.add(element["field"]);
      // });

      // listFieldResponse.forEach((e) {
      //   var index = listFieldResponse.indexOf(e);

      //   var listItemInput = Map<String, dynamic>();
      //   var listItemConfig = [];
      //   List<TextEditingController> listEditingController = [];
      //   e!.forEach((item) {
      //     print("=========>>>>>$item");
      //     if (res.data![index]["config"] != null) {
      //       listItemConfig.add(res.data![index]["config"][item]);
      //     } else {
      //       listItemConfig.add([]);
      //     }

      //     var value = res.data![index]["config"] == null ||
      //             res.data![index]["config"][item] == null
      //         ? ""
      //         : res.data![index]["config"][item].toString();

      //     var textEd = new TextEditingController();
      //     textEd.text = value;

      //     listEditingController.add(textEd);
      //     listItemInput[item] = value;
      //     print("====$listItemInput");
      //   });


      //   listTextEditingController.add(listEditingController);
      //   listFieldRequest.add(listItemInput);
      //   print("====$listFieldRequest");
      //   listConfig.add(listItemConfig);

      //   print(listTextEditingController[0].length.toString() + "xxxx");
      // });

    } catch (err) {
      print(err);
      SahaAlert.showError(message: err.toString());
    }
  }

  void resetData() {
    // listNamePaymentMethod([]);
    // listUsePaymentMethod([]);
    // listIdPaymentMethod([]);
    // listDefineField([]);
    // listFieldResponse([]);
    // listTextEditingController([]);
    // listFieldRequest([]);
    getPaymentMethod();
  }

  Future<void> upDatePaymentMethod(
      int? idPaymentMethod, Map<String, dynamic>? body, bool? use,
      {bool back = true}) async {
    try {
      body?["use"] = use;
      var res = await RepositoryManager.paymentRepository
          .upDatePaymentMethod(idPaymentMethod, body);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    resetData();
  }
}
