import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/course_list.dart';
import 'package:get/get.dart';

class CourseController extends GetxController {
  var courseList = RxList<CourseList>();
  int currentPage = 1;
  bool isEnd = false;
  var isLoading = true.obs;

  CourseController() {
    getCourseList(isRefresh: true);
  }

  Future<void> deleteTrainCourses (int courseId)  async {
    try {
      var data = await RepositoryManager.educationReposition.deleteTrainCourses(courseId: courseId);
      SahaAlert.showSuccess(message: 'Đã xoá');
      getCourseList(isRefresh: true);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }


  Future<void> getCourseList({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        var data = await RepositoryManager.educationReposition.getCourseList(
          currentPage: currentPage,
        );

        if (isRefresh == true) {
          courseList(data!.data!.data!);
          courseList.refresh();
        } else {
          courseList.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    ;
  }
}
