import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/chapter.dart';
import 'package:com.ikitech.store/app_user/model/course_list.dart';
import 'package:get/get.dart';

class ChapterLessonController extends GetxController {
  var listChapterLesson = RxList<Chapter>();
  bool isEnd = false;
  var isLoading = false.obs;
  int idCourses;
  CourseList? courseListInput;

  ChapterLessonController({required this.idCourses, this.courseListInput}) {
    getChapterLesson(isRefresh: true);
  }

  Future<void> getChapterLesson({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.educationReposition.getChapterLesson(
          idCourse: idCourses,
        );

        if (isRefresh == true) {
          listChapterLesson(data!.data!);
          listChapterLesson.refresh();
        } else {
          listChapterLesson.addAll(data!.data!);
        }
      }
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    ;
  }

  Future<void> deleteChapter({required int idChapter}) async {
    try {
      var data = await RepositoryManager.educationReposition
          .deleteChapter(chapterId: idChapter);
      listChapterLesson.removeWhere((element) => idChapter == element.id);
      SahaAlert.showSuccess(message: "Đã xoá chương học");
    } catch (err) {
      SahaAlert.showToastMiddle(message: err.toString());
    }
  }
}
