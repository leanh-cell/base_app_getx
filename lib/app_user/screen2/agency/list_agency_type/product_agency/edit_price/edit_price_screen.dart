import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/text_field_no_border.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/product/product_request.dart';
import 'package:com.ikitech.store/app_user/model/update_agency_request.dart';
import 'package:com.ikitech.store/app_user/screen2/agency/list_agency_type/product_agency/edit_price/widget/distribute_select_controller.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import 'edit_price_controller.dart';

class EditPriceScreen extends StatefulWidget {
  Product? product;
  int agencyTypeIdRequest;
  int page;
  EditPriceScreen(
      {Key? key,
      this.product,
      required this.agencyTypeIdRequest,
      required this.page});

  @override
  _EditPriceScreenState createState() => _EditPriceScreenState();
}

class _EditPriceScreenState extends State<EditPriceScreen> {
  final _formKey = GlobalKey<FormState>();

  late EditPriceController addProductController;
  late DistributesRequest distributesRequest;
  DistributesRequest? distributesRequestMain;
  bool checkChange = false;
  final DistributeSelectController distributeSelectController =
      Get.put(DistributeSelectController());

  @override
  void initState() {
    super.initState();
    addProductController = new EditPriceController(
        productEd: widget.product,
        agencyTypeIdRequest: widget.agencyTypeIdRequest,
        page: widget.page);

    var distributesRequestInput = distributeSelectController.listDistribute[0];
    distributesRequest = distributesRequestInput;

    var distributesRequestMains =
        addProductController.distributesRequestMain.value;
    distributesRequestMain = distributesRequestMains;
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
              titleText: 'Sửa giá sản phẩm',
            ),
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                color: Colors.red.withOpacity(0.1),
                                child: Text(
                                    "Giá đại lý sẽ bằng giá gốc nếu các trường phân loại bị bỏ trống"),
                              ),
                              if (distributesRequest.elementDistributes == null)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Obx(
                                      () => Expanded(
                                        child: SahaTextFieldNoBorder(
                                          enabled: !addProductController
                                                  .isContactPrice.value
                                              ? true
                                              : true,
                                          controller: addProductController
                                              .textEditingControllerPrice,
                                          inputFormatters: [
                                            ThousandsFormatter()
                                          ],
                                          validator: (value) {
                                            if (value!.length == 0) {
                                              return 'Không được để trống';
                                            }
                                            return null;
                                          },
                                          textInputType: TextInputType.number,
                                          labelText: "Giá đại lý",
                                          hintText: "Đặt",
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Giá nhập"),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(SahaStringUtils().convertToUnit(
                                              widget.product!.priceImport
                                                  .toString()))
                                        ],
                                      ),
                                    ),
                                  
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Giá bán lẻ"),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(widget.product!.price == 0
                                              ? "Liên hệ"
                                              : SahaStringUtils().convertToUnit(
                                                  widget.product!.price
                                                      .toString()))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              if (distributesRequest.elementDistributes != null)
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration:
                                      BoxDecoration(color: Colors.grey[200]),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width: Get.width * 0.4,
                                          child: Text("Phân loại hàng")),
                                      SizedBox(
                                          width: Get.width * 0.25,
                                          child: Text("Giá đại lý")),
                                      SizedBox(
                                          width: Get.width * 0.18,
                                          child: Text("Giá bán lẻ")),
                                    ],
                                  ),
                                ),
                              if (distributesRequest.elementDistributes != null)
                                ...List.generate(
                                    distributesRequest
                                        .elementDistributes!.length,
                                    (index) => elementDistribute(
                                        distributesRequest
                                            .elementDistributes![index]!,
                                        distributesRequestMain!
                                            .elementDistributes![index]!,
                                        index)),
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
                                  text: "Xác nhận",
                                  onPressed: () {
                                    if (parse() != null &&
                                        widget.product?.id != null) {
                                      addProductController
                                          .updateProductPriceAgency(
                                              widget.product?.id ?? 0,
                                              parse()!);
                                    }
                                    print(
                                        "${distributeSelectController.listDistribute[0].toJson()}");
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
                Obx(() {
                  return (addProductController.isLoadingAdd.value)
                      ? SahaLoadingFullScreen()
                      : Container();
                })
              ],
            )),
      ),
    );
  }

  UpdatePriceAgencyRequest? parse() {
    List<ElementDistributesPrice> listE = [];
    List<ElementDistributesPrice> listS = [];
    distributeSelectController.listDistribute[0] = distributesRequest;
    if (distributeSelectController.listDistribute[0].elementDistributes !=
        null) {
      distributeSelectController.listDistribute[0].elementDistributes!
          .forEach((e) {
        listE.add(ElementDistributesPrice(
          distributeName: distributeSelectController.listDistribute[0].name,
          elementDistribute: e?.name ?? "",
          price: e?.price ??
              double.parse(
                  "${SahaStringUtils().convertFormatText(addProductController.textEditingControllerPrice.text)}"),
        ));
      });
      distributeSelectController.listDistribute[0].elementDistributes!
          .forEach((e) {
        if (e != null && e.subElementDistribute != null) {
          e.subElementDistribute!.forEach((sub) {
            listS.add(ElementDistributesPrice(
              distributeName: distributeSelectController.listDistribute[0].name,
              elementDistribute: e.name ?? "",
              subElementDistribute: sub.name ?? "",
              price: sub.price ??
                  double.parse(
                      "${SahaStringUtils().convertFormatText(addProductController.textEditingControllerPrice.text)}"),
            ));
          });
        }
      });
      return UpdatePriceAgencyRequest(
        agencyTypeId: widget.agencyTypeIdRequest,
        mainPrice: double.parse(
            "${SahaStringUtils().convertFormatText(addProductController.textEditingControllerPrice.text == "Liên hệ" ? "0" : addProductController.textEditingControllerPrice.text)}"),
        elementDistributesPrice: listE,
        subElementDistributesPrice: listS,
      );
    } else {
      return UpdatePriceAgencyRequest(
        agencyTypeId: widget.agencyTypeIdRequest,
        mainPrice: double.parse(
            "${SahaStringUtils().convertFormatText(addProductController.textEditingControllerPrice.text)}"),
        elementDistributesPrice: listE,
        subElementDistributesPrice: listS,
      );
    }
  }

  Widget elementDistribute(ElementDistributesRequest elementDistributesRequest,
      ElementDistributesRequest elementDistributesRequestMain, int index) {
    var priceEditController = TextEditingController(
      text: elementDistributesRequest.price == null
          ? null
          : "${SahaStringUtils().convertToUnit(elementDistributesRequest.price)}",
    );

    var mainPrice = elementDistributesRequestMain.price == null
        ? null
        : "${SahaStringUtils().convertToUnit(elementDistributesRequestMain.price)}";

    priceEditController.selection = TextSelection.fromPosition(
        TextPosition(offset: priceEditController.text.length));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: Get.width * 0.4,
                  child: Text(elementDistributesRequest.name ?? "")),
              elementDistributesRequest.subElementDistribute != null
                  ? elementDistributesRequest.subElementDistribute!.isEmpty
                      ? Container(
                          width: Get.width * 0.48,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 30,
                                width: Get.width * 0.25,
                                child: TextField(
                                  controller: priceEditController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    ThousandsFormatter(),
                                  ],
                                  textInputAction: TextInputAction.done,
                                  style: TextStyle(fontSize: 14),
                                  decoration: InputDecoration(
                                    prefixText: "₫",
                                    contentPadding: EdgeInsets.only(left: 5),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                  ),
                                  onChanged: (v) {
                                    if (v != "") {
                                      distributesRequest
                                              .elementDistributes![index]!
                                              .price =
                                          double.parse(SahaStringUtils()
                                              .convertFormatText(v));
                                      print(distributesRequest.toJson());
                                    } else {
                                      distributesRequest
                                          .elementDistributes![index]!
                                          .price = null;
                                    }
                                    checkChange = true;
                                  },
                                ),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey[300]!)),
                              ),
                              Container(
                                height: 30,
                                width: Get.width * 0.15,
                                child: Center(
                                  child: Text(
                                    "₫${mainPrice ?? ""}",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey[300]!)),
                              ),
                            ],
                          ),
                        )
                      : Container()
                  : Container(
                      width: Get.width * 0.48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 30,
                            width: Get.width * 0.25,
                            child: TextField(
                              controller: priceEditController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                ThousandsFormatter(),
                              ],
                              textInputAction: TextInputAction.done,
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                prefixText: "₫",
                                contentPadding: EdgeInsets.only(left: 5),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                              onChanged: (v) {
                                if (v != "") {
                                  distributesRequest
                                          .elementDistributes![index]!.price =
                                      double.parse(SahaStringUtils()
                                          .convertFormatText(v));
                                  print(distributesRequest.toJson());
                                } else {
                                  distributesRequest
                                      .elementDistributes![index]!.price = null;
                                }
                                checkChange = true;
                              },
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!)),
                          ),
                        ],
                      ),
                    )
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
        if (elementDistributesRequest.subElementDistribute != null)
          ...List.generate(
              elementDistributesRequest.subElementDistribute!.length,
              (indexSub) {
            var priceEditController = TextEditingController(
              text: elementDistributesRequest
                          .subElementDistribute![indexSub].price ==
                      null
                  ? null
                  : "${SahaStringUtils().convertToUnit(elementDistributesRequest.subElementDistribute![indexSub].price)}",
            );
            priceEditController.selection = TextSelection.fromPosition(
                TextPosition(offset: priceEditController.text.length));

            var mainPrice = elementDistributesRequestMain
                        .subElementDistribute![indexSub].price ==
                    null
                ? null
                : "${SahaStringUtils().convertToUnit(elementDistributesRequestMain.subElementDistribute![indexSub].price)}";

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: Get.width * 0.4,
                          child: Text(elementDistributesRequest
                                  .subElementDistribute![indexSub].name ??
                              "")),
                      Container(
                        height: 30,
                        width: Get.width * 0.25,
                        child: TextField(
                          controller: priceEditController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            ThousandsFormatter(),
                          ],
                          //textInputAction: TextInputAction.done,
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            prefixText: "₫",
                            contentPadding: EdgeInsets.only(left: 5),
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                          onChanged: (v) {
                            checkChange = true;
                            if (v != "") {
                              distributesRequest.elementDistributes![index]!
                                      .subElementDistribute![indexSub].price =
                                  double.parse(
                                      SahaStringUtils().convertFormatText(v));
                            } else {
                              distributesRequest.elementDistributes![index]!
                                  .subElementDistribute![indexSub].price = null;
                              print(distributesRequest.toJson());
                            }
                          },
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!)),
                      ),
                      Container(
                        height: 30,
                        width: Get.width * 0.15,
                        child: Center(
                            child: Text(
                          "₫${mainPrice ?? ""}",
                          style: TextStyle(fontSize: 13),
                        )),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                ),
              ],
            );
          }),
        Container(
          height: 8,
          color: Colors.grey[200],
        )
      ],
    );
  }
}
