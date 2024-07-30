import 'dart:convert';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/sahashopTextField.dart';
import 'package:get/get.dart';

import '../../../../data/remote/response-request/payment_method/all_payment_method_res.dart';
import '../../../config_app/screens_config/logo_type/select_logo_image.dart';

class ConfigPaymentGuideBank extends StatefulWidget {
  final List<PaymentGuide>? listPaymentMethod;
  final Function? onSave;

  const ConfigPaymentGuideBank({Key? key, this.listPaymentMethod, this.onSave})
      : super(key: key);

  @override
  _ConfigPaymentGuideBankState createState() => _ConfigPaymentGuideBankState();
}

class _ConfigPaymentGuideBankState extends State<ConfigPaymentGuideBank> {
  List<BankModel> listBanks = [];

  @override
  void initState() {
    
    super.initState();
    if (widget.listPaymentMethod != null) {
      widget.listPaymentMethod!.forEach((e) {
        listBanks.add(BankModel(
            nameAccount: e.accountName,
            numAccount: e.accountNumber,
            bankName: e.bank,
            branchName: e.branch,
            qrCodeImageUrl:e.qrCodeImageUrl
        ));
      });
    }
    
  }

  void onSave() {
    widget.onSave!(listBanks);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Expanded(
          child: ReorderableList(
              itemBuilder: (context, index) {
                return Container(
                    key: Key(index.toString()),
                    child: Column(
                      children: [
                        BankItemWidget(bankModel: listBanks[index]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            buildItemOption(
                                title: "Sửa",
                                onTap: () {
                                  _modalBottomSheetMenu(
                                      bankModel: listBanks[index],
                                      onSubmit: (BankModel modelBank) {
                                        if (modelBank.nameAccount != "" &&
                                            modelBank.numAccount != "") {
                                          listBanks[index] = modelBank;
                                          onSave();
                                          setState(() {});
                                        }
                                      });
                                }),
                            buildItemOption(
                                title: "Xóa",
                                onTap: () {
                                  SahaDialogApp.showDialogYesNo(
                                      mess:
                                          "Bạn có chắc muốn xoá tài khoản ngân hàng này chứ ?",
                                      onOK: () {
                                        listBanks.removeAt(index);
                                        onSave();
                                        setState(() {});
                                      });
                                }),
                          ],
                        ),
                        Divider(),
                      ],
                    ));
              },
              itemCount: listBanks.length,
              onReorder: (int fromIndex, int toIndex) {}),
        ),
        SahaButtonFullParent(
          color: Theme.of(context).primaryColor,
          text: "Thêm",
          onPressed: () {
            _modalBottomSheetMenu(onSubmit: (BankModel bankModel) {
              if (bankModel.nameAccount != "" && bankModel.numAccount != "") {
                listBanks.add(bankModel);
                onSave();
                setState(() {});
              }
            });
          },
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  Future<dynamic> _modalBottomSheetMenu(
      {BankModel? bankModel, Function? onSubmit}) async {
    var name = TextEditingController();
    var num = TextEditingController();
    var bank = TextEditingController();
    var branch = TextEditingController();
    var image = "";

    if (bankModel != null) {
      name.text = bankModel.nameAccount!;
      num.text = bankModel.numAccount!;
      bank.text = bankModel.bankName!;
      branch.text = bankModel.branchName!;
      image = bankModel.qrCodeImageUrl ?? '';
    }
    final _formKey = GlobalKey<FormState>();

    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SelectLogoImage(
                        linkLogo: image,
                        onChange: (link) {
                          image = link;
                        },
                      ),
                    ),
                    Text(
                      'Hình ảnh chuyển khoản QRCode',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    )
                  ],
                ),
                SahaTextField(
                  labelText: "Tên chủ tài khoản",
                  controller: name,
                  autoFocus: true,
                  validator: (v) {
                    if (v!.length < 1) {
                      return "Chưa nhập thông tin";
                    } else {
                      return null;
                    }
                  },
                ),
                Divider(),
                SahaTextField(
                  labelText: "Số tài khoản",
                  textInputType: TextInputType.number,
                  controller: num,
                  validator: (v) {
                    if (v!.length < 1) {
                      return "Chưa nhập thông tin";
                    } else {
                      return null;
                    }
                  },
                ),
                Divider(),
                SahaTextField(
                  labelText: "Tên ngân hàng",
                  controller: bank,
                  validator: (v) {
                    if (v!.length < 1) {
                      return "Chưa nhập thông tin";
                    } else {
                      return null;
                    }
                  },
                ),
                Divider(),
                SahaTextField(
                  labelText: "Chi nhánh",
                  controller: branch,
                  validator: (v) {
                    if (v!.length < 1) {
                      return "Chưa nhập thông tin";
                    } else {
                      return null;
                    }
                  },
                ),
                Divider(),
                SahaButtonFullParent(
                  color: Theme.of(context).primaryColor,
                  text: "Lưu",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (onSubmit != null) {
                        onSubmit(BankModel(
                          nameAccount: name.text,
                          numAccount: num.text,
                          bankName: bank.text,
                          branchName: branch.text,
                          qrCodeImageUrl: image,
                        ));
                      }
                      Navigator.pop(context);
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildItemOption({required String title, Function? onTap}) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.only(right: 8, left: 8, bottom: 5, top: 5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(3))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [Text(title)],
            )
          ],
        ),
      ),
    );
  }
}

class BankItemWidget extends StatelessWidget {
  final BankModel? bankModel;

  const BankItemWidget({Key? key, this.bankModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text("Tên chủ tài khoản")),
                Expanded(child: Text(bankModel!.nameAccount ?? "")),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text("Số tài khoản")),
                Expanded(child: Text(bankModel!.numAccount ?? "")),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text("Ngân hàng")),
                Expanded(child: Text(bankModel!.bankName ?? "")),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text("Chi nhánh")),
                Expanded(child: Text(bankModel!.branchName ?? "")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BankModel {
  String? nameAccount;
  String? numAccount;
  String? bankName;
  String? branchName;
  String? qrCodeImageUrl;

  BankModel(
      {this.nameAccount,
      this.numAccount,
      this.bankName,
      this.branchName,
      this.qrCodeImageUrl});

  BankModel.fromJson(Map<String, dynamic> json) {
    nameAccount = json['account_name'] ?? "";
    numAccount = json['account_number'] ?? "";
    bankName = json['bank'] ?? "";
    branchName = json['branch'] ?? "";
    qrCodeImageUrl = json['qr_code_image_url'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_name'] = this.nameAccount;
    data['account_number'] = this.numAccount;
    data['bank'] = this.bankName;
    data['branch'] = this.branchName;
    data['qr_code_image_url'] = this.qrCodeImageUrl;
    return data;
  }
}
