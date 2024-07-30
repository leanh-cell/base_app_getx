import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/quiz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreateUpdateQuizController extends GetxController {
  TextEditingController titleEdit = TextEditingController();
  TextEditingController desEdit = TextEditingController();
  TextEditingController minuteEdit = TextEditingController();

  var quizReq = Quiz().obs;
  Quiz? quizInput;
  int courseId;

  CreateUpdateQuizController({required this.courseId, this.quizInput}) {
    if (quizInput != null) {
      quizReq.value = quizInput!;
      titleEdit.text = quizInput!.title ?? "";
      desEdit.text = quizInput!.shortDescription ?? "";
      minuteEdit.text = "${quizInput!.minute ?? 0}";
    }
  }

  Future<void> createQuiz() async {
    try {
      var data = await RepositoryManager.educationReposition
          .createQuiz(courseId: courseId, quiz: quizReq.value);
      SahaAlert.showSuccess(message: 'Thêm thành công');
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateQuiz() async {
    try {
      var data = await RepositoryManager.educationReposition
          .updateQuiz(courseId: courseId, quiz: quizReq.value, quizId: quizInput!.id!);
      SahaAlert.showSuccess(message: 'Sửa thành công');
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
