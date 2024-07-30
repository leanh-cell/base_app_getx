import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/product/product_request.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/update_agency_request.dart';
import 'package:com.ikitech.store/app_user/screen2/agency/list_agency_type/product_agency/edit_price/widget/distribute_select_controller.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import 'package:sahashop_customer/app_customer/utils/string_utils.dart';

class EditPriceController extends GetxController {
  ProductRequest productRequest = new ProductRequest();
  var isLoadingAdd = false.obs;
  var isContactPrice = false.obs;
  var listDistribute = RxList<DistributesRequest>();
  bool? isEdit = false;
  var productEdit = Product().obs;

  var uploadingImages = false.obs;

  var attributeData = {}.obs;
  var distributesRequestMain = DistributesRequest().obs;

  final TextEditingController textEditingControllerPrice =
      new TextEditingController();

  var description = "".obs;
  int agencyTypeIdRequest;
  int page;
  Product? productEd;

  EditPriceController(
      {this.productEd,
      required this.agencyTypeIdRequest,
      required this.page}) {
    if (productEd != null) {
      getAllProduct();
    }
  }

  Future<bool?> getAllProduct() async {
    try {
      var data = await RepositoryManager.productRepository.getAllProduct(
        page: page,
        agencyTypeId: agencyTypeIdRequest,
      );

      var list = data!.data;
      print(page);

      var index = (list ?? []).indexWhere((e) => e.id == productEd!.id!);
      print(index);

      if (index != -1) {
        productEdit(list![index]);
        handleIfExistProduct(productEd: list[index]);
      }

      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getProductPriceAgency(int idProduct, int agencyTypeId) async {
    try {
      var data = await RepositoryManager.agencyRepository.getProductPriceAgency(
          idProduct: idProduct, agencyTypeId: agencyTypeId);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateProductPriceAgency(
      int idProduct, UpdatePriceAgencyRequest updatePriceAgencyRequest) async {
    try {
      var data = await RepositoryManager.agencyRepository
          .updateProductPriceAgency(idProduct, updatePriceAgencyRequest);
      Get.back(result: "success");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void handleIfExistProduct({Product? productEd}) {
    isEdit = true;

    copyProduct(productEd: productEd);
  }

  void copyProduct({Product? productEd}) {
    if (productEd!.price == 0) {
      isContactPrice.value = true;
    }
    textEditingControllerPrice.text = productEd.agencyPrice?.mainPrice == 0
        ? "Liên hệ"
        : SahaStringUtils().convertToUnit(
            productEd.agencyPrice?.mainPrice == null
                ? "0"
                : productEd.agencyPrice?.mainPrice.toString());

    final DistributeSelectController distributeSelectController = Get.find();

    if (productEd.agencyPrice?.distributes != null &&
        (productEd.agencyPrice?.distributes ?? []).isNotEmpty) {
      listDistribute(productEd.agencyPrice!.distributes!
          .map((Distributes? listDistribute) {
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
                      name: e.name,
                      imageUrl: e.imageUrl,
                      price: e.price,
                      quantityInStock: e.quantityInStock,
                      subElementDistribute: e.subElementDistribute == null
                          ? null
                          : e.subElementDistribute!
                              .map((e) => SubElementDistributeRequest(
                                  name: e.name,
                                  price: e.price,
                                  quantityInStock: e.quantityInStock))
                              .toList(),
                    ))
                .toList());
      }).toList());

      distributeSelectController.listDistribute(listDistribute);
    }

    if (productEd.distributes != null && productEd.distributes!.isNotEmpty) {
      var listDistributeNew =
          productEd.distributes!.map((Distributes? listDistribute) {
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
                      name: e.name,
                      imageUrl: e.imageUrl,
                      price: e.price,
                      quantityInStock: e.quantityInStock,
                      subElementDistribute: e.subElementDistribute == null
                          ? null
                          : e.subElementDistribute!
                              .map((e) => SubElementDistributeRequest(
                                  name: e.name,
                                  price: e.price,
                                  quantityInStock: e.quantityInStock))
                              .toList(),
                    ))
                .toList());
      }).toList();
      print(listDistributeNew[0].toJson());

      distributesRequestMain.value = listDistributeNew[0];
      print(distributesRequestMain.value.toJson());
    }

    refresh();
  }
}
