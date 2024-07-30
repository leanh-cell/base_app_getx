import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/model/chapter.dart';
import 'package:com.ikitech.store/app_user/model/lesson.dart';
import 'package:com.ikitech.store/app_user/screen2/education/chapter_lesson/chapter_lesson_controller.dart';
import 'package:com.ikitech.store/app_user/screen2/education/chapter_lesson/lesson/add_lesson/add_lesson_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../components/saha_user/dialog/dialog.dart';
import 'edit_lesson/edit_lesson_screen.dart';
import 'lesson_screen.dart';
import 'list_lesson_controller.dart';

class ListLessonScreen extends StatefulWidget {
  Chapter? chapter;

  ListLessonScreen({this.chapter});

  @override
  State<ListLessonScreen> createState() => _ListLessonScreenState();
}

class _ListLessonScreenState extends State<ListLessonScreen> {
  ListLessonController lessonController = ListLessonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Danh sách bài học",
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 10,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Chương:',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        widget.chapter?.title ?? "",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor.withOpacity(0.9),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
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
                    ...widget.chapter!.lessons!.map((e) {
                      return lesson(e);
                    }).toList()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        color: Colors.white,
        child: Column(
          children: [
            SahaButtonFullParent(
              text: "Thêm bài học",
              onPressed: () {
                Get.to(() => AddLessonScreen(
                          chapterId: widget.chapter!.id,
                        ))!
                    .then((value) {
                  if (value != null) {
                    setState(() {
                      widget.chapter!.lessons!.add(value);
                    });
                  }
                });
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget lesson(Lesson lesson) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.to(() => LessonScreen(
                  lessonInput: lesson,
                  idLesson: lesson.id,
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
                            'Bài học: ${lesson.title ?? ""}',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${lesson.shortDescription ?? ""}',
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
                    if (lesson.id != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => EditLessonScreen(
                                        lessonInput: lesson,
                                      ))!
                                  .then((value) => {
                                        if (value != null)
                                          {
                                            setState(() {
                                              var index = widget
                                                  .chapter!.lessons!
                                                  .indexWhere((e) =>
                                                      e.id ==
                                                      (value as Lesson).id);
                                              if (index != -1) {
                                                widget.chapter!
                                                        .lessons![index] ==
                                                    value;
                                              }
                                            })
                                          }
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
                                  mess:
                                      "Bạn có chắc muốn xoá bài học này chứ ?",
                                  onOK: () {
                                    lessonController.deleteLesson(
                                      lessonId: lesson.id!,
                                    );
                                    widget.chapter!.lessons!.remove(lesson);
                                    setState(() {});
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
