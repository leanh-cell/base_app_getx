import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/divide/divide.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/text_field_no_border.dart';
import 'package:com.ikitech.store/app_user/model/lesson.dart';
import 'package:com.ikitech.store/app_user/screen2/education/chapter_lesson/lesson/edit_lesson/edit_lesson_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../components/saha_user/text_field/saha_text_filed_content.dart';

class EditLessonScreen extends StatelessWidget {
  late EditLessonController editLessonController;
  Lesson lessonInput;

  EditLessonScreen({required this.lessonInput}) {
    editLessonController = EditLessonController(lessonInput: lessonInput);
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
            "Sửa bài học",
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
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SahaTextFieldNoBorder(
                      withAsterisk: true,
                      controller:
                          editLessonController.titleTextEditingController,
                      validator: (value) {
                        if (value!.length == 0) {
                          return 'Không được để trống';
                        }
                        return null;
                      },
                      labelText: "Tiêu đề",
                      hintText: "Nhập tiêu đề",
                      onChanged: (v) {
                        editLessonController.lessonRequest.value.title = v;
                      },
                    ),
                  ),
                  SahaDivide(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SahaTextFieldNoBorder(
                      textInputType: TextInputType.multiline,
                      maxLine: 3,
                      withAsterisk: true,
                      controller: editLessonController
                          .shortDescriptionTextEditingController,
                      validator: (value) {
                        if (value!.length == 0) {
                          return 'Không được để trống';
                        }
                        return null;
                      },
                      labelText: "Mô tả",
                      hintText: "Nhập mô tả",
                      onChanged: (v) {
                        editLessonController
                            .lessonRequest.value.shortDescription = v;
                      },
                    ),
                  ),
                  SahaDivide(),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SahaTextFiledContent(
                        title: 'Nội dung',
                        onChangeContent: (html) {
                          editLessonController.description.value = html;

                          editLessonController.description.refresh();
                        },
                        contentSaved: editLessonController.description.value,
                      ),
                    ),
                  ),
                  SahaDivide(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SahaTextFieldNoBorder(
                      textInputType: TextInputType.multiline,
                      maxLine: 3,
                      withAsterisk: true,
                      controller: editLessonController
                          .linkVideoYoutubeTextEditingController,
                      validator: (value) {
                        if (value!.length == 0) {
                          return 'Không được để trống';
                        }
                        return null;
                      },
                      labelText: "Link bài học",
                      hintText: "Nhập Link bài học",
                      onChanged: (v) {
                        editLessonController
                            .lessonRequest.value.linkVideoYoutube = v;
                      },
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
          child: Column(
            children: [
              SahaButtonFullParent(
                text: "Sửa",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    editLessonController.updateLesson();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
