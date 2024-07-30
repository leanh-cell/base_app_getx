import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty_widget/empty_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import '../../../../saha_data_controller.dart';
import 'attributes_controller.dart';

class AttributeScreen extends StatelessWidget {
  AttributeController attributeController = new AttributeController();
  final Function(List<String>)? onData;

  TextEditingController textEditingController = new TextEditingController();
  SahaDataController sahaDataController = Get.find();
  AttributeScreen({Key? key, this.onData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (onData != null) {
          onData!(attributeController.listAttribute.toList());
        }

        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Thuộc tính gợi ý",
            ),
          ),
          body: Obx(
            () => attributeController.loading.value
                ? SahaLoadingFullScreen()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Obx(() {
                            var list = attributeController.listAttribute
                                .toList()
                                .toList();
                            if (list.length == 0) {
                              return SahaEmptyWidget(
                                tile: "Không có danh mục nào",
                              );
                            }

                            return ReorderableListView(
                              children: list
                                  .map(
                                    (e) => Card(
                                      key: ValueKey(e),
                                      elevation: 2,
                                      child: ListTile(
                                        title: Text(e),
                                        leading: Icon(
                                          Icons.list,
                                          color: Colors.black,
                                        ),
                                        trailing: IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.black54,
                                          ),
                                          onPressed: () {
                                            if (sahaDataController
                                                    .badgeUser
                                                    .value
                                                    .decentralization
                                                    ?.productAttributeRemove !=
                                                true) {
                                              SahaAlert.showError(
                                                  message:
                                                      "Bạn không có quyền truy cập");
                                              return;
                                            }
                                            attributeController
                                                .removeAttribute(e);
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onReorder: (id1, id2) {
                                print('$id1 $id2');
                              },
                            );
                          }),
                        ),
                        SahaButtonFullParent(
                          onPressed: () {
                            if (sahaDataController.badgeUser.value
                                    .decentralization?.productAttributeAdd !=
                                true) {
                              SahaAlert.showError(
                                  message: "Bạn không có quyền truy cập");
                              return;
                            }
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Tên thuộc tính'),
                                    content: TextField(
                                      onChanged: (value) {},
                                      controller: textEditingController,
                                      decoration: InputDecoration(
                                          hintText: "Nhập tên thuộc tính"),
                                    ),
                                    actions: <Widget>[
                                      new TextButton(
                                          child: const Text('Hủy'),
                                          onPressed: () {
                                            textEditingController.text = "";
                                            Navigator.pop(context);
                                          }),
                                      new TextButton(
                                          child: const Text('Thêm'),
                                          onPressed: () {
                                            if (textEditingController
                                                    .text.length ==
                                                0) {
                                              SahaAlert.showError(
                                                  message: "Không được trống");
                                              return;
                                            }

                                            if (attributeController
                                                .listAttribute
                                                .contains(textEditingController
                                                    .text)) {
                                              SahaAlert.showError(
                                                  message:
                                                      "Thuộc tính đã tồn tại");
                                            } else {
                                              attributeController.addAttribute(
                                                  textEditingController.text);

                                              Navigator.pop(context);
                                            }
                                            textEditingController.text = "";
                                          })
                                    ],
                                  );
                                });
                          },
                          text: "Thêm thuộc tính mới",
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
          )),
    );
  }
}

class ItemAttributeWidget extends StatelessWidget {
  final String? attribute;

  const ItemAttributeWidget({Key? key, this.attribute}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text(attribute!),
      ),
    );
  }
}
