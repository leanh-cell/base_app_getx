import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:html_editor_enhanced/utils/utils.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:tiengviet/tiengviet.dart';

import '../../../../../components/saha_user/button/saha_button.dart';
import '../../../../../components/saha_user/dialog/dialog.dart';
import '../../../../../components/saha_user/divide/divide.dart';
import '../../../../../components/saha_user/text_field/saha_text_filed_content.dart';
import '../../../../../components/saha_user/text_field/text_field_no_border.dart';
import '../../../../../components/widget/select_image/select_images.dart';
import '../../../../../model/image_assset.dart';
import '../../../../../model/product_commerce.dart';
import '../../../../../utils/string_utils.dart';
import 'commerce_product_detail_controller.dart';

class CommerceProductDetailScreen extends StatelessWidget {
  CommerceProductDetailScreen({Key? key, this.productCommerce}) {
    commerceProductDetailController =
        CommerceProductDetailController(productCommerce: productCommerce);
  }
  ProductCommerce? productCommerce;

  late CommerceProductDetailController commerceProductDetailController;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title:
              Text(productCommerce != null ? 'Sửa sản phẩm' : "Thêm sản phẩm"),
        ),
        body: Obx(
          () => commerceProductDetailController.loadInit.value
              ? SahaLoadingFullScreen()
              : Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SahaTextFieldNoBorder(
                            withAsterisk: true,
                            controller:
                                commerceProductDetailController.nameProduct,
                            onChanged: (v) {
                              commerceProductDetailController
                                  .productCommerceReq.value.name = v;
                            },
                            validator: (value) {
                              if (value!.length == 0) {
                                return 'Không được để trống';
                              }
                              return null;
                            },
                            labelText: "Tên sản phẩm",
                            hintText: "Nhập tên sản phẩm",
                          ),
                        ),
                        SahaDivide(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SahaTextFieldNoBorder(
                            controller: commerceProductDetailController
                                .textEditingControllerSKU,
                            onChanged: (value) {
                              commerceProductDetailController.productCommerceReq
                                  .value.sku = TiengViet.parse(value ?? "");
                              // addProductController.textEditingControllerSKU
                              //     .refresh();
                            },
                            validator: (value) {},
                            onSuggest: () {
                              SahaDialogApp.showDialogSuggestion(
                                  title: 'Mã SKU',
                                  contentWidget: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                          'Mã SKU khác nhau giúp phân biệt các phiên bản sản phẩm khác nhau, và nhiều công dụng khác vv, ...\n\nMã SKU tự sinh ra hoặc có thể tự nhập')
                                    ],
                                  ));
                            },
                            labelText: "SKU",
                            hintText: "Nhập mã SKU",
                          ),
                        ),
                        SahaDivide(),
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SelectImages(
                              title: "Ảnh sản phẩm",
                              maxImage: 10,
                              subTitle: "Tối đa 10 hình, có thể xem sau",
                              onUpload: () {
                                commerceProductDetailController
                                    .setUploadingImages(true);
                              },
                              images: commerceProductDetailController.listImages
                                  .toList(),
                              doneUpload: (List<ImageData> listImages) {
                                print(
                                    "done upload image ${listImages.length} images => ${listImages.toList().map((e) => e.linkImage).toList()}");
                                commerceProductDetailController
                                    .setUploadingImages(false);
                                commerceProductDetailController
                                    .listImages(listImages);

                                commerceProductDetailController
                                        .productCommerceReq.value.images =
                                    (listImages.map((e) => e.linkImage ?? ""))
                                        .toList();
                              },
                              type: '',
                            ),
                          ),
                        ),
                        SahaDivide(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SahaTextFieldNoBorder(
                            controller: commerceProductDetailController.price,
                            inputFormatters: [ThousandsFormatter()],
                            onChanged: (v) {
                              commerceProductDetailController
                                      .productCommerceReq.value.price =
                                  double.tryParse(
                                      SahaStringUtils().convertFormatText(v));
                            },
                            validator: (value) {
                              if (value!.length == 0) {
                                return 'Không được để trống';
                              }
                              return null;
                            },
                            textInputType: TextInputType.number,
                            labelText: "Giá bán",
                            hintText: "Nhập giá bán",
                          ),
                        ),
                        SahaDivide(),
                        Obx(
                          () => SahaTextFiledContent(
                            title: "Mô tả sản phẩm",
                            onChangeContent: (html) {
                              commerceProductDetailController
                                  .description.value = html;
                              print(commerceProductDetailController
                                  .description.value);
                              commerceProductDetailController.description
                                  .refresh();
                              // setState(() {
                              //   print(commerceProductDetailController.description.value);
                              // });
                            },
                            contentSaved: commerceProductDetailController
                                .description.value,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
        bottomNavigationBar: Container(
          height: 65,
          color: Colors.white,
          child: Column(
            children: [
              SahaButtonFullParent(
                text: productCommerce == null
                    ? "Thêm sản phẩm mới"
                    : "Cập nhật sản phẩm",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (productCommerce == null) {
                    } else {
                      commerceProductDetailController.updateProductCommerce();
                    }
                  }
                },
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
