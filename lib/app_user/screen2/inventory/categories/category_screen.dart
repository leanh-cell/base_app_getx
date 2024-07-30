import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty/saha_empty_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty_widget/empty_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/screen2/home/home_controller.dart';
import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';

import '../../../../saha_data_controller.dart';
import 'add_category/add_category_screen.dart';
import 'add_child_category/add_child_category_screen.dart';
import 'category_controller.dart';

class CategoryScreen extends StatefulWidget {
  final bool isSelect;
  final List<Category>? listCategorySelected;
  final List<Category>? listCategorySelectedChild;

  const CategoryScreen(
      {Key? key,
      this.isSelect = false,
      this.listCategorySelected = const [],
      this.listCategorySelectedChild = const []})
      : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CategoryController categoryController = new CategoryController();
  SahaDataController sahaDataController = Get.find();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    categoryController
        .listCategorySelected(widget.listCategorySelected!.toList());
    categoryController
        .listCategorySelectedChild(widget.listCategorySelectedChild!.toList());
  }

  Future<bool> _willPop() async {
    Get.back(result: {
      "list_cate": categoryController.listCategorySelected.toList(),
      "list_cate_child": categoryController.listCategorySelectedChild.toList()
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPop,
      child: Scaffold(
        appBar: SahaAppBar(
          titleText: "Tất cả danh mục",
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  var list = categoryController.listCategory.toList();
                  if (list.length == 0) {
                    return SahaEmptyWidget(
                      tile: "Không có danh mục nào",
                    );
                  }

                  return ReorderableListView(
                      onReorder: (int oldIndex, int newIndex) {
                        categoryController.sortCategories(oldIndex, newIndex);
                      },
                      children: list.map((e) {
                        var selected = categoryController.selected(e);
                        return ItemCategoryWidget(
                          key: ValueKey(e),
                          category: e,
                          selected: selected,
                          isSelect: widget.isSelect,
                          categoryController: categoryController,
                          onTap: () {
                            categoryController.selectCategory(e);
                            if (selected == true) {
                              if (e.listCategoryChild != null) {
                                e.listCategoryChild!.forEach((e) {
                                  categoryController.listCategorySelectedChild
                                      .removeWhere(
                                          (element) => element.id == e.id);
                                });
                              }
                            }
                            setState(() {});
                          },
                          onTapChild: (Category v) {
                            if (selected == false) {
                              categoryController.selectCategory(e);
                            }
                            categoryController.selectCategoryChild(v);
                            setState(() {});
                          },
                        );
                      }).toList());
                }),
              ),
              SahaButtonFullParent(
                onPressed: () {
                  if (sahaDataController.badgeUser.value.decentralization
                          ?.productCategoryAdd !=
                      true) {
                    SahaAlert.showError(
                        message: "Bạn không có quyền thêm danh mục");
                    return;
                  }
                  Get.to(AddCategoryScreen())!.then((value) async {
                    if (value == "added") {
                      categoryController.getAllCategory();
                      HomeController homeController = Get.find();
                      await homeController.getAllCategory();
                      homeController.isSearch.refresh();
                      homeController.categoryChoose = null;
                    }
                  });
                },
                text: "Thêm danh mục mới",
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ItemCategoryWidget extends StatelessWidget {
  final Category? category;
  final Function? onTap;
  final Function? onTapChild;
  final bool? selected;
  final bool? isSelect;
  final CategoryController? categoryController;

  ItemCategoryWidget(
      {Key? key,
      this.category,
      this.onTap,
      this.onTapChild,
      this.selected,
      this.isSelect = false,
      this.categoryController})
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
              Get.to(() => AddCategoryScreen(
                        category: category,
                      ))!
                  .then((value) {
                if (value == "added") {
                  categoryController!.getAllCategory();
                }
              });
            },
            leading: Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Row(
                children: [
                  Icon(
                    Icons.list,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                      imageUrl: category!.imageUrl ?? "",
                      placeholder: (context, url) => new SahaLoadingWidget(
                        size: 20,
                      ),
                      errorWidget: (context, url, error) =>
                          new SahaEmptyImage(),
                    ),
                  ),
                ],
              ),
            ),
            title: Text(category!.name!),
            subtitle: Text("${category!.totalProducts ?? 0} sản phẩm"),
            selected: selected!,
            trailing: !isSelect!
                ? IconButton(
                    icon: Icon(Icons.delete_rounded),
                    onPressed: () {
                      if (sahaDataController.badgeUser.value.decentralization
                              ?.productCategoryRemove !=
                          true) {
                        SahaAlert.showError(
                            message: "Bạn không có quyền xoá danh mục");
                        return;
                      }
                      SahaDialogApp.showDialogYesNo(
                          mess: category!.totalProducts!.bitLength > 0
                              ? "Xóa danh mục sản phẩm sẽ mất đi danh mục này?"
                              : "Bạn muốn xóa danh mục này?",
                          onOK: () async {
                            await categoryController!
                                .deleteCategory(category!.id!);
                            HomeController homeController = Get.find();
                            await homeController.getAllCategory();
                            homeController.isSearch.refresh();
                            homeController.categoryChoose = null;
                          });
                    })
                : Checkbox(
                    value: selected,
                    onChanged: (bool? value) {
                      onTap!();
                    },
                  ),
          ),
          Divider(
            height: 1,
          ),
          if (category?.listCategoryChild == null ||
              category!.listCategoryChild!.isEmpty)
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
                              "Danh mục con: ${category!.listCategoryChild!.map((e) => e.name).toList().toString().replaceAll("[", "").replaceAll("]", "")}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (isSelect != true)
                              IconButton(
                                  onPressed: () {
                                    Get.to(() => AddCategoryChildScreen(
                                              category: category!,
                                            ))!
                                        .then((value) => {
                                              categoryController!
                                                  .getAllCategory(),
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
          if (category?.listCategoryChild != null &&
              category!.listCategoryChild!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Expandable(
                  showArrowWidget: true,
                  backgroundColor: Colors.white,
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
                                  "Danh mục con: ",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                Expanded(
                                  child: Text(
                                    "${category!.listCategoryChild!.map((e) => e.name).toList().toString().replaceAll("[", "").replaceAll("]", "")}",
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
                                  Get.to(() => AddCategoryChildScreen(
                                            category: category!,
                                          ))!
                                      .then((value) => {
                                            categoryController!
                                                .getAllCategory(),
                                          });
                                },
                                icon: Icon(Icons.add))
                        ],
                      ),
                    ),
                  ),
                  secondChild: Column(
                    children: category!.listCategoryChild!
                        .map((e) => itemChild(e))
                        .toList(),
                  )),
            ),
        ],
      ),
    );
  }

  Widget itemChild(Category categoryChild) {
    var selectedChild = categoryController!.selectedChild(categoryChild);
    return InkWell(
      onTap: () {
        if (isSelect == true) {
          onTapChild!(categoryChild);
        } else {
          Get.to(() => AddCategoryChildScreen(
                    category: category!,
                    categoryChild: categoryChild,
                  ))!
              .then((value) => {
                    categoryController!.getAllCategory(),
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
                    imageUrl: categoryChild.imageUrl ?? "",
                    placeholder: (context, url) => new SahaLoadingWidget(
                      size: 30,
                    ),
                    errorWidget: (context, url, error) => new SahaEmptyImage(),
                  ),
                ),
                Expanded(child: Text(categoryChild.name ?? "")),
                SizedBox(
                  width: 10,
                ),
                !isSelect!
                    ? InkWell(
                        onTap: () {
                          SahaDialogApp.showDialogYesNo(
                              mess: category!.totalProducts!.bitLength > 0
                                  ? "Xóa danh mục sản phẩm sẽ mất đi danh mục này?"
                                  : "Bạn muốn xóa danh mục này?",
                              onOK: () async {
                                await categoryController!.deleteCategoryChild(
                                    category!.id!, categoryChild.id!);
                                categoryController!.getAllCategory();
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
                          onTapChild!(categoryChild);
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
