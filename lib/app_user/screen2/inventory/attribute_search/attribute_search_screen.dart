import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty/saha_empty_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty_widget/empty_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/screen2/home/home_controller.dart';
import 'package:sahashop_customer/app_customer/model/attribute_search.dart';

import '../../../../saha_data_controller.dart';
import 'add_attribute_search/add_attribute_search_screen.dart';
import 'add_child_attribute_search/add_child_attribute_search_screen.dart';
import 'attribute_search_controller.dart';

class AttributeSearchScreen extends StatefulWidget {
  final bool isSelect;
  final List<AttributeSearch>? listAttributeSearchSelected;
  final List<AttributeSearch>? listAttributeSearchSelectedChild;

  const AttributeSearchScreen(
      {Key? key,
      this.isSelect = false,
      this.listAttributeSearchSelected = const [],
      this.listAttributeSearchSelectedChild = const []})
      : super(key: key);

  @override
  _AttributeSearchScreenState createState() => _AttributeSearchScreenState();
}

class _AttributeSearchScreenState extends State<AttributeSearchScreen> {
  AttributeSearchController attributeSearchController =
      new AttributeSearchController();
  SahaDataController sahaDataController = Get.find();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    attributeSearchController = new AttributeSearchController(
        listAttributeSearchSelectedChildInput:
            widget.listAttributeSearchSelectedChild);
  }

  Future<bool> _willPop() async {
    Get.back(result: {
      "list_attribute_search":
          attributeSearchController.listAttributeSearchSelected.toList(),
      "list_attribute_search_child":
          attributeSearchController.listAttributeSearchSelectedChild.toList()
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPop,
      child: Scaffold(
        appBar: SahaAppBar(
          titleText: "Thuộc tính tìm kiếm",
          actions: [
            widget.isSelect
                ? IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {
                      _willPop();
                    })
                : Container()
          ],
        ),
        body: Obx(
          () => attributeSearchController.loading.value
              ? SahaLoadingWidget()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Obx(() {
                          var list = attributeSearchController
                              .listAttributeSearch
                              .toList();
                          if (list.length == 0) {
                            return SahaEmptyWidget(
                              tile: "Không có danh mục nào",
                            );
                          }

                          return ReorderableListView(
                              onReorder: (int oldIndex, int newIndex) {
                                attributeSearchController.sortAttributeSearch(
                                    oldIndex, newIndex);
                              },
                              children: list.map((e) {
                                var selected =
                                    attributeSearchController.selected(e);
                                return ItemAttributeSearchWidget(
                                  key: ValueKey(e),
                                  attributeSearch: e,
                                  isSelect: widget.isSelect,
                                  attributeSearchController:
                                      attributeSearchController,
                                  onTap: () {
                                    attributeSearchController
                                        .selectAttributeSearch(e);
                                    if (selected == true) {
                                      if (e.productAttributeSearchChildren !=
                                          null) {
                                        e.productAttributeSearchChildren!
                                            .forEach((e) {
                                          attributeSearchController
                                              .listAttributeSearchSelectedChild
                                              .removeWhere((element) =>
                                                  element.id == e.id);
                                        });
                                      }
                                    }
                                    setState(() {});
                                  },
                                  onTapChild: (AttributeSearch v) {
                                    if (selected == false) {
                                      attributeSearchController
                                          .selectAttributeSearch(e);
                                    }
                                    attributeSearchController
                                        .selectAttributeSearchChild(v);
                                    setState(() {});
                                  },
                                );
                              }).toList());
                        }),
                      ),
                      SahaButtonFullParent(
                        onPressed: () {
                          Get.to(AddAttributeSearchScreen())!
                              .then((value) async {
                            if (value == "added") {
                              if (sahaDataController.badgeUser.value
                                      .decentralization?.productAttributeAdd !=
                                  true) {
                                SahaAlert.showError(
                                    message: "Bạn chưa được phân quyền");
                                return;
                              }
                              attributeSearchController.getAttributeSearch();
                              // HomeController homeController = Get.find();
                              // await homeController.getAttributeSearch();
                              // homeController.isSearch.refresh();
                              // homeController.AttributeSearchChoose = null;
                            }
                          });
                        },
                        text: "Thêm danh thuộc tính",
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class ItemAttributeSearchWidget extends StatelessWidget {
  AttributeSearch? attributeSearch;
  final Function? onTap;
  final Function? onTapChild;
  final bool? selected;
  final bool? isSelect;
  final AttributeSearchController? attributeSearchController;

  ItemAttributeSearchWidget(
      {Key? key,
      this.attributeSearch,
      this.onTap,
      this.onTapChild,
      this.selected,
      this.isSelect = false,
      this.attributeSearchController})
      : super(key: key);

  SahaDataController sahaDataController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
              onTap: () {
                if (isSelect!) {
                  onTap!();
                  return;
                }
                Get.to(() => AddAttributeSearchScreen(
                          attributeSearch: attributeSearch,
                        ))!
                    .then((value) {
                  if (value == "added") {
                    attributeSearchController!.getAttributeSearch();
                  }
                });
              },
              leading: Icon(
                Icons.list,
                color: Colors.black,
              ),
              title: Text(attributeSearch!.name!),
              //selected: selected!,
              trailing: IconButton(
                  icon: Icon(Icons.delete_rounded),
                  onPressed: () {
                    SahaDialogApp.showDialogYesNo(
                        mess: "Bạn muốn xóa thuộc tính tìm kiếm này?",
                        onOK: () async {
                          if (sahaDataController.badgeUser.value
                                  .decentralization?.productAttributeRemove !=
                              true) {
                            SahaAlert.showError(
                                message: "Bạn chưa được phân quyền");
                            return;
                          }
                          await attributeSearchController!
                              .deleteAttributeSearch(attributeSearch!.id!);
                          // HomeController homeController = Get.find();
                          // await homeController.getAllAttributeSearch();
                          // homeController.isSearch.refresh();
                          // homeController.AttributeSearchChoose = null;
                        });
                  })),
          Divider(
            height: 1,
          ),
          if (attributeSearch?.productAttributeSearchChildren == null ||
              attributeSearch!.productAttributeSearchChildren!.isEmpty)
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  SizedBox(
                    width: Get.width - 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Thuộc tính con: ${attributeSearch!.productAttributeSearchChildren!.map((e) => e.name).toList().toString().replaceAll("[", "").replaceAll("]", "")}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            IconButton(
                                onPressed: () {
                                  Get.to(() => AddAttributeChildScreen(
                                            attributeSearch: attributeSearch!,
                                          ))!
                                      .then((value) => {
                                            attributeSearchController!
                                                .getAttributeSearch(),
                                          });
                                },
                                icon: Icon(Icons.add))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          if (attributeSearch?.productAttributeSearchChildren != null &&
              attributeSearch!.productAttributeSearchChildren!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Expandable(
                  showArrowWidget: true,
                  backgroundColor: Colors.white,
                  initiallyExpanded: false,
                  firstChild: SizedBox(
                    height: 48,
                    width: Get.width - 70,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  "Thuộc tính con: ",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                Expanded(
                                  child: Text(
                                    "${attributeSearch!.productAttributeSearchChildren!.map((e) => e.name).toList().toString().replaceAll("[", "").replaceAll("]", "")}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isSelect != true)
                            IconButton(
                                onPressed: () {
                                  if (sahaDataController
                                          .badgeUser
                                          .value
                                          .decentralization
                                          ?.productAttributeUpdate !=
                                      true) {
                                    SahaAlert.showError(
                                        message: "Bạn chưa được phân quyền");
                                    return;
                                  }
                                  Get.to(() => AddAttributeChildScreen(
                                            attributeSearch: attributeSearch!,
                                          ))!
                                      .then((value) => {
                                            attributeSearchController!
                                                .getAttributeSearch(),
                                          });
                                },
                                icon: Icon(Icons.add))
                        ],
                      ),
                    ),
                  ),
                  secondChild: Column(
                    children: attributeSearch!.productAttributeSearchChildren!
                        .map((e) => itemChild(e))
                        .toList(),
                  )),
            ),
        ],
      ),
    );
  }

  Widget itemChild(AttributeSearch attributeSearchChild) {
    var selectedChild =
        attributeSearchController!.selectedChild(attributeSearchChild);
    return InkWell(
      onTap: () {
        if (isSelect == true) {
          onTapChild!(attributeSearchChild);
        } else {
          Get.to(() => AddAttributeChildScreen(
                    attributeSearch: attributeSearch!,
                    attributeSearchChild: attributeSearchChild,
                  ))!
              .then((value) => {
                    attributeSearchController!.getAttributeSearch(),
                  });
        }
      },
      child: Column(
        children: [
          Divider(),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                    imageUrl: attributeSearchChild.imageUrl ?? "",
                    placeholder: (context, url) => new SahaLoadingWidget(
                      size: 30,
                    ),
                    errorWidget: (context, url, error) => new SahaEmptyImage(),
                  ),
                ),
                Spacer(),
                Text(attributeSearchChild.name ?? ""),
                SizedBox(
                  width: 10,
                ),
                !isSelect!
                    ? InkWell(
                        onTap: () {
                              if (sahaDataController
                                          .badgeUser
                                          .value
                                          .decentralization
                                          ?.productAttributeUpdate !=
                                      true) {
                                    SahaAlert.showError(
                                        message: "Bạn chưa được phân quyền");
                                    return;
                                  }
                          SahaDialogApp.showDialogYesNo(
                              mess: "Bạn muốn xóa thuộc tính tìm kiếm này?",
                              onOK: () async {
                                await attributeSearchController!
                                    .deleteAttributeSearchChild(
                                        attributeSearch!.id!,
                                        attributeSearchChild.id!);
                                attributeSearchController!.getAttributeSearch();
                              });
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      )
                    : Checkbox(
                        value: selectedChild,
                        onChanged: (bool? value) {
                          onTapChild!(attributeSearchChild);
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
