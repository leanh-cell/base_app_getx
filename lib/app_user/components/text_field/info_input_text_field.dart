import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoInputTextField extends StatelessWidget {
  String title;
  String? hintText;
  TextEditingController? textEditingController;
  TextInputType? keyboardType;
  Function? onTap;
  Widget? icon;

  InfoInputTextField(
      {required this.title,
      this.hintText,
        this.keyboardType,
      this.textEditingController,
      this.onTap,
      this.icon
      });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          SizedBox(
            height: 5,
          ),
          Stack(
            children: [
              SizedBox(
                width: Get.width,
                height: 45,
                child: TextField(
                  keyboardType: keyboardType,
                  controller: textEditingController,
                  decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: TextStyle(color: Colors.grey[400])),
                ),
              ),
              if (icon != null)
                Positioned(
                    bottom: 20, right: 20, height: 15, width: 15, child: icon!),
              if (onTap != null)
                InkWell(
                  onTap: onTap == null
                      ? null
                      : () {
                    onTap!();
                  },
                  child: Container(
                    width: Get.width,
                    height: 45,
                    color: Colors.transparent,
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
