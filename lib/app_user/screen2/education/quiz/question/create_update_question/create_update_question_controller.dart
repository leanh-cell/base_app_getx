import 'dart:io';

import 'package:com.ikitech.store/app_user/model/question.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../components/saha_user/toast/saha_alert.dart';
import '../../../../../data/repository/repository_manager.dart';
import '../../../../../model/image_file.dart';
import '../../../../../model/quiz.dart';
import '../../../../../utils/image_utils.dart';

class CreateUpdateQuestionController extends GetxController {
  Rx<ImageDataFile?> dataImages = ImageDataFile().obs;
  var isUpdatingImage = false.obs;

  var questionReq = Question().obs;
  Question? questionInput;
  Quiz quizInput;

  TextEditingController questionEdit = TextEditingController();
  TextEditingController questionAEdit = TextEditingController();
  TextEditingController questionBEdit = TextEditingController();
  TextEditingController questionCEdit = TextEditingController();
  TextEditingController questionDEdit = TextEditingController();

  CreateUpdateQuestionController(
      {this.questionInput, required this.quizInput}) {
    if (questionInput != null) {
      questionReq.value = questionInput!;
      questionEdit.text = questionInput!.question ?? "";
      questionAEdit.text = questionInput!.answerA ?? "";
      questionBEdit.text = questionInput!.answerB ?? "";
      questionCEdit.text = questionInput!.answerC ?? "";
      questionDEdit.text = questionInput!.answerD ?? "";
    }
  }

  Future<void> createQuestion() async {
    if (questionReq.value.rightAnswer == null) {
      SahaAlert.showError(message: 'Chưa chọn đáp án đúng');
      return;
    }
    try {
      var data = await RepositoryManager.educationReposition.createQuestion(
          courseId: quizInput.trainCourseId!,
          quizId: quizInput.id!,
          question: questionReq.value);
      SahaAlert.showSuccess(message: "Thêm thành công");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateQuestion() async {
    if (questionReq.value.rightAnswer == null) {
      SahaAlert.showError(message: 'Chưa chọn đáp án đúng');
      return;
    }
    try {
      var data = await RepositoryManager.educationReposition.updateQuestion(
          courseId: quizInput.trainCourseId!,
          quizId: quizInput.id!,
          questionId: questionInput!.id!,
          question: questionReq.value);
      SahaAlert.showSuccess(message: "Sửa thành công");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<String?> loadAssets() async {
    try {
      final picker = ImagePicker();
      final pickedFile = (await picker.pickImage(source: ImageSource.gallery))!;
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );

      if (croppedFile == null) return "";

      dataImages.value = ImageDataFile(
          file: File(croppedFile.path), uploading: true, errorUpload: false);

      return await uploadImage(File(croppedFile.path));
    } on Exception catch (e) {
      return null;
    }
  }

  Future<String?> uploadImage(File file) async {
    isUpdatingImage.value = true;
    try {
      var fileUpImageCompress =
          await ImageUtils.getImageCompress(file, quality: 20);

      var link = (await RepositoryManager.imageRepository
          .uploadImage(fileUpImageCompress))!;

      dataImages.value =
          ImageDataFile(linkImage: link, uploading: false, errorUpload: false);
      questionReq.value.questionImage = link;
    } catch (err) {
      SahaAlert.showError(message: "Có lỗi khi up ảnh xin thử lại");
    }
    isUpdatingImage.value = false;
  }
}
