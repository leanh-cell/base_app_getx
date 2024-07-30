import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty_widget/empty_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/categories/add_category/add_category_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/posts/category_post/add_category/add_category_screen.dart';
import 'package:sahashop_customer/app_customer/model/category_post.dart';
import 'category_post_controller.dart';

class CategoryPostPickerScreen extends StatefulWidget {
  final bool isSelect;
  final List<CategoryPost>? listCategorySelected;

  const CategoryPostPickerScreen(
      {Key? key, this.isSelect = false, this.listCategorySelected = const []})
      : super(key: key);

  @override
  _CategoryPostPickerScreenState createState() =>
      _CategoryPostPickerScreenState();
}

class _CategoryPostPickerScreenState extends State<CategoryPostPickerScreen> {
  CategoryPickerController categoryPickerController =
      new CategoryPickerController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    categoryPickerController
        .listCategorySelected(widget.listCategorySelected!.toList());
  }

  Future<bool> _willPop() async {
    Get.back(result: categoryPickerController.listCategorySelected.toList());
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
              IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    _willPop();
                  })
            ],
          ),
          body: Obx(
            () => categoryPickerController.loading.value
                ? SahaLoadingFullScreen()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Obx(() {
                            var list = categoryPickerController
                                .listCategory.reversed
                                .toList();
                            if (list == null || list.length == 0) {
                              return SahaEmptyWidget(
                                tile: "Không có danh mục nào",
                              );
                            }

                            return ListView.builder(
                                itemCount: list.length,
                                itemBuilder: (context, index) {
                                  var selected = categoryPickerController
                                      .selected(list[index]);

                                  return ItemCategoryWidget(
                                    category: list[index],
                                    selected: selected,
                                    isSelect: widget.isSelect,
                                    categoryPickerController:
                                        categoryPickerController,
                                    onTap: () {
                                      categoryPickerController
                                          .selectCategory(list[index]);
                                      setState(() {});
                                    },
                                  );
                                });
                          }),
                        ),
                        SahaButtonFullParent(
                          onPressed: () {
                            Get.to(() => AddCategoryScreen())!.then((value) {
                              if (value == "added") {
                                categoryPickerController.getAllCategory();
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
          )),
    );
  }
}

class ItemCategoryWidget extends StatelessWidget {
  final CategoryPost? category;
  final Function? onTap;
  final bool? selected;
  final bool? isSelect;
  final CategoryPickerController? categoryPickerController;

  const ItemCategoryWidget(
      {Key? key,
      this.category,
      this.onTap,
      this.selected,
      this.isSelect = false,
      this.categoryPickerController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
          onTap: () {
            if (isSelect!) {
              onTap!();
              return;
            }

            Get.to(() => AddCategoryPostScreen(
                      category: category,
                    ))!
                .then((value) {
              if (value == "added") {
                categoryPickerController!.getAllCategory();
              }
            });
          },
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedNetworkImage(
              height: 50,
              width: 50,
              fit: BoxFit.cover,
              imageUrl: category!.imageUrl ?? "",
              placeholder: (context, url) => new SahaLoadingWidget(
                size: 20,
              ),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
          ),
          title: Text(category!.title!),
          selected: selected!,
          trailing: Checkbox(
            value: selected,
            onChanged: (bool? value) {
              onTap!();
            },
          ),
        ),
      ),
    );
  }
}
