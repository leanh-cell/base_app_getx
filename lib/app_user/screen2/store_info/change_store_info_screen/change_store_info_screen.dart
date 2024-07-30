import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty/saha_empty_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_container.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'change_store_info_controller.dart';

// ignore: must_be_immutable
class ChangeStoreInfoScreen extends StatelessWidget {
  ChangeStoreInfoScreen() {
    changeStoreInfoController = ChangeStoreInfoController();
  }

  late ChangeStoreInfoController changeStoreInfoController;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text("Sửa thông tin"),
          actions: [
            GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  changeStoreInfoController.updateInfoStore();
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text(
                      "Lưu",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: DirectSelectContainer(
          child: SingleChildScrollView(
            child: Obx(
              () => Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        InkWell(
                          onTap: () {
                            changeStoreInfoController.loadAssets();
                          },
                          child: Container(
                            height: 200,
                            width: Get.width,
                            child: Opacity(
                              opacity: 0.8,
                              child: CachedNetworkImage(
                                height: 70,
                                width: 70,
                                imageUrl:
                                    changeStoreInfoController.logoUrl.value,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    SahaLoadingContainer(),
                                errorWidget: (context, url, error) =>
                                    SahaEmptyImage(),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 30,
                          child: InkWell(
                            onTap: () {
                              changeStoreInfoController.loadAssets();
                            },
                            child: changeStoreInfoController
                                        .isUpdatingImage.value ==
                                    true
                                ? SahaLoadingWidget()
                                : Container(
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Theme.of(Get.context!)
                                                .primaryColor)),
                                    padding: EdgeInsets.all(5),
                                    child: ClipRRect(
                                      child: CachedNetworkImage(
                                        imageUrl: changeStoreInfoController
                                            .logoUrl.value,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            SahaLoadingContainer(),
                                        errorWidget: (context, url, error) =>
                                            Icon(
                                          Icons.camera_alt,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      borderRadius: BorderRadius.circular(3000),
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Tên cửa hàng"),
                          Container(
                            width: Get.width * 0.55,
                            child: TextFormField(
                              controller: changeStoreInfoController
                                  .nameEditingController.value,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value!.length < 1) {
                                  return 'Chưa nhập tên cửa hàng';
                                }
                                return null;
                              },
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.end,
                              decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintText: "Nhập tên cửa hàng"),
                              minLines: 1,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Địa chỉ"),
                          Container(
                            width: Get.width * 0.55,
                            child: TextFormField(
                              controller: changeStoreInfoController
                                  .addressEditingController.value,
                              keyboardType: TextInputType.streetAddress,
                              validator: (value) {
                                if (value!.length < 1) {
                                  return 'Chưa nhập địa chỉ';
                                }
                                return null;
                              },
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.end,
                              decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintText: "Nhập địa chỉ"),
                              minLines: 1,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text("Nhóm ngành:"),
                    ),
                    Container(
                      height: 50,
                      width: Get.width,
                      child: Card(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                                child: Padding(
                                    child: Obx(
                                      () => DirectSelectList<String>(
                                          onUserTappedListener: () {
                                            _showScaffold();
                                          },
                                          values: changeStoreInfoController
                                                  .listDataType.isEmpty
                                              ? []
                                              : changeStoreInfoController
                                                  .listDataType[
                                                      changeStoreInfoController
                                                          .indexTypeOfStore
                                                          .value]
                                                  .childs!
                                                  .map((e) =>
                                                      e.name ?? "Lỗi ngành")
                                                  .toList(),
                                          defaultItemIndex:
                                              changeStoreInfoController
                                                  .indexChild.value,
                                          itemBuilder: (String value) =>
                                              getDropDownMenuItem(value),
                                          focusedItemDecoration:
                                              _getDslDecoration(),
                                          onItemSelectedListener:
                                              (item, index, context) {
                                            changeStoreInfoController
                                                    .idTypeChild.value =
                                                changeStoreInfoController
                                                    .listDataType[
                                                        changeStoreInfoController
                                                            .indexTypeOfStore
                                                            .value]
                                                    .childs![index]
                                                    .id!;
                                          }),
                                    ),
                                    padding: EdgeInsets.only(left: 22))),
                            Icon(
                              Icons.unfold_more,
                              color: Colors.blueAccent,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  DirectSelectItem<String> getDropDownMenuItem(String value) {
    return DirectSelectItem<String>(
        itemHeight: 56,
        value: value,
        itemBuilder: (context, value) {
          return Text(value);
        });
  }

  void _showScaffold() {
    SahaAlert.showError(message: 'Giữ và kéo thay vì chạm');
  }

  _getDslDecoration() {
    return BoxDecoration(
      border: BorderDirectional(
        bottom: BorderSide(width: 1, color: Colors.black12),
        top: BorderSide(width: 1, color: Colors.black12),
      ),
    );
  }
}
