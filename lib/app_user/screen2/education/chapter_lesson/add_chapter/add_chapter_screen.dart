import 'package:com.ikitech.store/app_user/components/saha_user/divide/divide.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/text_field_no_border.dart';
import 'package:com.ikitech.store/app_user/model/chapter.dart';
import 'package:com.ikitech.store/app_user/screen2/education/chapter_lesson/add_chapter/add_chapter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/saha_user/button/saha_button.dart';

class AddChapterScreen extends StatelessWidget {
  late AddChapterController addChapterController;
  Chapter? chapterInput;
  int? courseId;

  AddChapterScreen({this.chapterInput, this.courseId}) {
    addChapterController = AddChapterController(ChapterInput: chapterInput);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Thêm chương học",
          ),
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SahaTextFieldNoBorder(
                    withAsterisk: true,
                    controller: addChapterController.titleTextEditingController,
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
                    withAsterisk: true,
                    controller: addChapterController
                        .shortDescriptionTextEditingController,
                    validator: (value) {
                      if (value!.length == 0) {
                        return 'Không được để trống';
                      }
                      return null;
                    },
                    labelText: "Tóm tắt mô tả",
                    hintText: "Nhập tóm tắt mô tả",
                  ),
                ),
                SahaDivide(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 65,
          color: Colors.white,
          child: Column(
            children: [
              SahaButtonFullParent(
                text: "Thêm chương học",
                onPressed: () {
                  addChapterController.addChapter(
                      title: addChapterController.titleTextEditingController.value.text,
                      shortDescription: addChapterController
                          .shortDescriptionTextEditingController.value.text,
                      trainCourseId: courseId!);
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
