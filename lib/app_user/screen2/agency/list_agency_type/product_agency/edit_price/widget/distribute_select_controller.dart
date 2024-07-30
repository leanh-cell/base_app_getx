import 'dart:io';

import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/product/product_request.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/utils/image_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

class DistributeSelectController extends GetxController {
  var listDistribute = RxList<DistributesRequest>();
  var stringTextSuggestion = "";
  var checkSetPriceInventory = false.obs;

  final listSuggestion = [
    "Màu sắc",
    "Kích thước",
  ];

  DistributeSelectController() {
    listDistribute([
      DistributesRequest(
          name: "Màu sắc",
          subElementDistributeName: "Kích thước",
          boolHasImage: false)
    ]);
    checkSetPriceAndInventory();
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

  void removeSubElementDistribute() {
    listDistribute[0].subElementDistributeName = null;
    if (listDistribute[0].elementDistributes != null) {
      listDistribute[0].elementDistributes!.forEach((e) {
        e!.subElementDistribute = null;
      });
    }
    listDistribute.refresh();
    checkSetPriceAndInventory();
  }

  void removeDistribute(int indexDistribute) {
    var distribute = listDistribute[0];

    if (distribute.subElementDistributeName == null) {
      listDistribute.remove(listDistribute[indexDistribute]);
    } else {
      if (distribute.elementDistributes != null) {
        var listNameSubElement = distribute
            .elementDistributes![0]!.subElementDistribute!
            .map((e) => e.name)
            .toList();
        listDistribute([
          DistributesRequest(
              name: distribute.subElementDistributeName!,
              elementDistributes: listNameSubElement
                  .map((e) => ElementDistributesRequest(
                        name: e,
                      ))
                  .toList())
        ]);
      } else {
        listDistribute([
          DistributesRequest(name: listDistribute[0].subElementDistributeName)
        ]);
      }
    }
    checkSetPriceAndInventory();
    print(listDistribute[0].toJson());
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

  void addElementDistribute(int indexDistribute, String name) {
    if (listDistribute[indexDistribute] != null) {
      if (listDistribute[indexDistribute].elementDistributes != null) {
        if (listDistribute[indexDistribute].elementDistributes![0]!.name ==
            null) {
          listDistribute[indexDistribute].elementDistributes![0]!.name = name;
        } else {
          if (listDistribute[indexDistribute]
              .elementDistributes!
              .map((e) => e!.name)
              .contains(name)) {
            SahaAlert.showWarning(message: "Thuộc tính đã có");
            return;
          }
          if (listDistribute[0].elementDistributes![0]!.subElementDistribute !=
              null) {
            var listNameSubElement = listDistribute[0]
                .elementDistributes![0]!
                .subElementDistribute!
                .map((e) => e.name)
                .toList();
            listDistribute[indexDistribute].elementDistributes!.add(
                ElementDistributesRequest(
                    name: name,
                    subElementDistribute: listNameSubElement
                        .map((e) => SubElementDistributeRequest(name: e))
                        .toList()));
          } else {
            listDistribute[indexDistribute].elementDistributes!.add(
                ElementDistributesRequest(
                    name: name, subElementDistribute: null));
          }
        }
      } else {
        listDistribute[indexDistribute].elementDistributes = [
          ElementDistributesRequest(
            name: name,
          )
        ];
      }
    }
    print(listDistribute[0].toJson());
    checkSetPriceAndInventory();
  }

  void addSubElementDistribute(String name) {
    if (listDistribute[0].elementDistributes == null) {
      listDistribute[0].elementDistributes = [
        ElementDistributesRequest(
            subElementDistribute: [SubElementDistributeRequest(name: name)])
      ];
    } else {
      var listNameDistribute;
      if (listDistribute[0].elementDistributes![0]!.subElementDistribute !=
          null) {
        listNameDistribute = listDistribute[0]
            .elementDistributes![0]!
            .subElementDistribute!
            .map((e) => e.name)
            .toList();
      }

      if (listDistribute[0].elementDistributes![0]!.subElementDistribute !=
          null) {
        if (listNameDistribute.contains(name)) {
          SahaAlert.showWarning(message: "Thuộc tính đã có");
          return;
        } else {
          listDistribute[0]
              .elementDistributes![0]!
              .subElementDistribute!
              .add(SubElementDistributeRequest(name: name));
        }
      } else {
        listDistribute[0].elementDistributes![0]!.subElementDistribute = [
          SubElementDistributeRequest(name: name)
        ];
      }
      listDistribute[0].elementDistributes!.forEach((e) {
        e!.subElementDistribute =
            listDistribute[0].elementDistributes![0]!.subElementDistribute;
      });
    }
    print(listDistribute[0].toJson());
    checkSetPriceAndInventory();
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

  void removeElementDistribute(
      int indexDistribute, ElementDistributesRequest distributes) {
    if (listDistribute[0].elementDistributes!.length == 1) {
      if (listDistribute[0].elementDistributes![0]!.subElementDistribute !=
          null) {
        listDistribute[0].elementDistributes![0] = ElementDistributesRequest(
            name: null,
            subElementDistribute:
                listDistribute[0].elementDistributes![0]!.subElementDistribute);
      } else {
        listDistribute[0].elementDistributes = null;
      }
    } else {
      listDistribute[0].elementDistributes!.remove(distributes);
    }
    checkSetPriceAndInventory();
    print(listDistribute[0].toJson());
  }

  void refresh() {
    listDistribute.refresh();
  }

  List<String?> getListStringBuild(Distributes details) {
    var listNew = listSuggestion.toList();
    listNew.removeWhere(
        (text) => listDistribute.map((detail) => detail.name).contains(text));

    listNew.insert(0, details.name!);
    if (!listNew.contains(listSuggestion.last)) {
      listNew.add(listSuggestion.last);
    }
    return listNew;
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

  bool checkValidParam() {
    for (var itemDistribute in listDistribute) {
      var listCompare = listDistribute.toList()..remove(itemDistribute);

      if (listCompare
          .map((element) => element.name)
          .toList()
          .contains(itemDistribute.name)) {
        SahaAlert.showWarning(
            message: "Có các phân loại trùng nhau xin kiểm tra lại");
        return false;
      }
    }

    for (var itemDistribute in listDistribute) {
      if (itemDistribute.name == null || itemDistribute.name == "") {
        SahaAlert.showWarning(
            message: "Có các phân loại chưa nhập tên, xin kiểm tra lại");
        return false;
      }
    }
    return true;
  }

  List<DistributesRequest> getFinalDistribute() {
    var listRT = listDistribute.toList()
      ..removeWhere((element) {
        return (element.name == null ||
            element.name == "" ||
            element.elementDistributes == null ||
            element.elementDistributes!.length == 0);
      });
    return listRT.toList();
  }

  int? quantityCurrent;

  void getQuantityElement() {
    quantityCurrent = 0;
    var distribute = listDistribute;
    if (distribute.isNotEmpty) {
      if (distribute[0].subElementDistributeName == null) {
        distribute[0].elementDistributes!.forEach((element) {
          if (element?.quantityInStock != null) {
            quantityCurrent = quantityCurrent! + element!.quantityInStock!;
          }
        });
      } else {
        if (distribute[0].elementDistributes != null) {
          distribute[0].elementDistributes!.forEach((element) {
            if (element?.subElementDistribute != null) {
              if (distribute[0]
                  .elementDistributes![0]!
                  .subElementDistribute!
                  .isNotEmpty) {
                element!.subElementDistribute!.forEach((e) {
                  if (e.quantityInStock != null) {
                    quantityCurrent = quantityCurrent! + e.quantityInStock!;
                  }
                });
              }
            }
          });
        }
      }
    }
  }
}
