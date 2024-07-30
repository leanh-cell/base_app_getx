import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/lesson.dart';
import 'package:get/get.dart';

class ListLessonController extends GetxController {
  var listLesson = RxList<Lesson>();
  Lesson? lessonInput;

  ListLessonController({this.lessonInput}) {}

  Future<void> deleteLesson({required int lessonId}) async {
    try {
      var data = await RepositoryManager.educationReposition
          .deleteLesson(lessonId: lessonId);
      listLesson.removeWhere((element) => lessonId == element.id);
      listLesson.refresh();
      SahaAlert.showSuccess(message: "Đã xoá bài học");
    } catch (err) {
      SahaAlert.showToastMiddle(message: err.toString());
    }
  }
}
