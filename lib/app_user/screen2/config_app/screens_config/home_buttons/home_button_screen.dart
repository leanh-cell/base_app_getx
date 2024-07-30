import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/const/constant.dart';
import 'package:reorderables/reorderables.dart';
import 'button_config.dart';
import 'home_button_config_controller.dart';

class ButtonHomeConfigScreen extends StatefulWidget {
  @override
  _ButtonHomeConfigScreenState createState() => _ButtonHomeConfigScreenState();
}

class _ButtonHomeConfigScreenState extends State<ButtonHomeConfigScreen> {
  late Color _color;
  late Color _colorBrighter;

  @override
  void initState() {
    super.initState();
    _color = Colors.black87;
    _colorBrighter = Colors.red;
  }

  ScrollController scrollController = ScrollController();
  HomeButtonConfigController homeButtonConfigController =
      HomeButtonConfigController();

  @override
  Widget build(BuildContext context) {
    void _onReorder(int oldIndex, int newIndex) {
      homeButtonConfigController.changeIndex(oldIndex, newIndex);
    }

    var wrap = Obx(() => Center(
          child: PrimaryScrollController(
            controller: scrollController,
            child: ReorderableWrap(
                spacing: 0.0,
                runSpacing: 0.0,
                padding: const EdgeInsets.all(0),
                children: homeButtonConfigController.currentButtonCfs
                    .map((button) => ButtonEditWidget(
                          isShow: true,
                          homeButton: button,
                          onRemove: () {
                            homeButtonConfigController.removeButton(button);
                          },
                        ))
                    .toList(),
                onReorder: _onReorder),
          ),
        ));

    var column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                "Đang hiển thị",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  SahaDialogApp.showDialogYesNo(
                      mess: "Bạn muốn khôi phục các nút về danh sách mặc định?",
                      onOK: () {
                        homeButtonConfigController.onReset();
                      });
                },
                child: Text(
                  "Khôi phục mặc định",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  homeButtonConfigController.onSave();
                },
                child: Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: SahaPrimaryColor),
                  child: Row(
                    children: [
                      Icon(
                        Icons.save,
                        size: 15,
                        color: Colors.white,
                      ),
                      Text(
                        "Lưu",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        wrap,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Thêm nút",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Obx(
          () => Container(
            width: Get.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: homeButtonConfigController.listButton.map(
                  (e) {
                    var index =
                        homeButtonConfigController.listButton.indexOf(e);
                    return MaterialButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        homeButtonConfigController.pageType.value = index;
                      },
                      child: Container(
                        height: 35,
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.only(left: 8, right: 8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: index ==
                                    homeButtonConfigController.pageType.value
                                ? SahaPrimaryColor
                                : Colors.grey.withOpacity(0.3)),
                        child: Text(
                          e.name,
                          style: TextStyle(
                              color: index ==
                                      homeButtonConfigController.pageType.value
                                  ? Colors.white
                                  : Colors.black54.withOpacity(0.7),
                              fontWeight: index ==
                                      homeButtonConfigController.pageType.value
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
        ),
        Obx(
          () => Container(
            child: Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: homeButtonConfigController
                  .listButton[homeButtonConfigController.pageType.value]
                  .listButton
                  .map((button) => ButtonEditWidget(
                        homeButton: button,
                        isShow: false,
                        added: homeButtonConfigController.hasInListShow(button),
                        onAdd: () {
                          homeButtonConfigController.addButton(button);
                        },
                      ))
                  .toList(),
            ),
          ),
        )
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Tùy chỉnh nút điều hướng"),
      ),
      body: Obx(
        () => Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                child: column,
              ),
            ),
            homeButtonConfigController.waitingSave.value
                ? Center(
                    child: SahaLoadingWidget(),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
