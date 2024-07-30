import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/divide/divide.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/text_field_no_border.dart';
import 'package:com.ikitech.store/app_user/model/chapter.dart';
import 'package:com.ikitech.store/app_user/screen2/education/chapter_lesson/edit_chapter/edit_chapter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditChapterScreen extends StatelessWidget {
  late EditChapterController editChapterController;
  Chapter chapterInput;
  int courseId;

  EditChapterScreen({required this.chapterInput, required this.courseId}) {
    editChapterController =
        EditChapterController(chapterInput: chapterInput, courseId: courseId);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Sửa chương học",
            style: TextStyle(
              color: Colors.white,
            ),
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
                    controller: editChapterController.titleTextEditingController,
                    validator: (value) {
                      if (value!.length == 0) {
                        return 'Không được để trống';
                      }
                      return null;
                    },
                    labelText: "Tiêu đề",
                    hintText: "Nhập tiêu đề",
                    onChanged: (v) {
                      editChapterController.chapterRequest.value.title = v;
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
                    controller: editChapterController
                        .shortDescriptionTextEditingController,
                    validator: (value) {
                      if (value!.length == 0) {
                        return 'Không được để trống';
                      }
                      return null;
                    },
                    labelText: "Tóm tắt mô tả",
                    hintText: "Nhập tóm tắt mô tả",
                    onChanged: (v) {
                      editChapterController
                          .chapterRequest.value.shortDescription = v;
                    },
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
                text: "LƯU",
                onPressed: () {
                  editChapterController.updateChapter();
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
