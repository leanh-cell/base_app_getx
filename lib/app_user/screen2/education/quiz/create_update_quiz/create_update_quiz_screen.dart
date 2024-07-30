import 'package:com.ikitech.store/app_user/model/quiz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/saha_user/button/saha_button.dart';
import '../../../../components/saha_user/divide/divide.dart';
import '../../../../components/saha_user/text_field/text_field_no_border.dart';
import 'create_update_quiz_controller.dart';

class CreateUpdateQuizScreen extends StatelessWidget {
  int courseId;
  Quiz? quizInput;

  CreateUpdateQuizScreen({required this.courseId, this.quizInput}) {
    controller =
        CreateUpdateQuizController(courseId: courseId, quizInput: quizInput);
  }

  late CreateUpdateQuizController controller;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(quizInput != null ? 'Sửa bài thi' : 'Thêm bài thi'),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                SahaDivide(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SahaTextFieldNoBorder(
                    withAsterisk: true,
                    maxLine: 1,
                    textInputType: TextInputType.multiline,
                    controller: controller.titleEdit,
                    validator: (value) {
                      if (value!.length == 0) {
                        return 'Không được để trống';
                      }
                      return null;
                    },
                    labelText: "Tiêu đề bài thi",
                    hintText: "Nhập tiêu đề bài thi",
                    onChanged: (v) {
                      controller.quizReq.value.title = v;
                    },
                  ),
                ),
                SahaDivide(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SahaTextFieldNoBorder(
                    controller: controller.desEdit,
                    maxLine: 1,
                    textInputType: TextInputType.multiline,
                    labelText: "Mô tả bài thi",
                    hintText: "Nhập mô tả bài thi",
                    onChanged: (v) {
                      controller.quizReq.value.shortDescription = v;
                    },
                  ),
                ),
                SahaDivide(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SahaTextFieldNoBorder(
                    withAsterisk: true,
                    controller: controller.minuteEdit,
                    maxLine: 1,
                    textInputType: TextInputType.number,
                    validator: (value) {
                      if (value!.length == 0) {
                        return 'Không được để trống';
                      }
                      return null;
                    },
                    labelText: "Thời gian thi",
                    hintText: "Nhập thời gian thi (phút)",
                    onChanged: (v) {
                      controller.quizReq.value.minute = int.parse('$v');
                    },
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: 50,
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                        'Cho phép tự động đổi vị trí câu hỏi',
                        maxLines: 1,
                        style:
                            TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      )),
                      Obx(
                        () => CupertinoSwitch(
                          value:
                              controller.quizReq.value.autoChangeOrderQuestions ??
                                  false,
                          onChanged: (bool value) {
                            controller.quizReq.value.autoChangeOrderQuestions =
                                !(controller
                                        .quizReq.value.autoChangeOrderQuestions ??
                                    false);
                            controller.quizReq.refresh();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: 50,
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                        'Cho phép tự động đổi vị trí câu trả lời',
                        maxLines: 1,
                        style:
                            TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      )),
                      Obx(
                        () => CupertinoSwitch(
                          value: controller.quizReq.value.autoChangeOrderAnswer ??
                              false,
                          onChanged: (bool value) {
                            controller.quizReq.value.autoChangeOrderAnswer =
                                !(controller
                                        .quizReq.value.autoChangeOrderAnswer ??
                                    false);
                            controller.quizReq.refresh();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: 50,
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                        'Hiển thị',
                        maxLines: 1,
                        style:
                            TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      )),
                      Obx(
                        () => CupertinoSwitch(
                          value: controller.quizReq.value.show ?? false,
                          onChanged: (bool value) {
                            controller.quizReq.value.show =
                                !(controller.quizReq.value.show ?? false);
                            controller.quizReq.refresh();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
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
                text: "Lưu",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (quizInput != null) {
                      controller.updateQuiz();
                    } else {
                      controller.createQuiz();
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
