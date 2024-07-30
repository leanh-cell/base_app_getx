import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/sahashopTextField.dart';
import 'package:com.ikitech.store/app_user/screen2/config/mini_game/mini_game_spin_wheel/gift/add_gift/add_gift_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

import '../../../../../../components/picker/product/product_picker.dart';
import '../../../../../../components/saha_user/button/saha_button.dart';
import '../../../../../../components/saha_user/dialog/dialog.dart';
import '../../../../../../components/saha_user/text_field/text_field_no_border.dart';
import '../../../../../../components/saha_user/toast/saha_alert.dart';
import '../../../../../../components/widget/image_picker_single/image_picker_single.dart';
import '../../add_mini_game/add_mini_game_controller.dart';

class AddGiftScreen extends StatelessWidget {
  AddGiftScreen({Key? key, required this.spinId, this.id}) {
    addGiftController = AddGiftController(spinId: spinId, id: id);
  }
  final int spinId;
  final int? id;
  late final AddGiftController addGiftController;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(id == null ? 'Thêm phần thưởng' : 'Cập nhật phần thưởng'),
          actions: [
            id != null
                ? GestureDetector(
                    onTap: () {
                      SahaDialogApp.showDialogYesNo(
                          mess: "Bạn có chắc muốn xoá phần thưởng này",
                          onClose: () {},
                          onOK: () {
                            addGiftController.deleteGift();
                          });
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Icon(
                        FontAwesomeIcons.trashCan,
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
        body: Obx(
          () => addGiftController.loadInit.value
              ? SahaLoadingFullScreen()
              : Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            SahaDialogApp.showDialogServiceType(
                              onChoose: (v, t) {
                                addGiftController.giftReq.value.typeGift = v;
                                addGiftController
                                    .typeTextEditingController.text = t;
                                addGiftController.giftReq.refresh();
                              },
                            );
                          },
                          child: SahaTextFieldNoBorder(
                            onTap: () {
                              SahaDialogApp.showDialogServiceType(
                                onChoose: (v, t) {
                                  addGiftController.giftReq.value.typeGift = v;
                                  addGiftController
                                      .typeTextEditingController.text = t;
                                  addGiftController.giftReq.refresh();
                                },
                              );
                            },
                            //enabled: false,
                            readOnly: true,
                            controller:
                                addGiftController.typeTextEditingController,

                            validator: (value) {
                              if (value!.length == 0) {
                                return 'Không được để trống';
                              }
                              return null;
                            },
                            withAsterisk: true,
                            labelText: 'Loại phần thưởng',
                            hintText: "Chọn loại phần thưởng",
                          ),
                        ),
                        SahaTextField(
                          labelText: 'Tên phần thưởng',
                          hintText: 'Nhập tên phần thưởng',
                          controller: addGiftController.giftName,
                          validator: (value) {
                            if (value!.length < 1) {
                              return 'Chưa nhập tên phần thưởng';
                            }
                            return null;
                          },
                          onChanged: (v) {
                            addGiftController.giftReq.value.name = v;
                          },
                        ),
                        Obx(() => addGiftController.giftReq.value.typeGift == 0
                            ? SahaTextField(
                                textInputType: TextInputType.number,
                                labelText: 'Số xu thưởng',
                                hintText: "Nhập số xu thưởng",
                                controller: addGiftController.amountCoin,
                                onChanged: (v) {
                                  addGiftController.giftReq.value.amountCoin =
                                      int.parse(v!);
                                },
                                validator: (value) {
                                  if (value!.length < 1) {
                                    return 'Chưa nhập tên phần thưởng';
                                  }
                                  return null;
                                },
                              )
                            : addGiftController.giftReq.value.typeGift == 1
                                ? Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.to(() => ProductPickerScreen(
                                                listProductInput: [],
                                                onlyOne: true,
                                                callback:
                                                    (List<Product> products) {
                                                  if (products.length > 1) {
                                                    SahaAlert.showError(
                                                        message:
                                                            "Chọn tối đa 1 sản phẩm");
                                                  } else {
                                                    addGiftController.giftReq
                                                            .value.text =
                                                        products[0].name ?? '';
                                                    addGiftController
                                                            .text.text =
                                                        products[0].name ?? '';
                                                    addGiftController
                                                            .giftName.text =
                                                        products[0].name ?? '';
                                                    addGiftController.giftReq
                                                            .value.valueGift =
                                                        (products[0].id!)
                                                            .toString();
                                                  }
                                                },
                                              ));
                                        },
                                        child: SahaTextField(
                                          enabled: false,
                                          labelText: "Chọn sản phẩm ",
                                          hintText: "Chọn sản phẩm",
                                          controller: addGiftController.text,
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox()),
                        SahaTextField(
                          suffix: '%',
                          labelText: 'Phần trăm trúng thưởng',
                          hintText: 'Nhập tỉ lệ trúng thưởng',
                          controller: addGiftController.percentReceived,
                          textInputType:
                              TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'(^\d*\.?\d*)')),
                          ],
                          validator: (value) {
                            if (value!.length < 1) {
                              return 'Chưa nhập tên phần thưởng';
                            }
                            return null;
                          },
                          onChanged: (v) {
                            addGiftController.giftReq.value.percentReceived =
                                double.tryParse(v!);
                          },
                        ),
                        SahaTextField(
                          textInputType: TextInputType.number,
                          labelText: 'Số lượng quà',
                          hintText: 'Nhập số lượng',
                          controller: addGiftController.amountGift,
                          validator: (value) {
                            if (value!.length < 1) {
                              return 'Chưa nhập số lượng';
                            }
                            return null;
                          },
                          onChanged: (v) {
                            addGiftController.giftReq.value.amountGift =
                                int.tryParse(v!);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Chọn ảnh phần thưởng'),
                              Obx(
                                () => ImagePickerSingle(
                                  context: context,
                                  type: '',
                                  linkLogo:
                                      addGiftController.giftReq.value.imageUrl,
                                  onChange: (link) {
                                    addGiftController.giftReq.value.imageUrl =
                                        link;
                                    addGiftController.giftReq.refresh();
                                  },
                                ),
                              ),
                            ],
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
                text: id == null ? "Thêm phần thưởng" : "Cập nhật phần thưởng",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (id == null) {
                      addGiftController.addGift(spinId: spinId);
                    } else {
                      addGiftController.updateGift();
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
