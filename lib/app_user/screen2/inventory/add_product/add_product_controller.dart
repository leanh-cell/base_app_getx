import 'dart:io';

import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/inventory/inventory_request.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/product/product_request.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/image_assset.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/add_product/widget/distribute_select_controller.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:sahashop_customer/app_customer/model/attribute_search.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import 'inventory_edit/inventory_product_screen.dart';
import 'dart:math';

class AddProductController extends GetxController {
  ProductRequest productRequest = new ProductRequest();
  var listCategorySelected = RxList<Category>();
  var listCategorySelectedChild = RxList<Category>();
  var listAttributeSearchSelected = RxList<AttributeSearch>();
  var listAttributeSearchSelectedChild = RxList<AttributeSearch>();
  var listAttribute = RxList<String>();
  var listAttributeUpdate = RxList<String>();
  var listCategory = RxList<Category>();
  var isLoadingAdd = false.obs;
  var isLoadingCategory = false.obs;
  var isLoadingAttribute = false.obs;
  var isContactPrice = false.obs;
  var isDistribute = false.obs;
  var isMedicine = false.obs;
  var videoUrl = "".obs;
  var loadInit = false.obs;
  var listProductRetail = <ProductRetailStep>[];
  var isProductRetailStep = false.obs;
  File? file;
  bool? isEdit = false;
  var productEdit = Product().obs;

  var listDistribute = RxList<DistributesRequest>();
  final List<DistributesRequest> listDistributeInit = [];

  var listImages = RxList<ImageData>([]);
  var uploadingImages = false.obs;

  var attributeData = {}.obs;

  final TextEditingController textEditingControllerName =
      new TextEditingController();

  final TextEditingController shelfPositionEdit = new TextEditingController();

  var textEditingControllerBarcode = TextEditingController().obs;
  var textEditingControllerSKU = TextEditingController().obs;
  var textEditingControllerWeight = TextEditingController();

  final TextEditingController textEditingControllerPrice =
      new TextEditingController();

  final TextEditingController textEditingControllerPriceImport =
      new TextEditingController();

  final TextEditingController textEditingControllerPriceCapital =
      new TextEditingController();

  final TextEditingController textEditingControllerQuantityInStock =
      new TextEditingController();

  final TextEditingController textEditingControllerPercentRose =
      new TextEditingController();

  final TextEditingController textEditingControllerBonusPoint =
      new TextEditingController();
  final TextEditingController textEditingControllerContentCTV =
      new TextEditingController();

  var description = "".obs;

  Product? productInput;

  Random random = new Random();

  AddProductController({this.productInput}) {
    getAllCategory();
    if (productInput != null) {
      getOneProduct(productInput!.id!);
    } else {
      getAllAttribute();
      int randomNumber = random.nextInt(1000000000);
      textEditingControllerSKU.value.text = '$randomNumber';
      productRequest.sku = '$randomNumber';
    }
  }

  Future<bool?> getAllCategory() async {
    isLoadingCategory.value = true;
    try {
      var list = await RepositoryManager.categoryRepository.getAllCategory();
      listCategory(list!);

      isLoadingCategory.value = false;
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingCategory.value = false;
  }

  void handleIfExistProduct({Product? productEd}) {
    isEdit = true;

    copyProduct(productEd: productEd);
  }

  void copyProduct({Product? productEd}) {
    if (productEd!.price == 0) {
      isContactPrice.value = true;
    }
    isProductRetailStep.value = productEd.isProductRetailStep ?? false;
    listProductRetail = productEd.productRetailSteps ?? [];
    isMedicine.value = productEd.isMedicine ?? false;
    videoUrl.value = productEd.videoUrl ?? "";
    textEditingControllerName.text = productEd.name!;
    shelfPositionEdit.text = productEd.shelfPosition ?? '';
    textEditingControllerPrice.text =
        SahaStringUtils().convertToUnit(productEd.price.toString());
    textEditingControllerWeight.text = productEd.weight == null
        ? ""
        : SahaStringUtils().convertToUnit(productEd.weight.toString());
    if (isContactPrice.value == true) {
      textEditingControllerPrice.text = "Liên hệ";
    }
    textEditingControllerPriceCapital.text =
        SahaStringUtils().convertToUnit(productEd.priceCapital.toString());
    textEditingControllerPriceImport.text =
        SahaStringUtils().convertToUnit(productEd.priceImport.toString());
    textEditingControllerBarcode.value.text = productEd.barcode ?? "";
    textEditingControllerSKU.value.text = productEd.sku ?? "";
    textEditingControllerBarcode.refresh();
    textEditingControllerSKU.refresh();

    if ((productEd.quantityInStockWithDistribute ?? 0) > 0) {
      textEditingControllerQuantityInStock.text = SahaStringUtils()
          .convertToUnit(productEd.quantityInStockWithDistribute.toString());
    } else {
      textEditingControllerQuantityInStock.text =
          productEd.mainStock == null || productEd.mainStock! < 0
              ? ""
              : SahaStringUtils().convertToUnit(productEd.mainStock.toString());
    }

    textEditingControllerBonusPoint.text =
        SahaStringUtils().convertToUnit(productEd.pointForAgency ?? "0");
    productRequest.typeShareCollaboratorNumber =
        productEd.typeShareCollaboratorNumber;

    if (productEd.typeShareCollaboratorNumber == 0) {
      textEditingControllerPercentRose.text =
          productEd.percentCollaborator == null
              ? ""
              : productEd.percentCollaborator.toString();
    } else {
      textEditingControllerPercentRose.text =
          productEd.moneyAmountCollaborator == null
              ? ""
              : SahaStringUtils()
                  .convertToUnit(productEd.moneyAmountCollaborator ?? "0");
    }

    textEditingControllerContentCTV.text =
        productEd.contentForCollaborator ?? "";
    description.value =
        productEd.description == null ? "" : productEd.description!;

    listAttributeSearchSelectedChild((productEd.attributeSearchChildren ?? [])
        .map((e) => AttributeSearch(id: e.attributeSearchChildId))
        .toList());

    final DistributeSelectController distributeSelectController = Get.find();
    //  final DistributeUpdateController distributeUpdateController = Get.find();

    if (productEd.images != null) {
      listImages(productEd.images!
          .map((e) => ImageData(
              linkImage: e.imageUrl, errorUpload: false, uploading: false))
          .toList());
    }

    if (productEd.categories != null) {
      listCategorySelected.value = productEd.categories!.map((e) => e).toList();
    }

    if (productEd.categories != null) {
      listCategorySelected.value = productEd.categories!.map((e) => e).toList();
    }

    if (productEd.categories != null) {
      listCategorySelectedChild.value =
          productEd.categoryChildren!.map((e) => e).toList();
    }

    if (productEd.attributes != null) {
      productEd.attributes!.forEach((element) {
        attributeData[element.name] = element.value;
        attributeData.refresh();
      });
    }

    if (productEd.distributes != null && productEd.distributes!.isNotEmpty) {
      listDistributeInit
          .addAll(productEd.distributes!.map((Distributes? listDistribute) {
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
            hasDistribute: true,
            hasSub:
                listDistribute.subElementDistributeName != null ? true : false,
            subElementDistributeName: listDistribute.subElementDistributeName,
            elementDistributes: listDistribute.elementDistributes!
                .map((e) => ElementDistributesRequest(
                      id: e.id,
                      isEdit: true,
                      name: e.name,
                      beforeName: e.name,
                      imageUrl: e.imageUrl,
                      price: e.price,
                      priceImport: e.priceImport,
                      priceCapital: e.priceCapital,
                      defaultPrice: e.defaultPrice,
                      barcode: e.barcode,
                      stock: e.stock,
                      sku: e.sku,
                      subElementDistribute: e.subElementDistribute == null
                          ? null
                          : e.subElementDistribute!
                              .map((e) => SubElementDistributeRequest(
                                  id: e.id,
                                  isEdit: true,
                                  name: e.name,
                                  beforeName: e.name,
                                  price: e.price,
                                  sku: e.sku,
                                  barcode: e.barcode,
                                  priceImport: e.priceImport,
                                  priceCapital: e.priceCapital,
                                  defaultPrice: e.defaultPrice,
                                  stock: e.stock))
                              .toList(),
                    ))
                .toList());
      }).toList());

      listDistribute.value = listDistributeInit;

      distributeSelectController.listDistribute.value =
          castDistributeRequest(listDistributeInit);
      // distributeUpdateController.listDistribute(listDistribute);
    }

    refresh();
  }

  List<DistributesRequest> castDistributeRequest(
      List<DistributesRequest> listDistributesRequest) {
    var distributesRequest = listDistributesRequest[0];
    return [
      DistributesRequest(
          name: distributesRequest.name,
          hasSub: distributesRequest.hasSub,
          hasDistribute: distributesRequest.hasDistribute,
          boolHasImage: distributesRequest.boolHasImage,
          subElementDistributeName: distributesRequest.subElementDistributeName,
          elementDistributes: distributesRequest.elementDistributes!
              .map((e) => ElementDistributesRequest(
                    name: e!.name,
                    beforeName: e.beforeName,
                    imageUrl: e.imageUrl,
                    isEdit: e.isEdit,
                    price: e.price,
                    sku: e.sku,
                    priceImport: e.priceImport,
                    priceCapital: e.priceCapital,
                    barcode: e.barcode,
                    stock: e.stock,
                    subElementDistribute: e.subElementDistribute == null
                        ? null
                        : e.subElementDistribute!
                            .map((e) => SubElementDistributeRequest(
                                isEdit: e.isEdit,
                                name: e.name,
                                beforeName: e.beforeName,
                                priceCapital: e.priceCapital,
                                price: e.price,
                                sku: e.sku,
                                barcode: e.barcode,
                                priceImport: e.priceImport,
                                stock: e.stock))
                            .toList(),
                  ))
              .toList())
    ];
  }

  void setNewListCategorySelected(List<Category> list) {
    listCategorySelected(list);
  }

  void setNewListCategorySelectedChild(List<Category> list) {
    listCategorySelectedChild(list);
  }

  void setNewListAttributeSearchSelected(List<AttributeSearch> list) {
    listAttributeSearchSelected(list);
  }

  void setNewListAttributeSearchSelectedChild(List<AttributeSearch> list) {
    listAttributeSearchSelectedChild(list);
  }

  Future<bool?> getAllAttribute() async {
    isLoadingAttribute.value = true;
    try {
      var list =
          await RepositoryManager.attributesRepository.getAllAttributes();
      listAttribute(list!);
      attributeData.entries.forEach((e) => {
            if (!listAttribute.contains(e.key)) {listAttribute.add(e.key)}
          });
      isLoadingAttribute.value = false;
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingAttribute.value = false;
  }

  void setNewListDistribute(List<DistributesRequest> list) {
    List<DistributesRequest> listOK = [];
    listOK = list
        .where((element) =>
            element.name != null &&
            element.elementDistributes != null &&
            element.elementDistributes!.length > 0)
        .toList();

    listDistribute(listOK);
    listDistribute.refresh();
    refresh();
  }

  void setNewListAttribute(List<String> list) {
    listAttribute(list);
    var newData = {};
    list.forEach((element) {
      newData[element] = attributeData[element];
    });
    attributeData(newData);
  }

  void addValueToMapAttribute(String key, String value) {
    attributeData[key] = value;
  }

  void setUploadingImages(bool value) {
    uploadingImages.value = value;
  }

  Future<void> createProduct({int status = 0}) async {
    try {
      isLoadingAdd.value = true;
      if (file != null) {
        showDialogSuccess('Đang tạo video');
        await upVideo();
        Get.back();
      }
      if (isProductRetailStep.value == true && checkPriceForProductRetail() == false) {
        
       return;
      }
      productRequest.productRetailSteps = listProductRetail;

      productRequest.isProductRetailStep = isProductRetailStep.value;
      ///////
      productRequest.categories =
          listCategorySelected.map((element) => element.id!).toList();
      productRequest.categoriesChild =
          listCategorySelectedChild.map((element) => element.id!).toList();
      productRequest.images = listImages == null
          ? []
          : listImages.map((e) => e.linkImage!).toList();

      productRequest.description = description.value;
      productRequest.status = status;
      productRequest.isMedicine = isMedicine.value;
      productRequest.videoUrl = videoUrl.value == "" ? null : videoUrl.value;

      List<ListAttribute> listAttributeRequest = [];
      attributeData.keys.forEach((key) {
        if (key != null && attributeData[key] != null) {
          listAttributeRequest
              .add(ListAttribute(name: key, value: attributeData[key]));
        }
      });

      listAttributeUpdate(
          listAttributeRequest.map((e) => e.name ?? "").toList());

      productRequest.listAttribute = listAttributeRequest;
      final DistributeSelectController distributeSelectController = Get.find();
      productRequest.listDistribute =
          distributeSelectController.listDistribute.toList();

      productRequest.price = double.tryParse(SahaStringUtils()
          .convertFormatText(textEditingControllerPrice.text == "Liên hệ"
              ? "0"
              : textEditingControllerPrice.text));

      productRequest.weight = double.tryParse(SahaStringUtils()
          .convertFormatText(textEditingControllerWeight.text));

      productRequest.priceCapital = double.tryParse(SahaStringUtils()
          .convertFormatText(textEditingControllerPriceCapital.text == "Liên hệ"
              ? "0"
              : textEditingControllerPrice.text));

      productRequest.pointForAgency = int.tryParse(SahaStringUtils()
          .convertFormatText(textEditingControllerBonusPoint.text));

      productRequest.priceImport = double.tryParse(SahaStringUtils()
          .convertFormatText(textEditingControllerPriceImport.text == "Liên hệ"
              ? "0"
              : textEditingControllerPriceImport.text));
      productRequest.sku = textEditingControllerSKU.value.text;
      if (textEditingControllerQuantityInStock.text.length > 0) {
        productRequest.mainStock = int.tryParse(SahaStringUtils()
            .convertFormatText(textEditingControllerQuantityInStock.text));
      }

      productRequest.typeShareCollaboratorNumber =
          productEdit.value.typeShareCollaboratorNumber;
      print(productRequest.typeShareCollaboratorNumber);
      if (productRequest.typeShareCollaboratorNumber == 0) {
        productRequest.percentCollaborator =
            textEditingControllerPercentRose.text == ""
                ? null
                : double.parse(textEditingControllerPercentRose.text);
      } else {
        productRequest.moneyAmountCollaborator =
            textEditingControllerPercentRose.text == ""
                ? null
                : double.tryParse(SahaStringUtils()
                    .convertFormatText(textEditingControllerPercentRose.text));
      }

      productRequest.name = textEditingControllerName.text;
      productRequest.shelfPosition = shelfPositionEdit.text;

      productRequest.contentForCollaborator =
          textEditingControllerContentCTV.text;
      productRequest.checkInventory = productEdit.value.checkInventory;

      if (isEdit == null || isEdit == false) {
        productRequest.priceCapital = productRequest.priceImport;
        updateAttribute();
        var data =
            await RepositoryManager.productRepository.createV2(productRequest);

        if (data!.checkInventory == true) {
          Get.back(
              result: productRequest.status == -1 ? "reload_hide" : "reload");
          Get.to(() => InventoryEditScreen(
                productInput: data,
                isNew: true,
              ));
        } else {
          SahaAlert.showSuccess(message: "Thêm thành công");
          Navigator.pop(Get.context!,
              productRequest.status == -1 ? "reload_hide" : "reload");
        }
        RepositoryManager.productRepository.setUpAttributeSearchProduct(
            data.id!,
            listAttributeSearchSelectedChild.map((e) => e.id!).toList());
      } else {
        productRequest.listDistribute = null;
        updateAttribute();
        await updateDistribute();
        var data = await RepositoryManager.productRepository
            .update(productEdit.value.id!, productRequest);

        if (data!.checkInventory == true) {
          Get.to(() => InventoryEditScreen(
                productInput: data,
              ));
        } else {
          SahaAlert.showSuccess(message: "Cập nhật thành công");
          Navigator.pop(Get.context!, data.id);
        }
        RepositoryManager.productRepository.setUpAttributeSearchProduct(
            data.id!,
            listAttributeSearchSelectedChild.map((e) => e.id!).toList());
      }

      isLoadingAdd.value = false;
      //return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
      isLoadingAdd.value = false;
    }
    isLoadingAdd.value = false;
  }

  Future<void> getOneProduct(int idProduct) async {
    loadInit.value = true;
    try {
      var data =
          await RepositoryManager.productRepository.getOneProductV2(idProduct);
      productEdit(data!.data);
      handleIfExistProduct(productEd: data.data);
      if (data.data!.distributes != null &&
          data.data!.distributes!.isNotEmpty) {
        isDistribute.value = true;
      }
      getAllAttribute();
      loadInit.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<bool?> updateAttribute() async {
    try {
      var list = await RepositoryManager.attributesRepository
          .updateAttributes(listAttributeUpdate.toList());
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateInventoryProduct(InventoryRequest inventoryRequest) async {
    try {
      var data = await RepositoryManager.inventoryRepository
          .updateInventoryProduct(inventoryRequest);
      getOneProduct(productInput!.id!);
      SahaAlert.showSuccess(message: "Cập nhật kho thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateDistribute() async {
    try {
      if (listDistribute.isNotEmpty) {
        var data = await RepositoryManager.distributeRepository
            .updateDistribute(
                productId: productInput!.id!,
                distributesRequest: listDistribute[0]);
      } else {
        var data = await RepositoryManager.distributeRepository
            .updateDistribute(
                productId: productInput!.id!,
                distributesRequest: DistributesRequest(hasDistribute: false));
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void showDialogSuccess(String title) {
    var alert = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      backgroundColor: Colors.grey[200],
      elevation: 0.0,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SahaLoadingWidget(),
          const SizedBox(
            height: 1,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(Get.context!).primaryColor,
            ),
          ),
        ],
      ),
    );

    showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (BuildContext c) {
          return alert;
        });
  }

  Future<String?> upVideo() async {
    try {
      var link = await RepositoryManager.imageRepository
          .uploadVideo(video: file, type: '');
      videoUrl.value = link ?? "";
      return link;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    return null;
  }

  bool checkSamePriceDistributes() {
    if (listDistribute[0].subElementDistributeName == null) {
      return (listDistribute[0].elementDistributes ?? []).every(
          (e) => e?.price == listDistribute[0].elementDistributes?[0]?.price);
    } else {
      return (listDistribute[0].elementDistributes ?? []).every((e) =>
          (e?.subElementDistribute ?? []).every(
              (element) => element.price == e?.subElementDistribute?[0].price));
    }
  }

  bool checkPriceForProductRetail() {
    var check = true;
    if (isDistribute.value == false) {
      if (textEditingControllerPrice.text == "Liên hệ") {
        SahaAlert.showError(
            message:
                "Vì để giá là liên hệ nên bạn không thể cài đặt phần mua nhiều giảm giá được, vui lòng kiểm tra lại");
        check = false;
      }
      if ((double.tryParse(SahaStringUtils()
                  .convertFormatText(textEditingControllerPrice.text)) ??
              0) <=
          (listProductRetail[0].price ?? 0)) {
        SahaAlert.showError(
            message:
                "Giá lẻ không thể nhỏ hơn giá bán sỉ, bạn hãy cài đặt lại giá sỉ ở mục mua nhiều giảm giá");
         check = false;
      }
    } else {
      if (checkSamePriceDistributes() == false) {
        SahaAlert.showError(
            message:
                "Phân loại cài đặt giá chưa giống nhau nên không thể tạo giá sỉ");
        check = false;
      }
      if (listDistribute[0].subElementDistributeName == null) {
        if (listDistribute[0].elementDistributes![0]!.price! <=
            (listProductRetail[0].price ?? 0)) {
          SahaAlert.showError(
              message: "Bạn đang cài đặt giá lẻ phân loại cao hơn giá sỉ");
          check = false;
        }
      } else {
        if (listDistribute[0]
                .elementDistributes![0]!
                .subElementDistribute![0]
                .price! <=
            (listProductRetail[0].price ?? 0)) {
          SahaAlert.showError(
              message: "Bạn đang cài đặt giá lẻ phân loại cao hơn giá sỉ");
           check = false;
        }
      }
    }
    return check;
  }
}
