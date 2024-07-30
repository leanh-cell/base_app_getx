import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/lesson.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditLessonController extends GetxController {
  var isLoadingUpdate = false.obs;
  var titleTextEditingController = new TextEditingController();
var description = ''.obs;
  var shortDescriptionTextEditingController = new TextEditingController();
  var linkVideoYoutubeTextEditingController = new TextEditingController();
  var lessonRequest = Lesson().obs;
  Lesson lessonInput;

  EditLessonController({required this.lessonInput}) {
    lessonRequest.value = lessonInput;
    titleTextEditingController.text = lessonInput.title ?? "";
    description.value = lessonInput.description ?? "";
    linkVideoYoutubeTextEditingController.text =
        lessonInput.linkVideoYoutube ?? "";
    shortDescriptionTextEditingController.text =
        lessonInput.shortDescription ?? "";
  }

  Future<void> updateLesson() async {
    isLoadingUpdate.value = true;
    lessonRequest.value.description = description.value;
    try {
      var res = await RepositoryManager.educationReposition.updateLesson(
        lesson: lessonRequest.value,
        lessonId: lessonInput.id!,
      );
      SahaAlert.showSuccess(message: "Lưu thành công");
      Get.back(result: lessonRequest.value);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingUpdate.value = false;
  }
}
