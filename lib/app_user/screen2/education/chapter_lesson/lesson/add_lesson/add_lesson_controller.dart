import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/lesson.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddLessonController extends GetxController {
  var titleTextEditingController = new TextEditingController();
  var shortDescriptionTextEditingController = new TextEditingController();
  var description = ''.obs;
  var linkVideoYoutubeTextEditingController = new TextEditingController();
  var isLoading = false.obs;

  Future<void> addLesson({
    required int trainChapterId,
    required String title,
    required String shortDescription,
    required String linkVideoYoutube,
  }) async {
    isLoading.value = true;
    try {
      var data = await RepositoryManager.educationReposition.addLesson(
        trainChapterId: trainChapterId,
        title: title,
        description: description.value,
        shortDescription: shortDescription,
        linkVideoYoutube: linkVideoYoutube,
      );
      print(data!.data);
      Get.back(
        result: data.data,
      );
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }
}
