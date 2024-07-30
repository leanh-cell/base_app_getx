import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/const/type_popup.dart';

class BottomSheetPopup {
  static void showTypePopup(
    Function onTap,
  ) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: Get.context!,
      builder: (BuildContext context) {
        Widget itemChoose({
          required String title,
          required String typeAction,
          required Function onTap,
        }) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Divider(
                height: 1,
              ),
              InkWell(
                onTap: () async {
                  onTap(typeAction);
                },
                child: Container(
                  width: Get.width,
                  padding: const EdgeInsets.all(12.0),
                  child: Row(children: [
                    Icon(Icons.monetization_on_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      title,
                    ),
                  ]),
                ),
              ),
            ],
          );
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            itemChoose(
                title: "Tới trang Web",
                typeAction: typeActionPopup[TYPE_POPUP.LINK],
                onTap: (v) {
                  onTap(v);
                }),
            itemChoose(
                title: "Tới Sản phẩm",
                typeAction: typeActionPopup[TYPE_POPUP.PRODUCT],
                onTap: (v) {
                  onTap(v);
                }),
            itemChoose(
                title: "Tới Danh mục sản phẩm",
                typeAction: typeActionPopup[TYPE_POPUP.CATEGORY_PRODUCT],
                onTap: (v) {
                  onTap(v);
                }),
            itemChoose(
                title: "Tới Bài viết tin tức",
                typeAction: typeActionPopup[TYPE_POPUP.POST],
                onTap: (v) {
                  onTap(v);
                }),
            itemChoose(
                title: "Tới Danh mục bài viết",
                typeAction: typeActionPopup[TYPE_POPUP.CATEGORY_POST],
                onTap: (v) {
                  onTap(v);
                }),
            Divider(height: 1,),
            SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
  }
}
