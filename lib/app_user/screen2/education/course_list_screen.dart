import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty/saha_empty_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/model/course_list.dart';
import 'package:com.ikitech.store/app_user/screen2/education/add_course/add_course_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/education/chapter_lesson/chapter_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/education/course_list_controller.dart';
import 'package:com.ikitech.store/saha_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'quiz/quiz_screen.dart';

class CourseListScreen extends StatelessWidget {
  CourseController courseController = CourseController();
  SahaDataController sahaDataController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Khoá học",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(
        () => courseController.isLoading.value
            ? SahaLoadingFullScreen()
            : courseController.courseList.isEmpty
                ? Center(
                    child: Text('Chưa có khoá học'),
                  )
                : SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Danh sách khoá học',
                            style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.9),
                            ),
                          ),
                          Divider(
                            color: Colors.grey.shade300,
                          ),
                          ...courseController.courseList.map((e) {
                            return courseList(e);
                          }).toList()
                        ],
                      ),
                    ),
                  ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        color: Colors.white,
        child: Column(
          children: [
            SahaButtonFullParent(
              text: "Thêm khoá học",
              onPressed: () {
                if (sahaDataController
                        .badgeUser.value.decentralization?.trainAdd !=
                    true) {
                  SahaAlert.showError(message: "Bạn chưa được phân quyền này");
                  return;
                }
                Get.to(() => AddCourse())!.then((value) =>
                    {courseController.getCourseList(isRefresh: true)});
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget courseList(CourseList courseList) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ChapterScreen(
              idListCourses: courseList.id,
              courseListInput: courseList,
            ));
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.only(
          top: 5,
          left: 5,
          right: 5,
          bottom: 20,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: courseList.imageUrl ?? "",
              width: Get.width,
              height: 200,
              fit: BoxFit.cover,
              placeholder: (context, url) => SahaLoadingWidget(),
              errorWidget: (context, url, error) => SahaEmptyImage(),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: Get.width,
                    child: Text(
                      courseList.title?.toUpperCase() ?? "",
                      maxLines: 2,
                      style: GoogleFonts.nunito(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 1,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    courseList.shortDescription ?? "",
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    if (sahaDataController
                            .badgeUser.value.decentralization?.trainExamList !=
                        true) {
                      SahaAlert.showError(
                          message: "Bạn chưa được phân quyền này");
                      return;
                    }
                    Get.to(() => QuizScreen(
                          courseId: courseList.id!,
                        ));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        "Danh sách bài thi",
                        style: TextStyle(
                            color: Theme.of(Get.context!).primaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (sahaDataController
                            .badgeUser.value.decentralization?.trainUpdate !=
                        true) {
                      SahaAlert.showError(
                          message: "Bạn chưa được phân quyền này");
                      return;
                    }
                    Get.to(() => AddCourse(
                              courseListInput: courseList,
                            ))!
                        .then((value) =>
                            {courseController.getCourseList(isRefresh: true)});
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
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
                    if (sahaDataController
                            .badgeUser.value.decentralization?.trainUpdate !=
                        true) {
                      SahaAlert.showError(
                          message: "Bạn chưa được phân quyền này");
                      return;
                    }
                    SahaDialogApp.showDialogYesNo(
                        mess:
                            'Các dữ liệu về khoá học, chương, bài học, vv... sẽ bị xoá, bạn vẫn muốn tiếp tục chứ ?',
                        onOK: () {
                          courseController.deleteTrainCourses(courseList.id!);
                        });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
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
    );
  }
}
