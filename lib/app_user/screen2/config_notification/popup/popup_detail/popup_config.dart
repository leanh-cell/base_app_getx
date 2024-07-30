import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/model/popup_config.dart';
import 'popup_config_controller.dart';

class PopupConfigDetail extends StatelessWidget {
  late PopupConfigController popupConfigController;
  bool? isUpdate;
  PopupCf? popupCfInput;
  PopupConfigDetail({this.isUpdate = false, this.popupCfInput}) {
    popupConfigController = PopupConfigController(popupCfInput: popupCfInput);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${isUpdate == true ? "Chỉnh sửa quảng cáo" : "Thêm hình quảng cáo"}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10),
              child: Text(
                "Chọn Loại chuyển hướng",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            listItemChoose(popupConfigController.listTypeConfig),
            Obx(() => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: showValueBox(),
                )),
            Obx(
              () => Container(
                color: Colors.white,
                height: 50,
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Hiển thị chỉ một lần"),
                    CupertinoSwitch(
                      value: popupConfigController.popupCf.value.showOnce!,
                      onChanged: (bool value) {
                        popupConfigController.popupCf.value.showOnce =
                            !popupConfigController.popupCf.value.showOnce!;
                        popupConfigController.popupCf.refresh();
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Hình ảnh quảng cáo",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                ),
                Obx(
                  () => InkWell(
                    onTap: () {
                      popupConfigController.loadAssets();
                    },
                    child: ClipRRect(
                      child: popupConfigController.isUpdatingImage.value == true
                          ? SahaLoadingWidget()
                          : Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        popupConfigController.logoUrl.value,
                                    fit: BoxFit.fitWidth,
                                    placeholder: (context, url) =>
                                        SahaLoadingWidget(),
                                    errorWidget: (context, url, error) =>
                                        Padding(
                                      padding: const EdgeInsets.all(40.0),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.camera_enhance_outlined),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Thêm",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        color: Colors.white,
        child: Column(
          children: [
            SahaButtonFullParent(
              text: "Lưu",
              onPressed: () {
                if (isUpdate!) {
                  popupConfigController.updatePopup();
                } else {
                  popupConfigController.addPopupTo();
                }
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget showValueBox() {
    var codeCurrent = popupConfigController.codeCurrent.value;
    if (codeCurrent == "LINK") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nhập địa chỉ Website",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              new Expanded(
                child: new TextField(
                  controller: popupConfigController.textEditingController,
                  decoration: new InputDecoration(
                    prefixText: "https://",
                  ),
                  // onSubmitted: (v) {
                  //   if (GetUtils.isURL(v)) {
                  //     popupConfigController.popupCf.value.valueAction =
                  //         "https://$v";
                  //     popupConfigController.popupCf.value.name = v;
                  //     print("======");
                  //   } else {
                  //     popupConfigController.textEditingController.text = "";
                  //     popupConfigController.popupCf.value.valueAction = null;
                  //     popupConfigController.popupCf.value.name = null;
                  //     SahaAlert.showError(
                  //         message: "Không tồn tại địa chỉ web này");
                  //   }
                  // },
                  onChanged: (v) {
                    popupConfigController.popupCf.value.valueAction =
                        "https://$v";
                    popupConfigController.popupCf.value.name = v;
                  },
                ),
              )
            ],
          ),
        ],
      );
    } else if (codeCurrent == "PRODUCT") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Chọn Sản phẩm",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              popupConfigController.addPopup("PRODUCT");
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border:
                      Border.all(color: Theme.of(Get.context!).primaryColor)),
              child: Center(
                child: Obx(
                  () => Text(
                    "${popupConfigController.popupCf.value.name ?? "Nhấn chọn"}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else if (codeCurrent == "CATEGORY_PRODUCT") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Chọn Danh mục sản phẩm",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              popupConfigController.addPopup("CATEGORY_PRODUCT");
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border:
                      Border.all(color: Theme.of(Get.context!).primaryColor)),
              child: Center(
                child: Obx(
                  () => Text(
                    "${popupConfigController.popupCf.value.name ?? "Nhấn chọn"}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else if (codeCurrent == "POST") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Chọn Bài viết",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              popupConfigController.addPopup("POST");
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border:
                      Border.all(color: Theme.of(Get.context!).primaryColor)),
              child: Center(
                child: Obx(
                  () => Text(
                    "${popupConfigController.popupCf.value.name ?? "Nhấn chọn"}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else if (codeCurrent == "CATEGORY_POST") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Chọn Danh mục bài viết",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              popupConfigController.addPopup("CATEGORY_POST");
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border:
                      Border.all(color: Theme.of(Get.context!).primaryColor)),
              child: Center(
                child: Obx(
                  () => Text(
                    "${popupConfigController.popupCf.value.name ?? "Nhấn chọn"}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget listItemChoose(List<String> inputCode) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Wrap(
          children: [
            InkWell(
              onTap: () {
                popupConfigController.codeCurrent.value = "LINK";
                popupConfigController.popupCf.value.name = null;
                popupConfigController.popupCf.value.valueAction = null;
                popupConfigController.popupCf.value.typeAction = null;
                popupConfigController.textEditingController.text = "";
                popupConfigController.popupCf.refresh();
              },
              child: Stack(
                children: [
                  Container(
                    height: 50,
                    width: 100,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(Get.context!).primaryColor)),
                    child: Center(
                      child: Text(
                        "Website",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  if (inputCode[0] == popupConfigController.codeCurrent.value)
                    Positioned(
                      height: 25,
                      width: 25,
                      top: 10,
                      right: 10,
                      child: SvgPicture.asset(
                        "assets/icons/levels.svg",
                        color: Colors.green,
                      ),
                    ),
                  if (inputCode[0] == popupConfigController.codeCurrent.value)
                    Positioned(
                      height: 15,
                      width: 15,
                      top: 10,
                      right: 10,
                      child: Icon(
                        Icons.check,
                        size: 14,
                        color: Theme.of(Get.context!)
                            .primaryTextTheme
                            .headline6!
                            .color,
                      ),
                    ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                popupConfigController.codeCurrent.value = "PRODUCT";
                popupConfigController.popupCf.value.name = null;
                popupConfigController.popupCf.refresh();
              },
              child: Stack(
                children: [
                  Container(
                    height: 50,
                    width: 100,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(Get.context!).primaryColor)),
                    child: Center(
                      child: Text(
                        "Sản phẩm",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  if (inputCode[1] == popupConfigController.codeCurrent.value)
                    Positioned(
                      height: 25,
                      width: 25,
                      top: 10,
                      right: 10,
                      child: SvgPicture.asset(
                        "assets/icons/levels.svg",
                        color: Colors.green,
                      ),
                    ),
                  if (inputCode[1] == popupConfigController.codeCurrent.value)
                    Positioned(
                      height: 15,
                      width: 15,
                      top: 10,
                      right: 10,
                      child: Icon(
                        Icons.check,
                        size: 15,
                        color: Theme.of(Get.context!)
                            .primaryTextTheme
                            .headline6!
                            .color,
                      ),
                    ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                popupConfigController.codeCurrent.value = "CATEGORY_PRODUCT";
                popupConfigController.popupCf.value.name = null;
                popupConfigController.popupCf.refresh();
              },
              child: Stack(
                children: [
                  Container(
                    height: 50,
                    width: 100,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(Get.context!).primaryColor)),
                    child: Center(
                      child: Text(
                        "Danh mục sản phẩm",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  if (inputCode[2] == popupConfigController.codeCurrent.value)
                    Positioned(
                      height: 25,
                      width: 25,
                      top: 10,
                      right: 10,
                      child: SvgPicture.asset(
                        "assets/icons/levels.svg",
                        color: Colors.green,
                      ),
                    ),
                  if (inputCode[2] == popupConfigController.codeCurrent.value)
                    Positioned(
                      height: 15,
                      width: 15,
                      top: 10,
                      right: 10,
                      child: Icon(
                        Icons.check,
                        size: 15,
                        color: Theme.of(Get.context!)
                            .primaryTextTheme
                            .headline6!
                            .color,
                      ),
                    ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                popupConfigController.codeCurrent.value = "POST";
                popupConfigController.popupCf.value.name = null;
                popupConfigController.popupCf.refresh();
              },
              child: Stack(
                children: [
                  Container(
                    height: 50,
                    width: 100,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(Get.context!).primaryColor)),
                    child: Center(
                      child: Text(
                        "Bài viết",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  if (inputCode[3] == popupConfigController.codeCurrent.value)
                    Positioned(
                      height: 25,
                      width: 25,
                      top: 10,
                      right: 10,
                      child: SvgPicture.asset(
                        "assets/icons/levels.svg",
                        color: Colors.green,
                      ),
                    ),
                  if (inputCode[3] == popupConfigController.codeCurrent.value)
                    Positioned(
                      height: 15,
                      width: 15,
                      top: 10,
                      right: 10,
                      child: Icon(
                        Icons.check,
                        size: 15,
                        color: Theme.of(Get.context!)
                            .primaryTextTheme
                            .headline6!
                            .color,
                      ),
                    ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                popupConfigController.codeCurrent.value = "CATEGORY_POST";
                popupConfigController.popupCf.value.name = null;
                popupConfigController.popupCf.refresh();
              },
              child: Stack(
                children: [
                  Container(
                    height: 50,
                    width: 100,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(Get.context!).primaryColor)),
                    child: Center(
                      child: Text(
                        "Danh mục bài viết",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  if (inputCode[4] == popupConfigController.codeCurrent.value)
                    Positioned(
                      height: 25,
                      width: 25,
                      top: 10,
                      right: 10,
                      child: SvgPicture.asset(
                        "assets/icons/levels.svg",
                        color: Colors.green,
                      ),
                    ),
                  if (inputCode[4] == popupConfigController.codeCurrent.value)
                    Positioned(
                      height: 15,
                      width: 15,
                      top: 10,
                      right: 10,
                      child: Icon(
                        Icons.check,
                        size: 15,
                        color: Theme.of(Get.context!)
                            .primaryTextTheme
                            .headline6!
                            .color,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
