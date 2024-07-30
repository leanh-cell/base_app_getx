import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../../model/image_assset.dart';
import '../../../../../model/product_commerce.dart';
import '../../../../../utils/string_utils.dart';

class CommerceProductDetailController extends GetxController {
  ProductCommerce? productCommerce;
  var productCommerceReq = ProductCommerce().obs;
  var nameProduct = TextEditingController();
  var textEditingControllerSKU = TextEditingController();
  var textEditingControllerPercentRose = TextEditingController();
  var quantityInStock = TextEditingController();
  var textEditingControllerPriceImport = TextEditingController();
  var price = TextEditingController();
  var loadInit = false.obs;
  var description = "".obs;
  ////
  var uploadingImages = false.obs;
  var listImages = RxList<ImageData>([]);

  CommerceProductDetailController({this.productCommerce}) {
    if (productCommerce != null) {
      getProducCommerce();
    }
  }

  void setUploadingImages(bool value) {
    uploadingImages.value = value;
  }

  void convertRes() {
    nameProduct.text = productCommerceReq.value.name ?? '';
    textEditingControllerSKU.text = productCommerceReq.value.sku ?? '';
    textEditingControllerPercentRose.text =
        productCommerceReq.value.percentCollaborator.toString();
    quantityInStock.text = productCommerceReq.value.quantityInStock.toString();
    textEditingControllerPriceImport.text = SahaStringUtils()
        .convertToUnit(productCommerceReq.value.importPrice ?? 0);

    price.text =
        SahaStringUtils().convertToUnit(productCommerceReq.value.price ?? 0);

    description.value = productCommerceReq.value.description ?? '';
    listImages(productCommerceReq.value.images!
        .map((e) =>
            ImageData(linkImage: e, errorUpload: false, uploading: false))
        .toList());
  }

  Future<void> getProducCommerce() async {
    loadInit.value = true;
    try {
      var res = await RepositoryManager.eCommerceRepo.getProducCommerce(
          id: productCommerce!.id!, shopId: productCommerce?.shopId ?? '');
      productCommerceReq.value = res!.data!;
      convertRes();
      loadInit.value = false;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> updateProductCommerce() async {
    try {
      var res = await RepositoryManager.eCommerceRepo.updateProductCommerce(
          idProduct: productCommerce!.id!,
          productCommerce: productCommerceReq.value);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}
