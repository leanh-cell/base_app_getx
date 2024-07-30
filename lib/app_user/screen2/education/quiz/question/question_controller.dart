import 'package:get/get.dart';

import '../../../../components/saha_user/toast/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/question.dart';
import '../../../../model/quiz.dart';

class QuestionController extends GetxController {
  var quiz = Quiz().obs;
  var loading = true.obs;
  Quiz quizInput;

  QuestionController({required this.quizInput}) {
    getQuiz();
  }

  Future<void> getQuiz() async {
    try {
      var data = await RepositoryManager.educationReposition
          .getQuiz(courseId: quizInput.trainCourseId!, quizId: quizInput.id!);
      quiz(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }

    loading.value = false;
  }

  Future<void> deleteQuestion({required int questionId}) async {
    try {
      var res = await RepositoryManager.educationReposition
          .deleteQuestion(courseId: quizInput.trainCourseId!, quizId: quizInput.id!, questionId: questionId);
      getQuiz();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
