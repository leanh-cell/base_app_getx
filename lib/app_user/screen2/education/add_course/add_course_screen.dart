import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/divide/divide.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/text_field_no_border.dart';
import 'package:com.ikitech.store/app_user/model/course_list.dart';
import 'package:com.ikitech.store/app_user/screen2/education/add_course/add_course_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/saha_user/button/saha_button.dart';
import '../../../components/saha_user/loading/loading_widget.dart';
import '../../../components/saha_user/text_field/saha_text_filed_content.dart';

class AddCourse extends StatelessWidget {
  late AddCourseController addCourseController;
  CourseList? courseListInput;

  AddCourse({this.courseListInput}) {
    addCourseController = AddCourseController(courseListInput: courseListInput);
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            courseListInput != null ? 'Sửa khoá học' : "Thêm khoá học",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Container(
              child: Column(
                children: [
                  Obx(
                    () => InkWell(
                      onTap: () {
                        addCourseController.loadAssets();
                      },
                      child: ClipRRect(
                        child: addCourseController.isUpdatingImage.value == true
                            ? SahaLoadingWidget()
                            : Container(
                                margin: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        addCourseController.linkImage.value,
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
                                            Icon(
                                              Icons.camera_alt,
                                              color: Colors.grey,
                                              size: 50,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Thêm ảnh minh hoạ khoá học",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey,
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SahaTextFieldNoBorder(
                      withAsterisk: true,
                      controller:
                          addCourseController.titleTextEditingController,
                      validator: (value) {
                        if (value!.length == 0) {
                          return 'Không được để trống';
                        }
                        return null;
                      },
                      labelText: "Tiêu đề",
                      hintText: "Nhập tiêu đề",
                    ),
                  ),
                  SahaDivide(),
                  Container(
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SahaTextFieldNoBorder(
                        maxLine: 3,
                        textInputType: TextInputType.multiline,
                        controller: addCourseController
                            .shortDescriptionTextEditingController,
                        validator: (value) {
                          if (value!.length == 0) {
                            return 'Không được để trống';
                          }
                          return null;
                        },
                        labelText: "Mô tả",
                        hintText: "Nhập Mô tả",
                      ),
                    ),
                  ),
                  SahaDivide(),
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
                text: "LƯU",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (courseListInput != null) {
                      addCourseController.updateCourse();
                    } else {
                      addCourseController.addCourse(
                          title: addCourseController
                              .titleTextEditingController.value.text,
                          shortDescription: addCourseController
                              .shortDescriptionTextEditingController.value.text,
                          description: addCourseController.description.value);
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
