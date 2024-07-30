import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/saha_user/button/saha_button.dart';
import '../../../../components/saha_user/dialog/dialog.dart';
import '../../../../components/saha_user/empty/saha_empty_image.dart';
import '../../../../components/saha_user/loading/loading_container.dart';
import '../../../../model/question.dart';
import '../../../../model/quiz.dart';
import 'create_update_question/create_update_question_screen.dart';
import 'question_controller.dart';

class QuestionScreen extends StatelessWidget {
  Quiz quizInput;

  QuestionScreen({required this.quizInput}) {
    questionController = QuestionController(quizInput: quizInput);
  }

  late QuestionController questionController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách câu hỏi"),
      ),
      body: Obx(
        () => questionController.loading.value == true
            ? SahaLoadingFullScreen()
            : (questionController.quiz.value.questions ?? []).isEmpty
                ? Center(
                    child: Text("Chưa có câu hỏi"),
                  )
                : ListView.builder(
                    itemCount:
                        (questionController.quiz.value.questions ?? []).length,
                    itemBuilder: (context, i) {
                      return itemQuestion(
                          (questionController.quiz.value.questions ?? [])[i],
                          i);
                    },
                  ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        color: Colors.white,
        child: Column(
          children: [
            SahaButtonFullParent(
              text: "Thêm câu hỏi",
              onPressed: () {
                Get.to(() => CreateUpdateQuestionScreen(
                          quizInput: quizInput,
                        ))!
                    .then((value) => {questionController.getQuiz()});
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget itemQuestion(Question question, int index) {
    return InkWell(
      onTap: () {
        Get.to(() => CreateUpdateQuestionScreen(
                  quizInput: quizInput,
                  questionInput: question,
                ))!
            .then((value) => {questionController.getQuiz()});
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (question.questionImage != null &&
                    question.questionImage != "")
                  CachedNetworkImage(
                    height: 300,
                    width: Get.width,
                    fit: BoxFit.cover,
                    imageUrl: question.questionImage!,
                    placeholder: (context, url) => SahaLoadingContainer(),
                    errorWidget: (context, url, error) => SahaEmptyImage(),
                  ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Câu hỏi ${index + 1}: ${question.question ?? ""}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'A: ${question.answerA ?? ""}',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'B: ${question.answerB ?? ""}',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'C: ${question.answerC ?? ""}',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'D: ${question.answerD ?? ""}',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Đáp án đúng: ${question.rightAnswer ?? ""}',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => CreateUpdateQuestionScreen(
                                  quizInput: quizInput,
                                  questionInput: question,
                                ))!
                            .then((value) => {questionController.getQuiz()});
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            "Chỉnh sửa",
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        SahaDialogApp.showDialogYesNo(
                            mess: 'Bạn có chắc muốn xoá câu hỏi này chứ?',
                            onOK: () {
                              questionController.deleteQuestion(
                                  questionId: question.id!);
                            });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            "Xoá",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 8,
            color: Colors.grey[200],
          )
        ],
      ),
    );
  }
}
