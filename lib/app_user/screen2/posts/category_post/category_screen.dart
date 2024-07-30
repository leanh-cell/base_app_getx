import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty_widget/empty_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_customer/app_customer/model/category_post.dart';
import '../../../../saha_data_controller.dart';
import 'add_category/add_category_screen.dart';
import 'category_controller.dart';

// ignore: must_be_immutable
class CategoryPostScreen extends StatefulWidget {
  bool? isSelect;
  CategoryPost? categoryPostSelected;

  CategoryPostScreen(
      {Key? key, this.isSelect = false, this.categoryPostSelected})
      : super(key: key);

  @override
  _CategoryPostScreenState createState() => _CategoryPostScreenState();
}

class _CategoryPostScreenState extends State<CategoryPostScreen> {
  CategoryPostController categoryController = new CategoryPostController();
  SahaDataController sahaDataController = Get.find();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    categoryController.categoryPostSelected.value =
        widget.categoryPostSelected ?? CategoryPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        titleText: "Tất cả danh mục",
        actions: widget.isSelect != true
            ? null
            : [
                IconButton(
                    onPressed: () {
                      Get.back(
                          result:
                              categoryController.categoryPostSelected.value);
                    },
                    icon: Icon(Icons.check))
              ],
      ),
      body: Obx(
        () => categoryController.loading.value
            ? SahaLoadingFullScreen()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Obx(() {
                        var list = categoryController.listCategoryPost.toList();
                        if (list.length == 0) {
                          return SahaEmptyWidget(
                            tile: "Không có danh mục nào",
                          );
                        }
                        return ListView.separated(
                            separatorBuilder: (context, index) => Divider(),
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              var selected = categoryController.selected(
                                  categoryController.categoryPostSelected.value,
                                  index);

                              return ItemCategoryPostWidget(
                                category: list[index],
                                isSelect: widget.isSelect ?? false,
                                selected: selected,
                                categoryController: categoryController,
                                onTap: () {
                                  categoryController
                                      .selectCategoryPost(list[index]);
                                  setState(() {});
                                },
                              );
                            });
                      }),
                    ),
                    SahaButtonFullParent(
                      onPressed: () {
                        Get.to(AddCategoryPostScreen())!.then((value) {
                          if (value == "added") {
                            categoryController.getAllCategoryPost();
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

class ItemCategoryPostWidget extends StatelessWidget {
  final CategoryPost? category;
  final Function? onTap;
  final bool? selected;
  final bool isSelect;
  final CategoryPostController? categoryController;
  SahaDataController sahaDataController = Get.find();
  ItemCategoryPostWidget(
      {Key? key,
      this.category,
      this.onTap,
      this.selected,
      this.isSelect = false,
      this.categoryController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            onTap: () {
              if (isSelect) {
                onTap!();
                return;
              }
              Get.to(AddCategoryPostScreen(category: category))!.then((value) {
                if (value == "added") {
                  categoryController!.getAllCategoryPost();
                }
              });
            },
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                height: 60,
                width: 60,
                fit: BoxFit.cover,
                imageUrl: category?.imageUrl ?? "",
                placeholder: (context, url) => new SahaLoadingWidget(
                  size: 20,
                ),
                errorWidget: (context, url, error) => SahaEmptyImage(),
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(category?.title ?? ""),
                SizedBox(
                  height: 5,
                ),
                Text(
                  category?.description ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
            selected: selected!,
            trailing: !isSelect
                ? IconButton(
                    icon: Icon(Icons.delete_rounded),
                    onPressed: () {
                      SahaDialogApp.showDialogYesNo(
                          mess: "Bạn muốn xóa danh mục này?",
                          onOK: () {
                            categoryController!
                                .deleteCategoryPost(category!.id!);
                          });
                    })
                : Checkbox(
                    value: selected,
                    onChanged: (bool? value) {
                      onTap!();
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
