import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/decentralization/decentralization_widget.dart';
import 'package:com.ikitech.store/app_user/const/constant.dart';
import 'package:ionicons/ionicons.dart';
import '../../../saha_data_controller.dart';
import 'category_post/category_screen.dart';
import 'post/posts_screen.dart';

class PostNaviScreen extends StatelessWidget {
  SahaDataController sahaDataController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        titleText: "Quản lý tin tức bài viết",
      ),
      body: Column(
        children: [
          itemList(
              icon: Icon(
                Ionicons.library_outline,
                color: SahaPrimaryColor,
              ),
              title: "Danh mục bài viết",
              onPress: () {
                Get.to(() => CategoryPostScreen(
                      isSelect: false,
                    ));
              }),
          itemList(
              icon: Icon(
                Ionicons.reader_outline,
                color: SahaPrimaryColor,
              ),
              title: "Tin tức - bài viết",
              onPress: () {
                Get.to(() => PostScreen());
              }),
        ],
      ),
    );
  }

  Widget itemList({Function? onPress, String? title, Icon? icon}) {
    return ListTile(
      leading: icon,
      title: Text("$title"),
      onTap: () {
        onPress!();
      },
    );
  }
}
