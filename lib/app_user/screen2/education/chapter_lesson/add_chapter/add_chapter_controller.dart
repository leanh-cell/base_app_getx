import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/chapter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddChapterController extends GetxController {
  var titleTextEditingController = new TextEditingController();
  var shortDescriptionTextEditingController = new TextEditingController();
  Chapter? ChapterInput;

  AddChapterController({this.ChapterInput}) {
    if (ChapterInput != null) {
      titleTextEditingController.text = ChapterInput?.title ?? "";
      shortDescriptionTextEditingController.text =
          ChapterInput?.shortDescription ?? "";
    }
  }

  Future<void> addChapter({
    required int trainCourseId,
    required String title,
    required String shortDescription,
  }) async {
    try {
      var data = await RepositoryManager.educationReposition.addChapter(
        trainCourseId: trainCourseId,
        title: title,
        shortDescription: shortDescription,
      );
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
