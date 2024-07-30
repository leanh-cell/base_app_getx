import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/chapter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditChapterController extends GetxController {
  var isLoadingUpdate = false.obs;
  var titleTextEditingController = new TextEditingController();
  var shortDescriptionTextEditingController = new TextEditingController();
  var chapterRequest = Chapter().obs;
  Chapter chapterInput;
  int courseId;

  EditChapterController({required this.chapterInput, required this.courseId}) {
    titleTextEditingController.text = chapterInput.title ?? "";
    shortDescriptionTextEditingController.text =
        chapterInput.shortDescription ?? "";
    chapterRequest.value = chapterInput;
  }

  Future<void> updateChapter() async {
    isLoadingUpdate.value = true;
    try {
      var res = await RepositoryManager.educationReposition.updateChapter(
          chapter: chapterRequest.value,
          idChapter: chapterInput.id!,
          idCourse: courseId);
      SahaAlert.showSuccess(message: "Lưu thành công");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingUpdate.value = false;
  }
}
