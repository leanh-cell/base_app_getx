import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty/saha_empty_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_container.dart';

import 'image_picker_controller.dart';

class ImageDialogPicker {
  static Future<void> showPickOnePopup(
      {String? title,
      String? hintText,
      Function? onSuccess,
      Function? onCancel}) {
    ImagePickerController imagePickerController = new ImagePickerController();

    return showDialog<String>(
        context: Get.context!,
        builder: (BuildContext context) {
          TextEditingController textEditingController =
              new TextEditingController();
          return new AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: new Row(
              children: <Widget>[
                new Expanded(
                    child: Obx(
                  () => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Ảnh quảng cáo",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          height: Get.height / 3,
                          width: Get.width / 2,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: Theme.of(context).primaryColor)),
                          child: imagePickerController.imageUrl.value != ""
                              ? CachedNetworkImage(
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      imagePickerController.imageUrl.value,
                                  placeholder: (context, url) =>
                                      SahaLoadingContainer(),
                                  errorWidget: (context, url, error) =>
                                      SahaEmptyImage(),
                                )
                              : imagePickerController.waiting.value
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        imagePickerController.onUp();
                                      },
                                      icon:
                                          new Icon(Icons.camera_alt_outlined))),
                    ],
                  ),
                ))
              ],
            ),
            actions: <Widget>[
              new TextButton(
                  child: const Text('Hủy'),
                  onPressed: () {
                    if (onCancel != null) onCancel();
                    Navigator.pop(context);
                  }),
              new TextButton(
                  child: const Text('Đồng ý'),
                  onPressed: () {
                    onSuccess!(imagePickerController.imageUrl.value);
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  static Future<void> showPickOneImage(
      {String? title,
      String? hintText,
      Function? onSuccess,
      Function? onCancel}) {
    ImagePickerController imagePickerController = new ImagePickerController();

    return showDialog<String>(
        context: Get.context!,
        builder: (BuildContext context) {
          TextEditingController textEditingController =
              new TextEditingController();
          return new AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: new Row(
              children: <Widget>[
                new Expanded(
                    child: Obx(
                  () => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Ảnh cho nút"),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey)),
                          child: imagePickerController.imageUrl.value != ""
                              ? CachedNetworkImage(
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      imagePickerController.imageUrl.value,
                                  placeholder: (context, url) =>
                                      SahaLoadingContainer(),
                                  errorWidget: (context, url, error) =>
                                      SahaEmptyImage(),
                                )
                              : imagePickerController.waiting.value
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        imagePickerController.onUp();
                                      },
                                      icon:
                                          new Icon(Icons.camera_alt_outlined))),
                    ],
                  ),
                ))
              ],
            ),
            actions: <Widget>[
              new TextButton(
                  child: const Text('Hủy'),
                  onPressed: () {
                    if (onCancel != null) onCancel();
                    Navigator.pop(context);
                  }),
              new TextButton(
                  child: const Text('Đồng ý'),
                  onPressed: () {
                    onSuccess!(imagePickerController.imageUrl.value);
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }
}
