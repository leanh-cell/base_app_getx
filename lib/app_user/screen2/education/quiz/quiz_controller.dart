import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:get/get.dart';

import '../../../data/repository/repository_manager.dart';
import '../../../model/quiz.dart';

class QuizController extends GetxController {
  var listQuiz = RxList<Quiz>();

  var loading = true.obs;

  int courseId;
  QuizController({required this.courseId}) {
    getAllQuiz();
  }

  Future<void> getAllQuiz() async {
    try {
      var data = await RepositoryManager.educationReposition
          .getAllQuiz(courseId: courseId);
      listQuiz(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading.value = false;
  }

  Future<void> deleteQuiz(int quizId) async {
    try {
      var data = await RepositoryManager.educationReposition
          .deleteQuiz(courseId: courseId, quizId: quizId);
      SahaAlert.showSuccess(message: 'Xoá thành công');
      getAllQuiz();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading.value = false;
  }
}
