import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../components/saha_user/button/saha_button.dart';
import '../../../../../components/saha_user/divide/divide.dart';
import '../../../../../components/saha_user/loading/loading_widget.dart';
import '../../../../../components/saha_user/text_field/text_field_no_border.dart';
import '../../../../../model/question.dart';
import '../../../../../model/quiz.dart';
import 'create_update_question_controller.dart';

class CreateUpdateQuestionScreen extends StatelessWidget {
  Question? questionInput;
  Quiz quizInput;
  CreateUpdateQuestionScreen({this.questionInput, required this.quizInput}) {
    controller = CreateUpdateQuestionController(
        questionInput: questionInput, quizInput: quizInput);
  }
  late CreateUpdateQuestionController controller;
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
          title: Text(questionInput != null  ? "Sửa câu hỏi" :"Thêm câu hỏi"),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                Obx(
                  () => InkWell(
                    onTap: () {
                      controller.loadAssets();
                    },
                    child: ClipRRect(
                      child: controller.isUpdatingImage.value == true
                          ? SahaLoadingWidget()
                          : Container(
                              margin: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: CachedNetworkImage(
                                  imageUrl: controller
                                          .questionReq.value.questionImage ??
                                      "",
                                  fit: BoxFit.fitWidth,
                                  placeholder: (context, url) =>
                                      SahaLoadingWidget(),
                                  errorWidget: (context, url, error) => Padding(
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
                                            "Thêm ảnh minh hoạ cho bài thi",
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
                    controller: controller.questionEdit,
                    maxLine: 3,
                    textInputType: TextInputType.multiline,
                    validator: (value) {
                      if (value!.length == 0) {
                        return 'Không được để trống';
                      }
                      return null;
                    },
                    labelText: "Câu hỏi",
                    hintText: "Nhập câu hỏi",
                    onChanged: (v) {
                      controller.questionReq.value.question = v;
                    },
                  ),
                ),
                SahaDivide(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SahaTextFieldNoBorder(
                    withAsterisk: true,
                    maxLine: 1,
                    textInputType: TextInputType.multiline,
                    controller: controller.questionAEdit,
                    validator: (value) {
                      if (value!.length == 0) {
                        return 'Không được để trống';
                      }
                      return null;
                    },
                    labelText: "Đáp án A",
                    hintText: "Nhập Đáp án A",
                    onChanged: (v) {
                      controller.questionReq.value.answerA = v;
                    },
                  ),
                ),
                SahaDivide(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SahaTextFieldNoBorder(
                    withAsterisk: true,
                    controller: controller.questionBEdit,
                    maxLine: 1,
                    textInputType: TextInputType.multiline,
                    validator: (value) {
                      if (value!.length == 0) {
                        return 'Không được để trống';
                      }
                      return null;
                    },
                    labelText: "Đáp án B",
                    hintText: "Nhập Đáp án B",
                    onChanged: (v) {
                      controller.questionReq.value.answerB = v;
                    },
                  ),
                ),
                SahaDivide(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SahaTextFieldNoBorder(
                    withAsterisk: true,
                    controller: controller.questionCEdit,
                    maxLine: 1,
                    textInputType: TextInputType.multiline,
                    validator: (value) {
                      if (value!.length == 0) {
                        return 'Không được để trống';
                      }
                      return null;
                    },
                    labelText: "Đáp án C",
                    hintText: "Nhập Đáp án C",
                    onChanged: (v) {
                      controller.questionReq.value.answerC = v;
                    },
                  ),
                ),
                SahaDivide(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SahaTextFieldNoBorder(
                    withAsterisk: true,
                    controller: controller.questionDEdit,
                    maxLine: 1,
                    textInputType: TextInputType.multiline,
                    validator: (value) {
                      if (value!.length == 0) {
                        return 'Không được để trống';
                      }
                      return null;
                    },
                    labelText: "Đáp án D",
                    hintText: "Nhập Đáp án D",
                    onChanged: (v) {
                      controller.questionReq.value.answerD = v;
                    },
                  ),
                ),
                SahaDivide(),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(child: Text("Đáp án đúng:")),
                      InkWell(
                        onTap: () {
                          showDialogAnswer(
                              answerChoose:
                                  controller.questionReq.value.rightAnswer,
                              onChoose: (v) {
                                controller.questionReq.value.rightAnswer = v;
                                controller.questionReq.refresh();
                                Get.back();
                              });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Obx(
                            () => Row(
                              children: [
                                Text(controller.questionReq.value.rightAnswer !=
                                        null
                                    ? controller.questionReq.value.rightAnswer!
                                    : 'Chọn đáp án đúng'),
                                Icon(Icons.keyboard_arrow_down_rounded)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
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
                    if (questionInput != null) {
                      controller.updateQuestion();
                    } else {
                      controller.createQuestion();
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

  void showDialogAnswer({String? answerChoose, required Function onChoose}) {
    showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Đáp án đúng",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 1,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text(
                      "A",
                    ),
                    onTap: () async {
                      onChoose('A');
                    },
                    trailing: answerChoose == 'A'
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).primaryColor,
                          )
                        : null,
                  ),
                  ListTile(
                    title: Text(
                      "B",
                    ),
                    onTap: () async {
                      onChoose('B');
                    },
                    trailing: answerChoose == 'B'
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).primaryColor,
                          )
                        : null,
                  ),
                  ListTile(
                    title: Text(
                      "C",
                    ),
                    onTap: () async {
                      onChoose('C');
                    },
                    trailing: answerChoose == 'C'
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).primaryColor,
                          )
                        : null,
                  ),
                  ListTile(
                    title: Text(
                      "D",
                    ),
                    onTap: () async {
                      onChoose('D');
                    },
                    trailing: answerChoose == 'D'
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).primaryColor,
                          )
                        : null,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          );
        });
  }
}
