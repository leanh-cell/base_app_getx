import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';

class ShowChooseOrderOption {
  static void showChoose({Function? onReturn, List<bool>? listChooseOption}) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: Get.context!,
      builder: (BuildContext context) {
        Widget itemOption(
            {Icon? icon,
            String? text,
            Function? onTap,
            Color? colorText,
            int? index}) {
          return Column(
            children: [
              InkWell(
                onTap: () {
                  onTap!();
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      icon!,
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        text!,
                        style: TextStyle(color: colorText),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                height: 1,
              )
            ],
          );
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Tuỳ chọn báo cáo",
                style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
            ),
            Divider(
              height: 1,
            ),
            itemOption(
                icon: Icon(
                  Icons.assignment_turned_in_outlined,
                  color: listChooseOption![0]
                      ? Theme.of(context).primaryColor
                      : Colors.grey[600],
                ),
                text: "Báo cáo hoá đơn",
                colorText: listChooseOption[0]
                    ? Theme.of(context).primaryColor
                    : Colors.grey[600],
                onTap: () {
                  onReturn!(0);
                }),
            itemOption(
                icon: Icon(
                  Icons.multiline_chart_outlined,
                  color: listChooseOption[1]
                      ? Theme.of(context).primaryColor
                      : Colors.grey[600],
                ),
                text: "Báo cáo chỉ số kinh doanh",
                colorText: listChooseOption[1]
                    ? Theme.of(context).primaryColor
                    : Colors.grey[600],
                onTap: () {
                  onReturn!(1);
                }),
            itemOption(
                icon: Icon(
                  Icons.multiline_chart_outlined,
                  color: listChooseOption[1]
                      ? Theme.of(context).primaryColor
                      : Colors.grey[600],
                ),
                text: "Báo cáo sản phẩm",
                colorText: listChooseOption[1]
                    ? Theme.of(context).primaryColor
                    : Colors.grey[600],
                onTap: () {
                  onReturn!(2);
                }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SahaButtonFullParent(
                text: "Thoát",
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        );
      },
    );
  }
}
