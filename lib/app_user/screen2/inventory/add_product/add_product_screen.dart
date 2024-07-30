import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty/saha_empty_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/components/widget/video_picker_single/video_picker_single.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/add_product/product_retail_steps/product_retail_steps_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/attribute_search/attribute_search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/popup/popup_input.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/inventory/inventory_request.dart';
import 'package:com.ikitech.store/app_user/model/image_assset.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/add_product/widget/distribute_select.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/add_product/widget/distribute_select_controller.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/add_product/widget/select_images.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/attribute/attributes_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/categories/category_screen.dart';
import 'package:com.ikitech.store/app_user/utils/color_utils.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/divide/divide.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/picker/product/product_picker.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/saha_text_filed_content.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/text_field_no_border.dart';
import 'package:com.ikitech.store/app_user/const/constant_database_status_online.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/product/product_request.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import 'package:tiengviet/tiengviet.dart';

import '../../../../saha_data_controller.dart';
import 'add_product_controller.dart';
import 'widget/distribute_update/distribute_update_controller.dart';

class AddProductScreen extends StatefulWidget {
  final Product? product;

  const AddProductScreen({Key? key, this.product}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  late AddProductController addProductController;

  final DistributeSelectController distributeSelectController =
      Get.put(DistributeSelectController());

  late DistributeUpdateController distributeUpdateController;
  SahaDataController sahaDataController = Get.find();

  @override
  void initState() {
    super.initState();
    distributeUpdateController =
        Get.put(DistributeUpdateController(productId: widget.product?.id ?? 0));
    addProductController =
        Get.put(AddProductController(productInput: widget.product));
    print(widget.product?.description);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: SahaAppBar(
            titleText:
                "${widget.product == null ? "Thêm sản phẩm" : "Sửa sản phẩm"}",
            actions: widget.product != null
                ? null
                : [
                    TextButton(
                        onPressed: () {
                          Get.to(ProductPickerScreen(
                            listProductInput: [],
                            onlyOne: true,
                            textHandle: "Sao chép",
                            callback: (List<Product> products) {},
                          ))!
                              .then((products) {
                            if (products.length > 0) {
                              SahaDialogApp.showDialogYesNo(
                                  mess:
                                      "Bạn muốn sao chép sản phẩm ${products[0].name} cho tất cả ô nhập liệu?",
                                  onOK: () async {
                                    addProductController.copyProduct(
                                        productEd: products[0]);
                                    await Future.delayed(
                                        Duration(milliseconds: 500));
                                    setState(() {});
                                  });
                            }
                          });
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Sao chép",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ))
                  ],
          ),
          body: Obx(
            () => addProductController.loadInit.value
                ? SahaLoadingFullScreen()
                : Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SahaTextFieldNoBorder(
                                    withAsterisk: true,
                                    controller: addProductController
                                        .textEditingControllerName,
                                    onChanged: (value) {
                                      addProductController.productRequest.name =
                                          value;
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
                                    controller: addProductController
                                        .textEditingControllerSKU.value,
                                    onChanged: (value) {
                                      addProductController.productRequest.sku =
                                          TiengViet.parse(value ?? "");
                                      addProductController
                                          .textEditingControllerSKU
                                          .refresh();
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
                                Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SahaTextFieldNoBorder(
                                        controller: addProductController
                                            .textEditingControllerBarcode.value,
                                        onChanged: (value) {
                                          addProductController
                                                  .productRequest.barcode =
                                              TiengViet.parse(value ?? "");
                                          addProductController
                                              .textEditingControllerBarcode
                                              .refresh();
                                        },
                                        validator: (value) {},
                                        labelText: "Barcode",
                                        hintText: "Nhập Barcode",
                                      ),
                                    ),
                                    Positioned(
                                      right: 10,
                                      top: 15,
                                      child: IconButton(
                                          onPressed: () {
                                            scanBarcodeNormal();
                                          },
                                          icon: Icon(
                                            Icons.qr_code_scanner_sharp,
                                            color:
                                                Theme.of(context).primaryColor,
                                          )),
                                    ),
                                    Positioned(
                                      right: 60,
                                      top: 20,
                                      child: Obx(
                                        () => addProductController
                                                    .textEditingControllerBarcode
                                                    .value
                                                    .text !=
                                                ""
                                            ? BarcodeWidget(
                                                barcode: Barcode.code128(
                                                    useCode128C:
                                                        true), // Barcode type and settings
                                                data:
                                                    '${TiengViet.parse(addProductController.textEditingControllerBarcode.value.text)}',
                                                width: 60, // Content
                                                height: 50,
                                              )
                                            : Container(),
                                      ),
                                    ),
                                  ],
                                ),
                                SahaDivide(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SahaTextFieldNoBorder(
                                    controller: addProductController
                                        .textEditingControllerWeight,
                                    onChanged: (value) {
                                      addProductController
                                              .productRequest.weight =
                                          double.tryParse(value ?? "");
                                    },
                                    textInputType: TextInputType.number,
                                    inputFormatters: [ThousandsFormatter()],
                                    suffixText: "g",
                                    onSuggest: () {
                                      SahaDialogApp.showDialogSuggestion(
                                          title: 'Cân nặng (g)',
                                          contentWidget: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                  'Là cân nặng của mỗi sản phẩm để tính phí vận chuyển, bỏ qua trường này hệ thống sẽ mặc định sản phẩm nặng 100g')
                                            ],
                                          ));
                                    },
                                    labelText: "Cân nặng (g)",
                                    hintText: "Nhập cân nặng (mặc định 100g)",
                                    helperText:
                                        "Cân nặng (mặc định 100g) nếu sản phẩm nặng 0g",
                                  ),
                                ),
                                SahaDivide(),
                                Obx(
                                  () => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SelectImages(
                                      title: "Ảnh sản phẩm",
                                      maxImage: 10,
                                      subTitle:
                                          "Tối đa 10 hình, có thể xem sau",
                                      onUpload: () {
                                        addProductController
                                            .setUploadingImages(true);
                                      },
                                      images: addProductController.listImages
                                          .toList(),
                                      doneUpload: (List<ImageData> listImages) {
                                        print(
                                            "done upload image ${listImages.length} images => ${listImages.toList().map((e) => e.linkImage).toList()}");
                                        addProductController
                                            .setUploadingImages(false);
                                        addProductController
                                            .listImages(listImages);
                                      },
                                      type: '',
                                    ),
                                  ),
                                ),
                                SahaDivide(),
                                Obx(
                                  () => VideoPickerSingle(
                                    linkVideo: addProductController
                                                .videoUrl.value ==
                                            ""
                                        ? null
                                        : addProductController.videoUrl.value,
                                    onChange: (File? file) async {
                                      addProductController.file = file;
                                      if (file == null) {
                                        addProductController.videoUrl.value =
                                            "";
                                      }
                                    },
                                  ),
                                ),
                                SahaDivide(),
                                Container(
                                  color: Colors.white,
                                  height: 50,
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: Text(
                                        "Có phân loại",
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      )),
                                      Obx(
                                        () => CupertinoSwitch(
                                          value: addProductController
                                              .isDistribute.value,
                                          onChanged: (bool value) {
                                            if (addProductController
                                                .listDistribute.isNotEmpty) {
                                              SahaDialogApp.showDialogYesNo(
                                                  mess:
                                                      "bạn đang có các phân loại, nếu tắt phân loại thì các phân loại sẽ không còn tồn tại nữa",
                                                  onOK: () {
                                                    addProductController
                                                            .isDistribute
                                                            .value =
                                                        !addProductController
                                                            .isDistribute.value;
                                                    addProductController
                                                        .setNewListDistribute(
                                                            []);
                                                  });
                                            } else {
                                              addProductController
                                                      .isDistribute.value =
                                                  !addProductController
                                                      .isDistribute.value;
                                              if (addProductController
                                                      .isDistribute.value ==
                                                  true) {
                                                toDistributeEdit(
                                                    widget.product == null
                                                        ? true
                                                        : false);
                                              }
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                ),
                                Container(
                                  color: Colors.white,
                                  //height: 50,
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Sản phẩm chỉ được liên hệ",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Sản phầm này không thể đặt mua bình thường, mà phải liên hệ tư vấn.",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey),
                                          )
                                        ],
                                      )),
                                      Obx(
                                        () => CupertinoSwitch(
                                          value: addProductController
                                              .isMedicine.value,
                                          onChanged: (bool value) {
                                            addProductController
                                                .isMedicine.value = value;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(),
                                Obx(
                                  () => !addProductController.isDistribute.value
                                      ? Column(
                                          children: [
                                            SahaDivide(),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Stack(
                                                    children: [
                                                      SahaTextFieldNoBorder(
                                                        enabled:
                                                            !addProductController
                                                                .isContactPrice
                                                                .value,
                                                        controller:
                                                            addProductController
                                                                .textEditingControllerPrice,
                                                        inputFormatters: [
                                                          ThousandsFormatter()
                                                        ],
                                                        validator: (value) {
                                                          if (value!.length ==
                                                              0) {
                                                            return 'Không được để trống';
                                                          }
                                                          return null;
                                                        },
                                                        textInputType:
                                                            TextInputType
                                                                .number,
                                                        labelText: "Giá bán lẻ",
                                                        hintText: "Đặt",
                                                      ),
                                                      Obx(
                                                        () => Positioned(
                                                            right: 15,
                                                            child: Row(
                                                              children: [
                                                                Checkbox(
                                                                    value: addProductController
                                                                        .isContactPrice
                                                                        .value,
                                                                    onChanged:
                                                                        (v) {
                                                                      addProductController
                                                                              .isContactPrice
                                                                              .value =
                                                                          !addProductController
                                                                              .isContactPrice
                                                                              .value;
                                                                      if (addProductController
                                                                              .isContactPrice
                                                                              .value ==
                                                                          true) {
                                                                        addProductController
                                                                            .textEditingControllerPrice
                                                                            .text = "Liên hệ";
                                                                      } else {
                                                                        addProductController
                                                                            .textEditingControllerPrice
                                                                            .text = widget.product ==
                                                                                null
                                                                            ? ""
                                                                            : widget.product!.price == 0
                                                                                ? ""
                                                                                : SahaStringUtils().convertToUnit(widget.product!.price.toString());
                                                                      }
                                                                    }),
                                                                Text("Liên hệ"),
                                                              ],
                                                            )),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: SahaTextFieldNoBorder(
                                                    controller: addProductController
                                                        .textEditingControllerPriceImport,
                                                    inputFormatters: [
                                                      ThousandsFormatter()
                                                    ],
                                                    validator: (value) {
                                                      if (value!.length == 0) {
                                                        return 'Không được để trống';
                                                      }
                                                      return null;
                                                    },
                                                    onSuggest: () {
                                                      SahaDialogApp
                                                          .showDialogSuggestion(
                                                              title: 'Giá nhập',
                                                              contentWidget:
                                                                  Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Text(
                                                                      'Giá nhập là đơn giá nhập hàng của sản phẩm, chưa bao gồm chiết khấu và các chi phí nhập hàng khác.')
                                                                ],
                                                              ));
                                                    },
                                                    textInputType:
                                                        TextInputType.number,
                                                    labelText: "Giá nhập",
                                                    hintText: "Đặt",
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SahaDivide(),
                                          ],
                                        )
                                      : Container(),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      color: Colors.white,
                                      height: 50,
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Nhập bằng số tiền",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Obx(
                                            () => CupertinoSwitch(
                                              value: addProductController
                                                          .productEdit
                                                          .value
                                                          .typeShareCollaboratorNumber ==
                                                      1
                                                  ? true
                                                  : false,
                                              onChanged: (bool value) {
                                                if (addProductController
                                                        .productEdit
                                                        .value
                                                        .typeShareCollaboratorNumber ==
                                                    1) {
                                                  addProductController
                                                      .productEdit
                                                      .value
                                                      .typeShareCollaboratorNumber = 0;
                                                } else {
                                                  addProductController
                                                      .productEdit
                                                      .value
                                                      .typeShareCollaboratorNumber = 1;
                                                }
                                                addProductController
                                                    .textEditingControllerPercentRose
                                                    .clear();
                                                addProductController.productEdit
                                                    .refresh();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Obx(() => (addProductController
                                                    .productEdit
                                                    .value
                                                    .typeShareCollaboratorNumber ??
                                                0) ==
                                            0
                                        ? SahaTextFieldNoBorder(
                                            enabled: sahaDataController
                                                    .badgeUser
                                                    .value
                                                    .decentralization
                                                    ?.productCommission ??
                                                false,
                                            controller: addProductController
                                                .textEditingControllerPercentRose,
                                            onChanged: (value) {
                                              addProductController
                                                      .productRequest
                                                      .percentCollaborator =
                                                  double.tryParse(value!) ?? 0;
                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'^(\d+)?\.?\d{0,2}'))
                                            ],
                                            validator: (value) {
                                              if (value == null || value == "")
                                                return null;
                                              if (double.parse(value) > 100) {
                                                return 'Không được quá 100%';
                                              }
                                              return null;
                                            },
                                            onSuggest: () {
                                              SahaDialogApp.showDialogSuggestion(
                                                  title: 'Phần trăm  hoa hồng CTV',
                                                  contentWidget: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                          'Đây là phần trăm hoa hồng CTV nhận được sau khi mua và giới thiệu người khác mua sản phẩm này.')
                                                    ],
                                                  ));
                                            },
                                            textInputType: TextInputType.number,
                                            labelText:
                                                "Phần trăm hoa hồng cộng tác viên",
                                            hintText: "Đặt",
                                            helperText:
                                                "Để trống khi sản phẩm không có hoa hồng",
                                          )
                                        : SahaTextFieldNoBorder(
                                            controller: addProductController
                                                .textEditingControllerPercentRose,
                                            onChanged: (value) {
                                              addProductController
                                                      .productRequest
                                                      .moneyAmountCollaborator =
                                                  double.tryParse(value!) ?? 0;
                                            },
                                            validator: (value) {
                                              if (value == null || value == "")
                                                return null;
                                              return null;
                                            },
                                            onSuggest: () {
                                              SahaDialogApp.showDialogSuggestion(
                                                  title: 'Số tiền hoa hồng CTV',
                                                  contentWidget: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                          'Đây là số tiền hoa hồng CTV nhận được sau khi mua và giới thiệu người khác mua sản phẩm này.')
                                                    ],
                                                  ));
                                            },
                                            inputFormatters: [
                                              ThousandsFormatter(),
                                            ],
                                            textInputType: TextInputType.number,
                                            labelText:
                                                "Số tiền hoa hồng cộng tác viên",
                                            hintText: "Đặt",
                                            helperText:
                                                "Để trống khi sản phẩm không có hoa hồng",
                                          )),
                                  ],
                                ),
                                SahaDivide(),
                                SahaTextFieldNoBorder(
                                  controller: addProductController
                                      .textEditingControllerBonusPoint,
                                  onChanged: (value) {
                                    addProductController
                                            .productRequest.pointForAgency =
                                        int.tryParse(value!) ?? 0;
                                  },
                                  inputFormatters: [
                                    ThousandsFormatter(),
                                    FilteringTextInputFormatter.deny(
                                        RegExp('[-]')),
                                  ],
                                  validator: (value) {},
                                  onSuggest: () {
                                    SahaDialogApp.showDialogSuggestion(
                                        title: 'Xu thưởng đại lý',
                                        contentWidget: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                                'Đây là Xu thưởng cho đại lý khi mua sản phẩm này.')
                                          ],
                                        ));
                                  },
                                  textInputType: TextInputType.number,
                                  labelText: "Xu thưởng đại lý",
                                  hintText: "Đặt",
                                  helperText:
                                      "Để trống khi sản phẩm không có xu thưởng",
                                ),
                                SahaDivide(),
                                Obx(
                                  () => addProductController.isDistribute.value
                                      ? InkWell(
                                          onTap: () {
                                            toDistributeEdit(
                                                widget.product == null
                                                    ? true
                                                    : false);
                                          },
                                          child: Container(
                                              padding: EdgeInsets.all(16),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Icon(Icons
                                                      .auto_awesome_motion),
                                                  Text(
                                                    "Phân loại sản phẩm",
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 16),
                                                  ),
                                                  Spacer(),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 4),
                                                    child: Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 15,
                                                      color: Colors.grey,
                                                    ),
                                                  )
                                                ],
                                              )),
                                        )
                                      : Container(),
                                ),
                                Obx(
                                  () => addProductController.isDistribute.value
                                      ? Column(
                                          children: [
                                            Divider(
                                              height: 1,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Expanded(
                                                  child: Obx(() =>
                                                      addProductController
                                                              .listDistribute
                                                              .isNotEmpty
                                                          ? buildListDistribute()
                                                          : Container()),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      : Container(),
                                ),

                                Column(
                                  children: [
                                    Container(
                                      color: Colors.white,
                                      height: 50,
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Theo dõi hàng trong kho ",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    SahaDialogApp
                                                        .showDialogSuggestion(
                                                            title:
                                                                'Theo dõi hàng trong kho',
                                                            contentWidget:
                                                                Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Text(
                                                                    'Số lượng hàng trong kho được theo dõi có số lượng và giá vốn đặc biệt hơn hết là được lưu lại toàn bộ lịch sử kho của sản phẩm.\n\nNếu không theo dõi hàng trong kho sản phẩm sẽ không cần quan tâm tới số lượng cũng như giá vốn.')
                                                              ],
                                                            ));
                                                  },
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Icon(
                                                        Icons.circle,
                                                        color: Colors.blue,
                                                        size: 20,
                                                      ),
                                                      Text(
                                                        'i',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Obx(
                                            () => CupertinoSwitch(
                                              value: addProductController
                                                      .productEdit
                                                      .value
                                                      .checkInventory ??
                                                  false,
                                              onChanged: (bool value) {
                                                addProductController.productEdit
                                                        .value.checkInventory =
                                                    !addProductController
                                                        .productEdit
                                                        .value
                                                        .checkInventory!;
                                                addProductController.productEdit
                                                    .refresh();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Obx(
                                      () => (addProductController.productEdit
                                                      .value.checkInventory ??
                                                  false) ==
                                              true
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SahaTextFieldNoBorder(
                                                controller: addProductController
                                                    .shelfPositionEdit,
                                                onChanged: (value) {
                                                  addProductController
                                                      .productRequest
                                                      .shelfPosition = value;
                                                },
                                                labelText: "Vị trí kệ hàng",
                                                hintText:
                                                    "Nhập vị trí kệ hàng để sản phẩm",
                                              ),
                                            )
                                          : Container(),
                                    ),
                                  ],
                                ),
                                Divider(
                                  height: 1,
                                ),
                                // Obx(
                                //   () => (addProductController
                                //               .listDistribute.isNotEmpty &&
                                //           widget.product == null &&
                                //           (addProductController.productEdit.value
                                //                   .checkInventory ??
                                //               false)
                                //       ? Column(
                                //           children: [
                                //             Divider(
                                //               height: 1,
                                //             ),
                                //             itemProduct(
                                //                 addProductController
                                //                     .productEdit.value,
                                //                 true),
                                //           ],
                                //         )
                                //       : SahaDivide()),
                                // ),
                                // Obx(
                                //   () => (addProductController.productEdit.value
                                //                       .checkInventory ??
                                //                   false) ==
                                //               true &&
                                //           widget.product != null
                                //       ? Column(
                                //           children: [
                                //             Divider(
                                //               height: 1,
                                //             ),
                                //             itemProduct(
                                //                 addProductController
                                //                     .productEdit.value,
                                //                 false),
                                //           ],
                                //         )
                                //       : SahaDivide(),
                                // ),
                                InkWell(
                                  onTap: () {
                                    if (sahaDataController
                                            .badgeUser
                                            .value
                                            .decentralization
                                            ?.productCategoryList !=
                                        true) {
                                      SahaAlert.showError(
                                          message:
                                              "Bạn không có quyền truy cập");
                                      return;
                                    }
                                    Get.to(() => CategoryScreen(
                                              isSelect: true,
                                              listCategorySelected:
                                                  addProductController
                                                      .listCategorySelected
                                                      .toList(),
                                              listCategorySelectedChild:
                                                  addProductController
                                                      .listCategorySelectedChild
                                                      .toList(),
                                            ))!
                                        .then((value) => {
                                              addProductController
                                                  .setNewListCategorySelected(
                                                      value["list_cate"]),
                                              addProductController
                                                  .setNewListCategorySelectedChild(
                                                      value["list_cate_child"])
                                            });
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.all(13),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Icon(Icons.wysiwyg_outlined),
                                              Text(
                                                " Danh mục sản phẩm",
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 16),
                                              ),
                                              Spacer(),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 4),
                                                child: Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 15,
                                                  color: Colors.grey,
                                                ),
                                              )
                                            ],
                                          )),
                                      buildListCategory(),
                                    ],
                                  ),
                                ),
                                SahaDivide(),
                                InkWell(
                                  onTap: () {
                                    if (addProductController
                                                .isDistribute.value ==
                                            false &&
                                        (addProductController
                                                    .textEditingControllerPrice
                                                    .text ==
                                                "Liên hệ" ||
                                            addProductController
                                                    .textEditingControllerPrice
                                                    .text
                                                    .length ==
                                                0)) {
                                      SahaAlert.showError(
                                          message: "Bạn chưa điền giá bán lẻ");
                                      return;
                                    }
                                    if (addProductController
                                                .isDistribute.value ==
                                            true &&
                                        addProductController
                                                .checkSamePriceDistributes() ==
                                            false &&
                                        widget.product == null) {
                                      SahaAlert.showError(
                                          message:
                                              "Các phân loại chưa đồng giá");
                                      return;
                                    }
                                    Get.to(() => ProductRetailStepsScreen(
                                          listProductRetailStep:
                                              addProductController
                                                  .listProductRetail
                                                  .toList(),
                                          priceProduct: addProductController
                                                      .isDistribute.value ==
                                                  false
                                              ? (double.tryParse(SahaStringUtils()
                                                      .convertFormatText(
                                                          addProductController
                                                              .textEditingControllerPrice
                                                              .text)) ??
                                                  0)
                                              : addProductController
                                                          .listDistribute[0]
                                                          .subElementDistributeName ==
                                                      null
                                                  ? addProductController
                                                      .listDistribute[0]
                                                      .elementDistributes![0]!
                                                      .price!
                                                  : addProductController
                                                      .listDistribute[0]
                                                      .elementDistributes![0]!
                                                      .subElementDistribute![0]
                                                      .price!,
                                          onSubmit: (List<ProductRetailStep> v) {
                                            addProductController
                                                .listProductRetail = v;
                                            if (v.isEmpty) {
                                              addProductController
                                                  .isProductRetailStep
                                                  .value = false;
                                            } else {
                                              addProductController
                                                  .isProductRetailStep
                                                  .value = true;
                                            }
                                          },
                                        ));
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.all(13),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Icon(Icons.wysiwyg_outlined),
                                              Text(
                                                " Mua nhiều giảm giá",
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 16),
                                              ),
                                              Spacer(),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 4),
                                                child: Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 15,
                                                  color: Colors.grey,
                                                ),
                                              )
                                            ],
                                          )),
                                      buildListCategory(),
                                    ],
                                  ),
                                ),
                                SahaDivide(),
                                InkWell(
                                  onTap: () {
                                    Get.to(() => AttributeSearchScreen(
                                              isSelect: true,
                                              listAttributeSearchSelectedChild:
                                                  addProductController
                                                      .listAttributeSearchSelectedChild
                                                      .toList(),
                                            ))!
                                        .then((value) => {
                                              addProductController
                                                  .setNewListAttributeSearchSelected(
                                                      value[
                                                          "list_attribute_search"]),
                                              addProductController
                                                  .setNewListAttributeSearchSelectedChild(
                                                      value[
                                                          "list_attribute_search_child"])
                                            });
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.all(13),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Icon(Ionicons.filter),
                                              Text(
                                                " Thuộc tính tìm kiếm",
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 16),
                                              ),
                                              Spacer(),
                                              Obx(
                                                () => Text(
                                                    '${addProductController.listAttributeSearchSelectedChild.length}'),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 4),
                                                child: Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 15,
                                                  color: Colors.grey,
                                                ),
                                              )
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                                SahaDivide(),
                                InkWell(
                                  onTap: () {
                                    if (sahaDataController
                                            .badgeUser
                                            .value
                                            .decentralization
                                            ?.productAttributeList !=
                                        true) {
                                      SahaAlert.showError(
                                          message:
                                              "Bạn không có quyền truy cập");
                                      return;
                                    }
                                    Get.to(() => AttributeScreen(
                                          onData: (data) {
                                            addProductController
                                                .listAttribute(data);
                                          },
                                        ));
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(13),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.ballot_outlined),
                                          Text(
                                            " Thuộc tính ",
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 16),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              SahaDialogApp
                                                  .showDialogSuggestion(
                                                      title: 'Thuộc tính',
                                                      contentWidget: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                              'Thêm thuộc tính để tạo ra sản phẩm có nhiều phiên bản với các lựa chọn như màu sắc, kích thước, chất liệu, ...')
                                                        ],
                                                      ));
                                            },
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Icon(
                                                  Icons.circle,
                                                  color: Colors.blue,
                                                  size: 20,
                                                ),
                                                Text(
                                                  'i',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                )
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 4),
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              size: 15,
                                              color: Colors.grey,
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                                Divider(
                                  height: 1,
                                ),
                                buildListAttribute(),
                                SahaDivide(),
                                Obx(
                                  () => SahaTextFiledContent(
                                    title: "Mô tả sản phẩm",
                                    onChangeContent: (html) {
                                      addProductController.description.value =
                                          html;
                                      print(addProductController
                                          .description.value);
                                      addProductController.description
                                          .refresh();
                                      setState(() {
                                        print(addProductController
                                            .description.value);
                                      });
                                    },
                                    contentSaved:
                                        addProductController.description.value,
                                  ),
                                ),
                                Container(height: 5, color: Colors.grey[200]),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Mẫu content cho cộng tác viên ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              SahaDialogApp.showDialogSuggestion(
                                                  title: 'Content cho cộng tác viên',
                                                  contentWidget: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                          'Content mẫu dành cho CTV khi đăng bài (CTV có thể lấy hoặc không).')
                                                    ],
                                                  ));
                                            },
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Icon(
                                                  Icons.circle,
                                                  color: Colors.blue,
                                                  size: 20,
                                                ),
                                                Text(
                                                  'i',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Divider(
                                        height: 1,
                                      ),
                                      TextFormField(
                                        textInputAction:
                                            TextInputAction.newline,
                                        controller: addProductController
                                            .textEditingControllerContentCTV,
                                        minLines: 1,
                                        maxLines: 50,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: EdgeInsets.only(
                                              top: 15, bottom: 3),
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          helperStyle: TextStyle(fontSize: 11),
                                          hintText: "Nhập Content",
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(height: 5, color: Colors.grey[200]),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: SahaButtonFullParent(
                                    color: Colors.white,
                                    textColor: Colors.black87,
                                    colorBorder: Colors.grey[500],
                                    text: "Tạm ẩn",
                                    onPressed: () {
                                      if (sahaDataController
                                              .badgeUser
                                              .value
                                              .decentralization
                                              ?.productUpdate !=
                                          true) {
                                        SahaAlert.showError(
                                            message:
                                                'Bạn không có quyền tạm ẩn sản phẩm');
                                        return;
                                      }
                                      if (_formKey.currentState!.validate()) {
                                        addProductController.createProduct(
                                            status: -1);
                                      }
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: SahaButtonFullParent(
                                    text: "Hiển thị",
                                    onPressed: () {
                                      if (sahaDataController
                                              .badgeUser
                                              .value
                                              .decentralization
                                              ?.productUpdate !=
                                          true) {
                                        SahaAlert.showError(
                                            message:
                                                'Bạn không có quyền cập nhật sản phẩm');
                                        return;
                                      }
                                      if (_formKey.currentState!.validate()) {
                                        addProductController.createProduct(
                                            status: 0);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  void toDistributeEdit(bool? isNew) {
    // if (isNew == true) {
    Get.to(() => DistributeSelect(
          isNew: isNew,
          onData: (List<DistributesRequest> data, int? quantityCurrent) {
            print(data);
            if (data.isEmpty) {
              addProductController.isDistribute.value = false;
            }
            addProductController.setNewListDistribute(data.toList());
            if (addProductController.listDistribute.isEmpty) {
              addProductController.isDistribute.value = false;
            } else {
              addProductController.isDistribute.value = true;
            }
            if (quantityCurrent != 0) {
              addProductController.textEditingControllerQuantityInStock.text =
                  "$quantityCurrent";
            } else {
              if ((widget.product?.quantityInStockWithDistribute ?? 0) > 0) {
                addProductController.textEditingControllerQuantityInStock.text =
                    SahaStringUtils().convertToUnit(
                        "${widget.product?.quantityInStockWithDistribute ?? 0}");
              } else {
                addProductController.textEditingControllerQuantityInStock.text =
                    widget.product?.mainStock == null ||
                            (widget.product?.mainStock ?? 0) < 0
                        ? ""
                        : SahaStringUtils()
                            .convertToUnit("${widget.product?.mainStock ?? 0}");
              }
            }
          },
        ));
  }

  Widget buildListCategory() {
    return Obx(
      () => Column(
        children: addProductController.listCategorySelected
            .map((category) => Column(
                  children: [
                    Container(
                      height: 1,
                      color: Colors.grey[100],
                    ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.only(
                          left: 16, right: 16, top: 8, bottom: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CachedNetworkImage(
                            fit: BoxFit.cover,
                            height: 50,
                            width: 50,
                            imageUrl: category.imageUrl ?? "",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    SahaLoadingWidget(
                              size: 20,
                            ),
                            errorWidget: (context, url, error) => Icon(
                              Icons.image,
                              color: Colors.grey,
                              size: 30,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(category.name!),
                          Spacer(),
                          IconButton(
                            icon: Icon(
                              Icons.clear,
                              size: 12,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              addProductController.listCategorySelected
                                  .removeWhere(
                                      (element) => element.id == category.id);
                            },
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                    if (category.listCategoryChild != null &&
                        category.listCategoryChild!.isNotEmpty)
                      ...category.listCategoryChild!
                          .where((e) => addProductController
                              .listCategorySelectedChild
                              .map((e) => e.id!)
                              .toList()
                              .contains(e.id))
                          .toList()
                          .map(
                            (e) => Container(
                              //height: 50,
                              padding: EdgeInsets.only(
                                  left: 40, right: 16, top: 8, bottom: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    height: 30,
                                    width: 30,
                                    imageUrl: e.imageUrl ?? "",
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                    errorWidget: (context, url, error) =>
                                        SahaEmptyImage(),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(child: Text(e.name!)),
                                  IconButton(
                                      icon: Icon(
                                        Icons.clear,
                                        size: 12,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        addProductController
                                            .listCategorySelectedChild
                                            .removeWhere((element) =>
                                                element.id == e.id);
                                      })
                                ],
                              ),
                            ),
                          )
                  ],
                ))
            .toList(),
      ),
    );
  }

  Widget buildListAttribute() {
    return Obx(
      () => Row(
        children: [
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(children: [
              // ...addProductController.attributeData.entries.map((attribute) {
              //   return Column(
              //     children: [
              //       Container(
              //         height: 1,
              //         color: Colors.grey[100],
              //       ),
              //       Container(
              //         height: 50,
              //         padding: EdgeInsets.only(
              //             left: 0, right: 16, top: 8, bottom: 4),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             InkWell(
              //               onTap: () {
              //                 var index = addProductController.listAttribute
              //                     .indexWhere((e) => e == attribute.key);
              //                 if (index != -1) {
              //                   addProductController.listAttribute
              //                       .removeAt(index);
              //                   addProductController.listAttributeUpdate(
              //                       addProductController.listAttribute);
              //                   addProductController.updateAttribute();
              //                 } else {
              //                   addProductController.attributeData
              //                       .remove(attribute.key);
              //                 }
              //               },
              //               child: Icon(
              //                 Icons.delete,
              //                 size: 20,
              //               ),
              //             ),
              //             SizedBox(
              //               width: 10,
              //             ),
              //             Text(attribute.key),
              //             Expanded(
              //               child: new TextFormField(
              //                 initialValue: addProductController
              //                     .attributeData[attribute],
              //                 textInputAction: TextInputAction.done,
              //                 onChanged: (text) {
              //                   addProductController.addValueToMapAttribute(
              //                       attribute.key, text);
              //                   print(text);
              //                 },
              //                 style: TextStyle(fontSize: 14),
              //                 textAlign: TextAlign.end,
              //                 decoration: InputDecoration(
              //                     isDense: true,
              //                     border: InputBorder.none,
              //                     hintText: "Đặt"),
              //                 minLines: 1,
              //                 maxLines: 1,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   );
              // }).toList(),
              ...addProductController.listAttribute
                  .map((attribute) => Column(
                        children: [
                          Container(
                            height: 1,
                            color: Colors.grey[100],
                          ),
                          Container(
                            height: 50,
                            padding: EdgeInsets.only(
                                left: 0, right: 16, top: 8, bottom: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                    onTap: () {
                                      addProductController.listAttribute
                                          .remove(attribute);
                                      print(addProductController.listAttribute);
                                      addProductController.listAttributeUpdate(
                                          addProductController.listAttribute);
                                      print(addProductController
                                          .listAttributeUpdate);
                                      addProductController.updateAttribute();
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      size: 20,
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(attribute),
                                Expanded(
                                  child: TextFormField(
                                    initialValue: addProductController
                                        .attributeData[attribute],
                                    textInputAction: TextInputAction.done,
                                    validator: (value) {},
                                    onChanged: (text) {
                                      addProductController
                                          .addValueToMapAttribute(
                                              attribute, text);
                                    },
                                    style: TextStyle(fontSize: 14),
                                    textAlign: TextAlign.end,
                                    decoration: InputDecoration(
                                        isDense: true,
                                        border: InputBorder.none,
                                        hintText: "Đặt"),
                                    minLines: 1,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))
                  .toList(),
            ]),
          ),
        ],
      ),
    );
  }

  Widget buildListDistribute() {
    return GestureDetector(
      onTap: () {
        toDistributeEdit(widget.product == null ? true : false);
      },
      child: Obx(() {
        var distribute = addProductController.listDistribute[0];
        return Column(
          children: [
            Container(
              height: 1,
              color: Colors.grey[100],
            ),
            Container(
              height: 60,
              padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Icon(
                            Icons.add_box_outlined,
                            size: 15,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          AutoSizeText(distribute.name!)
                        ],
                      )),
                  Expanded(
                      flex: 7,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: distribute.elementDistributes!
                                .map((e) => Container(
                                      margin: EdgeInsets.only(right: 4),
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      alignment: Alignment.center,
                                      height: 60,
                                      child: Row(
                                        children: [
                                          e?.imageUrl != null
                                              ? Container(
                                                  width: 40,
                                                  height: 40,
                                                  margin:
                                                      EdgeInsets.only(right: 5),
                                                  child: CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    imageUrl: e!.imageUrl!,
                                                    placeholder: (context,
                                                            url) =>
                                                        Center(
                                                            child:
                                                                SahaLoadingWidget()),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                  ),
                                                )
                                              : Container(),
                                          Text(e?.name ?? ""),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ))),
                ],
              ),
            ),
            if (distribute.elementDistributes != null &&
                distribute.elementDistributes!.isNotEmpty &&
                distribute.subElementDistributeName != null)
              Column(
                children: [
                  Container(
                    height: 1,
                    color: Colors.grey[100],
                  ),
                  Container(
                    height: 60,
                    padding:
                        EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 3,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add_box_outlined,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                AutoSizeText(
                                    distribute.subElementDistributeName!)
                              ],
                            )),
                        if (distribute
                                .elementDistributes![0]!.subElementDistribute !=
                            null)
                          Expanded(
                              flex: 7,
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: distribute.elementDistributes![0]!
                                        .subElementDistribute!
                                        .map((e) => Container(
                                              margin: EdgeInsets.only(right: 4),
                                              padding: EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              alignment: Alignment.center,
                                              height: 60,
                                              child: Row(
                                                children: [
                                                  Text(e.name!),
                                                ],
                                              ),
                                            ))
                                        .toList(),
                                  ))),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        );
      }),
    );
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    addProductController.textEditingControllerBarcode.value.text =
        barcodeScanRes == "-1" ? '' : barcodeScanRes;
    addProductController.productRequest.barcode = barcodeScanRes;
    addProductController.textEditingControllerBarcode.refresh();
  }

  Widget itemProduct(Product product, bool isNew) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isNew != true)
            MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                if (isNew == true) {
                } else {
                  if (!(product.inventory?.distributes != null &&
                      product.inventory!.distributes!.isNotEmpty)) {
                    PopupInput().showDialogInputInfoInventory(
                        stockInput: product.inventory!.mainStock,
                        priceInput: product.inventory!.mainCostOfCapital,
                        confirm: (v) {
                          addProductController
                              .updateInventoryProduct(InventoryRequest(
                            productId: product.id,
                            distributeName: null,
                            elementDistributeName: null,
                            stock: v["stock"],
                            costOfCapital: v["price_capital"],
                            subElementDistributeName: null,
                          ));
                        });
                  }
                }
              },
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                      imageUrl:
                          product.images != null && product.images!.isNotEmpty
                              ? (product.images![0].imageUrl ?? "")
                              : "",
                      placeholder: (context, url) => new SahaLoadingWidget(
                        size: 30,
                      ),
                      errorWidget: (context, url, error) => new Icon(
                        Ionicons.image_outline,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${product.name}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  if (isNew != true)
                    if (product.inventory?.distributes == null ||
                        product.inventory!.distributes!.isEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding:
                                const EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Text(
                              "Vốn: ${SahaStringUtils().convertToMoney(!(product.inventory?.distributes != null && product.inventory!.distributes!.isNotEmpty) ? "${product.inventory?.mainCostOfCapital ?? 0}" : 0)}",
                              style: TextStyle(
                                  color: SahaColorUtils()
                                      .colorPrimaryTextWithWhiteBackground(),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                              maxLines: 1,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding:
                                const EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Text(
                              "Kho: ${!(product.inventory?.distributes != null && product.inventory!.distributes!.isNotEmpty) ? "${product.inventory!.mainStock ?? 0}" : ""}",
                              style: TextStyle(
                                  color: SahaColorUtils()
                                      .colorPrimaryTextWithWhiteBackground(),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                ],
              ),
            ),
          // Divider(
          //   height: 1,
          // ),
          // SizedBox(
          //   height: 5,
          // ),
          // if (isNew != true)
          //   if (product.inventory?.distributes != null &&
          //       product.inventory!.distributes!.isNotEmpty)
          //     ...product.inventory!.distributes![0].elementDistributes!
          //         .map((e) => itemDistribute(e, product))
          //         .toList(),
          // if (isNew == true)
          //   Obx(
          //     () => Column(
          //       children: [
          //         if (addProductController.listDistribute.isNotEmpty)
          //           ...addProductController
          //               .listDistribute[0].elementDistributes!
          //               .map((e) => itemDistribute2(e!, product))
          //               .toList(),
          //       ],
          //     ),
          //   )
        ],
      ),
    );
  }

  Widget itemDistribute(
      ElementDistributes elementDistributes, Product product) {
    return Column(
      children: [
        if (elementDistributes.subElementDistribute == null ||
            elementDistributes.subElementDistribute!.isEmpty)
          InkWell(
            onTap: () {
              PopupInput().showDialogInputInfoInventory(
                  stockInput: elementDistributes.stock,
                  priceInput: elementDistributes.priceCapital,
                  confirm: (v) {
                    addProductController
                        .updateInventoryProduct(InventoryRequest(
                      productId: product.id,
                      distributeName: (product.distributes != null &&
                              product.distributes!.isNotEmpty)
                          ? product.distributes![0].name
                          : null,
                      elementDistributeName: elementDistributes.name,
                      stock: v["stock"],
                      costOfCapital: v["price_capital"],
                      subElementDistributeName: null,
                    ));
                  });
            },
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                    height: 45,
                    width: 45,
                    fit: BoxFit.cover,
                    imageUrl: elementDistributes.imageUrl != null
                        ? (elementDistributes.imageUrl ?? "")
                        : "",
                    placeholder: (context, url) => new SahaLoadingWidget(
                      size: 30,
                    ),
                    errorWidget: (context, url, error) => new Icon(
                      Ionicons.image_outline,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${elementDistributes.name}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Text(
                        "Vốn: ${SahaStringUtils().convertToMoney(elementDistributes.priceCapital ?? 0)}",
                        style: TextStyle(
                            color: SahaColorUtils()
                                .colorPrimaryTextWithWhiteBackground(),
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Text(
                        "Kho: ${elementDistributes.stock ?? 0}",
                        style: TextStyle(
                            color: SahaColorUtils()
                                .colorPrimaryTextWithWhiteBackground(),
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ...elementDistributes.subElementDistribute!
            .map(
              (e) => Column(
                children: [
                  InkWell(
                    onTap: () {
                      PopupInput().showDialogInputInfoInventory(
                          stockInput: e.stock,
                          priceInput: e.priceCapital,
                          confirm: (v) {
                            addProductController
                                .updateInventoryProduct(InventoryRequest(
                              productId: product.id,
                              distributeName: (product.distributes != null &&
                                      product.distributes!.isNotEmpty)
                                  ? product.distributes![0].name
                                  : null,
                              elementDistributeName: elementDistributes.name,
                              subElementDistributeName: e.name,
                              stock: v["stock"],
                              costOfCapital: v["price_capital"],
                            ));
                          });
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: CachedNetworkImage(
                            height: 45,
                            width: 45,
                            fit: BoxFit.cover,
                            imageUrl: elementDistributes.imageUrl != null
                                ? (elementDistributes.imageUrl ?? "")
                                : "",
                            placeholder: (context, url) =>
                                new SahaLoadingWidget(
                              size: 30,
                            ),
                            errorWidget: (context, url, error) => new Icon(
                              Ionicons.image_outline,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Phân loại: ${!(elementDistributes.subElementDistribute == null || elementDistributes.subElementDistribute!.isEmpty) ? "${elementDistributes.name}," : ""} ${e.name}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 5.0, right: 5.0),
                              child: Text(
                                "Vốn: ${SahaStringUtils().convertToMoney(e.priceCapital ?? 0)}",
                                style: TextStyle(
                                    color: SahaColorUtils()
                                        .colorPrimaryTextWithWhiteBackground(),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                                maxLines: 1,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 5.0, right: 5.0),
                              child: Text(
                                "Kho: ${e.stock ?? 0}",
                                style: TextStyle(
                                    color: SahaColorUtils()
                                        .colorPrimaryTextWithWhiteBackground(),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  )
                ],
              ),
            )
            .toList(),
        Divider(
          height: 1,
        )
      ],
    );
  }

  Widget itemDistribute2(
      ElementDistributesRequest elementDistributes, Product product) {
    return Column(
      children: [
        if (elementDistributes.subElementDistribute == null ||
            elementDistributes.subElementDistribute!.isEmpty)
          InkWell(
            onTap: () {
              PopupInput().showDialogInputInfoInventory(
                  stockInput: elementDistributes.stock,
                  priceInput: elementDistributes.priceCapital,
                  confirm: (v) {
                    elementDistributes.stock = v["stock"];
                    elementDistributes.priceCapital = v["price_capital"];
                    addProductController.listDistribute.refresh();
                  });
            },
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                    height: 45,
                    width: 45,
                    fit: BoxFit.cover,
                    imageUrl: elementDistributes.imageUrl != null
                        ? (elementDistributes.imageUrl ?? "")
                        : "",
                    placeholder: (context, url) => new SahaLoadingWidget(
                      size: 30,
                    ),
                    errorWidget: (context, url, error) => new Icon(
                      Ionicons.image_outline,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${elementDistributes.name}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Text(
                        "Vốn: ${SahaStringUtils().convertToMoney(elementDistributes.priceCapital ?? 0)}",
                        style: TextStyle(
                            color: SahaColorUtils()
                                .colorPrimaryTextWithWhiteBackground(),
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Text(
                        "Kho: ${elementDistributes.stock ?? 0}",
                        style: TextStyle(
                            color: SahaColorUtils()
                                .colorPrimaryTextWithWhiteBackground(),
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        if (elementDistributes.subElementDistribute != null)
          ...elementDistributes.subElementDistribute!
              .map(
                (e) => Column(
                  children: [
                    InkWell(
                      onTap: () {
                        PopupInput().showDialogInputInfoInventory(
                            stockInput: e.stock,
                            priceInput: e.priceCapital,
                            confirm: (v) {
                              e.stock = v["stock"];
                              e.priceCapital = v["price_capital"];
                            });

                        addProductController.listDistribute.refresh();
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                              height: 45,
                              width: 45,
                              fit: BoxFit.cover,
                              imageUrl: elementDistributes.imageUrl != null
                                  ? (elementDistributes.imageUrl ?? "")
                                  : "",
                              placeholder: (context, url) =>
                                  new SahaLoadingWidget(
                                size: 30,
                              ),
                              errorWidget: (context, url, error) => new Icon(
                                Ionicons.image_outline,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Phân loại: ${!(elementDistributes.subElementDistribute == null || elementDistributes.subElementDistribute!.isEmpty) ? "${elementDistributes.name}," : ""} ${e.name}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                child: Text(
                                  "Vốn: ${SahaStringUtils().convertToMoney(e.priceCapital ?? 0)}",
                                  style: TextStyle(
                                      color: SahaColorUtils()
                                          .colorPrimaryTextWithWhiteBackground(),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                  maxLines: 1,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                child: Text(
                                  "Kho: ${e.stock ?? 0}",
                                  style: TextStyle(
                                      color: SahaColorUtils()
                                          .colorPrimaryTextWithWhiteBackground(),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                    )
                  ],
                ),
              )
              .toList(),
        Divider(
          height: 1,
        )
      ],
    );
  }
}
