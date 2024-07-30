import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/screen2/agency/list_agency_type/product_agency/edit_price/widget/select_images_controller.dart';
import '../reward_agency_controller.dart';
import 'select_images_bonus_step.dart';

class AddStepBonusDialog {
  static void showDialogInputText({
    int? thresholdIp,
    int? rewardValueIp,
    int? limitIp,
    String? rewardNameIp,
    String? rewardDescriptionIp,
    String? rewardImageUrlIp,
    required String title,
    required String textButton,
    required Function onDone,
  }) {
    RewardAgencyController rewardAgencyController = Get.find();
    TextEditingController nameEditingController =
        TextEditingController(text: rewardNameIp);
    TextEditingController thresholdEditingController = TextEditingController(
        text: thresholdIp == null ? null : "$thresholdIp");
    TextEditingController valueEditingController = TextEditingController(
        text: rewardValueIp == null ? null : "$rewardValueIp");
    TextEditingController limitEditingController =
        TextEditingController(text: limitIp == null ? null : "$limitIp");
    TextEditingController desEditingController =
        TextEditingController(text: rewardDescriptionIp);
    Get.dialog(
      AlertDialog(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Text(
                  title,
                  textAlign: TextAlign.center,
                )),
              ],
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 100,
                width: 120,
                child: SelectStepBonusImages(
                  images: rewardImageUrlIp != null
                      ? [
                          ImageData(
                              linkImage: rewardImageUrlIp,
                              errorUpload: false,
                              uploading: false)
                        ]
                      : rewardAgencyController.listImages!,
                  onUpload: () {},
                  doneUpload: (List<ImageData> listImages) {
                    print(
                        "done upload image ${listImages.length} images => ${listImages.toList().map((e) => e.linkImage).toList()}");
                    rewardAgencyController.setUploadingImages(false);
                    rewardAgencyController.listImages = listImages;
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: nameEditingController,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(fontSize: 14),
                  maxLines: 5,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    hintText: "Tên mức thưởng",
                    contentPadding: EdgeInsets.only(left: 5),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[300]!)),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: thresholdEditingController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(fontSize: 14),
                  maxLines: 5,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    hintText: "Mức thưởng doanh số (VNĐ)",
                    contentPadding: EdgeInsets.only(left: 5),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[300]!)),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: valueEditingController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(fontSize: 14),
                  maxLines: 5,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    hintText: "Giá trị thưởng (VNĐ)",
                    contentPadding: EdgeInsets.only(left: 5),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[300]!)),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: limitEditingController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(fontSize: 14),
                  maxLines: 5,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    hintText: "Giới hạn thưởng (Số lần)",
                    contentPadding: EdgeInsets.only(left: 5),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[300]!)),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 100,
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: desEditingController,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(fontSize: 14),
                  maxLines: 5,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    hintText: "Mô tả",
                    contentPadding: EdgeInsets.only(left: 5),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[300]!)),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      onDone({
                        "name": nameEditingController.text,
                        "threshold": int.parse(thresholdEditingController.text),
                        "value": int.parse(valueEditingController.text),
                        "limit": int.parse(limitEditingController.text),
                        "des": desEditingController.text,
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        textButton,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }
}
