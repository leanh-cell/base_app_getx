import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/model/chapter.dart';
import 'package:com.ikitech.store/app_user/model/course_list.dart';
import 'package:com.ikitech.store/app_user/screen2/education/chapter_lesson/add_chapter/add_chapter_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/education/chapter_lesson/chapter_lesson_controller.dart';
import 'package:com.ikitech.store/app_user/screen2/education/chapter_lesson/edit_chapter/edit_chapter_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/education/chapter_lesson/lesson/lesson_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../../components/saha_user/dialog/dialog.dart';
import 'lesson/list_lesson_screen.dart';

class ChapterScreen extends StatelessWidget {
  late ChapterLessonController chapterLessonController;
  CourseList? courseListInput;

  ChapterScreen({required this.idListCourses, this.courseListInput}) {
    chapterLessonController = ChapterLessonController(
        idCourses: idListCourses!, courseListInput: courseListInput);
  }

  int? idListCourses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Danh sách chương",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    children: [
                      Text(
                        'Khoá học:',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Text(
                            courseListInput?.title ?? "",
                            style: TextStyle(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.9),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    children: [
                      ...chapterLessonController.listChapterLesson.map((e) {
                        return listChapter(e);
                      }).toList()
                    ],
                  ),
                ),
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
              text: "Thêm chương học",
              onPressed: () {
                Get.to(() => AddChapterScreen(
                  courseId: courseListInput?.id,
                ))!
                    .then((value) => {
                  chapterLessonController.getChapterLesson(
                      isRefresh: true)
                });
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget listChapter(Chapter chapter) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.to(() => ListLessonScreen(
                  chapter: chapter,
                ));
          },
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${chapter.title ?? ""}',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${chapter.shortDescription ?? ""}',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
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
                            Get.to(() => ListLessonScreen(
                              chapter: chapter,
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
                                "Danh sách bài học",
                                style: TextStyle(
                                  color: Theme.of(Get.context!).primaryColor,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => EditChapterScreen(
                                      chapterInput: chapter,
                                      courseId: courseListInput!.id!,
                                    ))!
                                .then((value) => {
                                      chapterLessonController.getChapterLesson(
                                          isRefresh: true)
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
                                "Chỉnh sửa",
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            SahaDialogApp.showDialogYesNo(
                                mess: "Bạn có chắc muốn xoá chương này chứ ?",
                                onOK: () {
                                  chapterLessonController.deleteChapter(
                                      idChapter: chapter.id!);
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
