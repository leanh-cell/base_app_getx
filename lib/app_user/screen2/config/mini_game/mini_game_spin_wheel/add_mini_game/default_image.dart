import 'dart:developer';

import 'package:com.ikitech.store/app_user/screen2/config/mini_game/mini_game_spin_wheel/add_mini_game/add_mini_game_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductImage extends StatefulWidget {
  ProductImage(
      {Key? key, required this.listImageUrl, this.imageUrl, this.isUpdate})
      : super(key: key);
  List<String> listImageUrl;
  String? imageUrl;
  bool? isUpdate;

  @override
  State<ProductImage> createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> {
  AddMiniGameController addMiniGameController = Get.find();
  var imageIndex = 0.obs;
  @override
  void initState() {
    super.initState();
    if (widget.imageUrl != null) {
      var idx = widget.listImageUrl.indexWhere((e) => e == widget.imageUrl);
      imageIndex.value = idx;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isUpdate == false) {
      addMiniGameController.backgroundImageDefault = widget.listImageUrl[0];
    }

    return Obx(
      () => SizedBox(
        //height: Get.height / 2.2,
        width: Get.width,
        child: Column(
          children: [
            // Expanded(
            //   flex: 3,
            //   child: Padding(
            //     padding: const EdgeInsets.all(2.0),
            //     child: InkWell(
            //       onTap: () {
            //         // ShowImage.seeImage(
            //         //     listImageUrl: (widget.listImageUrl ?? []).toList(),
            //         //     index: imageIndex.value);
            //       },
            //       child: Image.asset(
            //         widget.listImageUrl[imageIndex.value],
            //         height: double.infinity,
            //         width: double.infinity,
            //         fit: BoxFit.cover,
            //       ),
            //     ),
            //   ),
            // ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...widget.listImageUrl
                        .map((e) => images(e, widget.listImageUrl.indexOf(e)))
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget images(String imageUrl, int index) {
    return Container(
      decoration: BoxDecoration(
          border: index == imageIndex.value
              ? Border.all(color: Theme.of(context).primaryColor)
              : null),
      height: 100,
      width: 100,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
        child: InkWell(
          onTap: () {
            imageIndex.value = index;
            addMiniGameController.backgroundImageDefault = imageUrl;
            log(addMiniGameController.backgroundImageDefault ?? 'a');
          },
          child: Image.asset(
            imageUrl,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
