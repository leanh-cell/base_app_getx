import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/divide/divide.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/text_field_no_border.dart';
import 'package:com.ikitech.store/app_user/model/lesson.dart';
import 'package:com.ikitech.store/app_user/screen2/education/chapter_lesson/lesson/add_lesson/add_lesson_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../components/saha_user/text_field/saha_text_filed_content.dart';

class AddLessonScreen extends StatelessWidget {
  late AddLessonController addLessonController;
  Lesson? lessonInput;
  int? chapterId;

  AddLessonScreen({this.lessonInput, this.chapterId}) {
    addLessonController = AddLessonController();
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
            "Thêm bài học",
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
                          addLessonController.titleTextEditingController,
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SahaTextFieldNoBorder(
                      textInputType: TextInputType.multiline,
                      maxLine: 3,
                      withAsterisk: false,
                      controller: addLessonController
                          .shortDescriptionTextEditingController,
                      labelText: "Mô tả",
                      hintText: "Nhập mô tả",
                    ),
                  ),
                  SahaDivide(),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SahaTextFiledContent(
                        title: 'Nội dung',
                        onChangeContent: (html) {
                          addLessonController.description.value = html;

                          addLessonController.description.refresh();
                        },
                        contentSaved: addLessonController.description.value,
                      ),
                    ),
                  ),
                  SahaDivide(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SahaTextFieldNoBorder(
                      withAsterisk: false,
                      controller: addLessonController
                          .linkVideoYoutubeTextEditingController,
                      labelText: "Link video bài học",
                      hintText: "Nhập link video bài học",
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
                text: "Thêm",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    addLessonController.addLesson(
                      title: addLessonController
                          .titleTextEditingController.value.text,
                      shortDescription: addLessonController
                          .shortDescriptionTextEditingController.value.text,
                      linkVideoYoutube: addLessonController
                          .linkVideoYoutubeTextEditingController.text,
                      trainChapterId: chapterId!,
                    );
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
