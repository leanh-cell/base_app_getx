import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/saha_text_filed_content.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/sahashopTextField.dart';
import 'package:com.ikitech.store/app_user/screen2/posts/category_post/category_screen.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_customer/app_customer/model/category_post.dart';
import 'package:sahashop_customer/app_customer/model/post.dart';
import '../../../../../saha_data_controller.dart';
import 'add_post_controller.dart';
import 'widget/select_image.dart';

// ignore: must_be_immutable
class AddPostScreen extends StatefulWidget {
  final Post? post;

  AddPostScreen({Key? key, this.post}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final AddPostController addPostController = new AddPostController();
  SahaDataController sahaDataController = Get.find();
  final _formKey = GlobalKey<FormState>();

  File? imageSelected;

  @override
  void initState() {
    if (widget.post != null) {
      addPostController.postInput = widget.post;
      addPostController.getOnePost();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        titleText: widget.post != null ? "Cập nhật" : "Thêm mới bài viết",
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      children: [
                        SahaTextField(
                          controller:
                              addPostController.textEditingControllerTitle,
                          onChanged: (value) {
                            addPostController.title = value;
                          },
                          validator: (value) {
                            if (value!.length == 0) {
                              return 'Không được để trống';
                            }
                            return null;
                          },
                          labelText: "Tên bài viết",
                          hintText: "Nhập tên bài viết",
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            children: [
                              SelectPostImage(
                                linkImage: widget.post == null
                                    ? ""
                                    : widget.post!.imageUrl == null
                                        ? ""
                                        : widget.post!.imageUrl!,
                                onChange: (image) {
                                  addPostController.image = image;
                                  imageSelected = image;
                                },
                                fileSelected: imageSelected,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Ảnh đại diện cho bài viết"),
                                    Text(
                                      "Có thể không chọn",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontStyle: FontStyle.italic),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SahaTextField(
                          controller: addPostController
                              .textEditingControllerDescription,
                          textInputType: TextInputType.multiline,
                          onChanged: (value) {
                            addPostController.summary = value;
                          },
                          labelText: "Mô tả",
                          hintText: "Nhập mô tả cho danh mục",
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => CategoryPostScreen(
                                      isSelect: true,
                                      categoryPostSelected: addPostController
                                          .categoryPostSelected.value,
                                    ))!
                                .then((value) => {
                                      addPostController
                                          .setNewCategoryPostSelected(value)
                                    });
                          },
                          child: Column(
                            children: [
                              Container(
                                  padding: EdgeInsets.all(16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.wysiwyg_outlined),
                                      Text(
                                        " Danh mục bài viết",
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 16),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 4),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 15,
                                          color: Colors.grey,
                                        ),
                                      )
                                    ],
                                  )),
                              buildListCategory()
                            ],
                          ),
                        ),
                        Container(
                          height: 8,
                          color: Colors.grey[200],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Obx(() {
                            print(addPostController.content.value);
                            return Container(
                              child: SahaTextFiledContent(
                                onChangeContent: (html) {
                                  addPostController.content.value = html;
                                },
                                contentSaved: addPostController.content.value,
                              ),
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: SahaButtonFullParent(
                        text: "Lưu tạm",
                        color: Colors.white,
                        textColor: Colors.black,
                        colorBorder: Colors.grey,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (widget.post != null) {
                              addPostController.published = false;
                              addPostController.updatePost(widget.post!.id);
                            } else {
                              addPostController.published = false;
                              addPostController.createPost();
                            }
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: SahaButtonFullParent(
                        text: widget.post != null ? "Cập nhật" : "Hiển thị",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (widget.post != null) {
                              addPostController.published = true;
                              addPostController.updatePost(widget.post!.id);
                            } else {
                              addPostController.published = true;
                              addPostController.createPost();
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Obx(() {
            return addPostController.isLoadingAdd.value
                ? SahaLoadingFullScreen()
                : Container();
          })
        ],
      ),
    );
  }

  Widget buildListCategory() {
    return Obx(() => addPostController.categoryPostSelected.value.id == null
        ? Container()
        : Card(
            child: Column(
              children: [
                Container(
                  height: 1,
                  color: Colors.grey[100],
                ),
                Container(
                  height: 50,
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        fit: BoxFit.cover,
                        height: 50,
                        width: 50,
                        imageUrl: addPostController
                                .categoryPostSelected.value.imageUrl ??
                            "",
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) => SahaEmptyImage(),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(addPostController.categoryPostSelected.value.title!),
                      Spacer(),
                      IconButton(
                          icon: Icon(
                            Icons.clear,
                            size: 12,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            addPostController.categoryPostSelected.value.id =
                                null;
                            addPostController.categoryPostSelected.refresh();
                          })
                    ],
                  ),
                ),
              ],
            ),
          ));
  }
}
