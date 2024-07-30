import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImagePickerController extends GetxController {
  var waiting = false.obs;
  var imageUrl = "".obs;

  void onUp() {
   try {
     waiting.value = true;
     pickerOneImage(onPick: (file) async {
       var linkImage = await RepositoryManager.imageRepository.uploadImage(file);
       imageUrl.value = linkImage!;

     });
     waiting.value = false;
   } catch (err) {
     SahaAlert.showError(message: "Có lỗi khi up ảnh");
   }
  }

  void pickerOneImage({Function? onPick}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      var file = File(pickedFile.path);

      final dir = await path_provider.getTemporaryDirectory();
      final targetPath = dir.absolute.path + basename(pickedFile.path) + ".jpg";

      var result = (await FlutterImageCompress.compressAndGetFile(
          file.absolute.path, targetPath,
          quality: 20, minHeight: 512, minWidth: 512))!;

      onPick!(File(result.path));
    } else {
      print('No image selected.');
    }
  }
}
