import 'dart:io';

import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/distribute/elm_request.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/distribute/sub_request.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/product/product_request.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/utils/image_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

class DistributeUpdateController extends GetxController {
  var listDistribute = RxList<DistributesRequest>();
  var stringTextSuggestion = "";
  var checkSetPriceInventory = false.obs;

  final listSuggestion = [
    "Màu sắc",
    "Kích thước",
  ];

  int productId;

  DistributeUpdateController({required this.productId}) {
    listDistribute([
      DistributesRequest(
          name: "Màu sắc",
          boolHasImage: false)
    ]);
  }

  Future<void> addElmDistribute(
      {required String elmName, required String elmValue}) async {
    try {
      var data = await RepositoryManager.distributeRepository.addElmDistribute(
          productId: productId, elmName: elmName, elmValue: elmValue);
      castToDistributeRequest(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> addSubDistribute(
      {required String subName, required String subValue}) async {
    try {
      var data = await RepositoryManager.distributeRepository.addSubDistribute(
          productId: productId, subName: subName, subValue: subValue);
      castToDistributeRequest(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateElmDistribute({
    required ElmRequest elmRequest,
  }) async {
    try {
      var data = await RepositoryManager.distributeRepository
          .updateElmDistribute(productId: productId, elmRequest: elmRequest);
      castToDistributeRequest(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateSubDistribute({
    required SubRequest subRequest,
  }) async {
    try {
      var data = await RepositoryManager.distributeRepository
          .updateSubDistribute(productId: productId, subRequest: subRequest);
      castToDistributeRequest(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteElmDistribute({
    required String name,
  }) async {
    try {
      var data = await RepositoryManager.distributeRepository
          .deleteElmDistribute(productId: productId, name: name);
      castToDistributeRequest(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteSubDistribute({
    required String name,
  }) async {
    try {
      var data = await RepositoryManager.distributeRepository
          .deleteSubDistribute(productId: productId, name: name);
      castToDistributeRequest(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void castToDistributeRequest(List<Distributes> distributes) {
    if (distributes.isNotEmpty) {
      listDistribute(distributes.map((Distributes? listDistribute) {
        bool boolHasImage = false;
        if (listDistribute!.elementDistributes != null) {
          var listOK = listDistribute.elementDistributes!
              .where((elementDistribute) => elementDistribute.imageUrl != null);

          if (listOK.length > 0) {
            boolHasImage = true;
          }
        }

        return DistributesRequest(
            boolHasImage: boolHasImage,
            name: listDistribute.name,
            subElementDistributeName: listDistribute.subElementDistributeName,
            elementDistributes: listDistribute.elementDistributes!
                .map((e) => ElementDistributesRequest(
                      id: e.id,
                      name: e.name,
                      imageUrl: e.imageUrl,
                      price: e.price,
                      barcode: e.barcode,
                      stock: e.stock,
                      priceCapital: e.priceCapital,
                      priceImport: e.priceImport,
                      defaultPrice: e.defaultPrice,
                      subElementDistribute: e.subElementDistribute == null
                          ? null
                          : e.subElementDistribute!
                              .map((e) => SubElementDistributeRequest(
                                  id: e.id,
                                  name: e.name,
                                  priceImport: e.priceImport,
                                  priceCapital: e.priceCapital,
                                  defaultPrice: e.defaultPrice,
                                  price: e.price,
                                  barcode: e.barcode,
                                  stock: e.stock))
                              .toList(),
                    ))
                .toList());
      }).toList());
    }
  }

  void addDistribute(String? name) {
    if (name == null) {
      var name = getNameNewDistribute();

      listDistribute.add(DistributesRequest(
          name: name, elementDistributes: null, boolHasImage: false));
      return;
    }

    for (var element in listDistribute) {
      if (element.name == name) {
        SahaAlert.showError(message: "Phân loại này đã có");
        return;
      }
    }

    listDistribute.add(DistributesRequest(
        name: name, elementDistributes: null, boolHasImage: false));

    print(listDistribute[0].toJson());
    checkSetPriceAndInventory();
  }

  String? getNameNewDistribute() {
    var listNew = listSuggestion.toList();
    listNew.removeWhere(
        (text) => listDistribute.map((detail) => detail.name).contains(text));

    if (listNew.length == 0) {
      return listSuggestion.last;
    }

    return listNew.first;
  }

  void addSubDistributeName(String value) {
    if (listDistribute[0].name == value) {
      SahaAlert.showError(message: "Phân loại này đã có");
      return;
    } else {
      listDistribute[0].subElementDistributeName = value;
      listDistribute.refresh();
      print(listDistribute[0].toJson());
    }
    checkSetPriceAndInventory();
  }

  void toggleHasImage(int indexDistribute) {
    if (listDistribute[indexDistribute] != null) {
      var newDistribute = listDistribute[indexDistribute];
      newDistribute.boolHasImage = !newDistribute.boolHasImage!;
      listDistribute[indexDistribute] = newDistribute;
    }
  }

  void chooseImage(DistributesRequest? distributes,
      ElementDistributesRequest? elementDistributes) async {
    try {
      final picker = ImagePicker();
      final pickedFile = (await picker.getImage(source: ImageSource.gallery))!;
      var file = File(pickedFile.path);
      var fileUp = await ImageUtils.getImageCompress(file);

      var link = await RepositoryManager.imageRepository.uploadImage(fileUp);

      var indexElement = listDistribute[listDistribute.indexOf(distributes)]
          .elementDistributes!
          .indexOf(elementDistributes);
      listDistribute[listDistribute.indexOf(distributes)]
          .elementDistributes![indexElement]!
          .imageUrl = link;
      listDistribute.refresh();
    } catch (err) {
      SahaAlert.showError(message: "Có lỗi khi up ảnh xin thử lại");
    }
  }

  void editNameDistribute(int indexDistribute, String name) {
    if (listDistribute[indexDistribute] != null) {
      if (listDistribute.map((e) => e.name).contains(name)) {
        SahaAlert.showWarning(message: "Phân loại đã có");
        return;
      }
      var newDistribute = listDistribute[indexDistribute];
      newDistribute.name = name;

      listDistribute[indexDistribute] = newDistribute;
    }
  }

  void checkSetPriceAndInventory() {
    if (listDistribute.isNotEmpty) {
      if (listDistribute[0].name != null) {
        if (listDistribute[0].elementDistributes != null &&
            listDistribute[0].elementDistributes![0]!.name != null) {
          if (listDistribute[0].subElementDistributeName != null) {
            if (listDistribute[0]
                    .elementDistributes![0]!
                    .subElementDistribute !=
                null) {
              if (listDistribute[0]
                  .elementDistributes![0]!
                  .subElementDistribute!
                  .isNotEmpty) {
                checkSetPriceInventory.value = true;
              } else {
                checkSetPriceInventory.value = false;
              }
            } else {
              checkSetPriceInventory.value = false;
            }
          } else {
            checkSetPriceInventory.value = true;
          }
        } else {
          checkSetPriceInventory.value = false;
        }
      } else {
        checkSetPriceInventory.value = false;
      }
    } else {
      checkSetPriceInventory.value = false;
    }
  }
}
