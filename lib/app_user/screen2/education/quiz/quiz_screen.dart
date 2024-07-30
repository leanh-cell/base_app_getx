import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/saha_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/saha_user/button/saha_button.dart';
import '../../../model/quiz.dart';
import '../quiz/quiz_controller.dart';
import 'create_update_quiz/create_update_quiz_screen.dart';
import 'question/question_screen.dart';

class QuizScreen extends StatelessWidget {
  final int courseId;

  QuizScreen({required this.courseId}) {
    quizController = QuizController(courseId: courseId);
  }

  late final QuizController quizController;
  final SahaDataController sahaDataController = Get.find();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách bài thi"),
      ),
      body: Obx(
        () => quizController.loading.value
            ? SahaLoadingFullScreen()
            : quizController.listQuiz.isEmpty
                ? Center(
                    child: Text('Chưa có bài thi'),
                  )
                : SingleChildScrollView(
                    child: Column(
                        children: quizController.listQuiz
                            .map((e) => itemQuiz(e))
                            .toList()),
                  ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        color: Colors.white,
        child: Column(
          children: [
            SahaButtonFullParent(
              text: "Thêm bài thi",
              onPressed: () {
                if (sahaDataController
                        .badgeUser.value.decentralization?.trainExamAdd !=
                    true) {
                  SahaAlert.showError(message: "Bạn chưa có quyền này");
                  return;
                }
                Get.to(() => CreateUpdateQuizScreen(
                          courseId: courseId,
                        ))!
                    .then((value) => {quizController.getAllQuiz()});
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget itemQuiz(Quiz quiz) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.to(() => QuestionScreen(
                  quizInput: quiz,
                ));
          },
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bài thi: ${quiz.title ?? ""}',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${quiz.shortDescription ?? ""}',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Thời lượng: ${quiz.minute ?? "0"} phút'),
                              Text(
                                  'Trạng thái: ${quiz.show == true ? "Đang hiển thị" : 'Đang ẩn'}'),
                            ],
                          ),
                        ],
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
                            Get.to(() => QuestionScreen(
                                  quizInput: quiz,
                                ));
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text(
                                "Danh sách câu hỏi",
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (sahaDataController.badgeUser.value
                                    .decentralization?.trainExamUpdate !=
                                true) {
                              SahaAlert.showError(
                                  message: "Bạn chưa có quyền này");
                              return;
                            }
                            Get.to(() => CreateUpdateQuizScreen(
                                      quizInput: quiz,
                                      courseId: courseId,
                                    ))!
                                .then((value) => {quizController.getAllQuiz()});
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.2)),
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
                            if (sahaDataController.badgeUser.value
                                    .decentralization?.trainExamDelete !=
                                true) {
                              SahaAlert.showError(
                                  message: "Bạn chưa có quyền này");
                              return;
                            }
                            SahaDialogApp.showDialogYesNo(
                                mess: 'Bạn có chắc muốn xoá bài thi này chứ?',
                                onOK: () {
                                  quizController.deleteQuiz(quiz.id!);
                                });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.2)),
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
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Icon(Icons.navigate_next_rounded)
            ],
          ),
        ),
        Container(
          height: 8,
          color: Colors.grey[200],
        )
      ],
    );
  }
}
