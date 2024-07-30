import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/decentralization/decentralization_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/model/decentralization.dart';
import '../../../saha_data_controller.dart';
import 'add_decentralization/add_decentralization_screen.dart';
import 'config_decentralizations_controller.dart';
import 'watched_descentralization.dart';

class ConfigDecentralizationScreen extends StatelessWidget {
  ConfigDecentralizationController configDecentralizationController =
      ConfigDecentralizationController();

  SahaDataController sahaDataController = Get.find();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Phân quyền"),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: configDecentralizationController.decentralization
                .map((e) => itemDecentralization(e))
                .toList(),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        color: Colors.white,
        child: Column(
          children: [
            DecentralizationWidget(
              decent: true,
              // sahaDataController
              //         .badgeUser.value.decentralization?.decentralizationAdd ??
              //     false,
              child: SahaButtonFullParent(
                text: "Thêm phân quyền",
                onPressed: () {
                  Get.to(() => AddDecentralizationScreen())!.then((value) => {
                        configDecentralizationController
                            .getListDecentralization(),
                      });
                },
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemDecentralization(Decentralization decentralization) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Phân quyền: ${decentralization.name ?? " "}",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Mô tả: ",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "${decentralization.description ?? ""}",
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DecentralizationWidget(
                    decent: true,

                    // sahaDataController.badgeUser.value.decentralization
                    //         ?.decentralizationUpdate ??
                    //     false,
                    child: InkWell(
                      onTap: () {
                        Get.to(() => AddDecentralizationScreen(
                                  decentralizationInput: decentralization,
                                ))!
                            .then((value) => {
                                  configDecentralizationController
                                      .getListDecentralization(),
                                  sahaDataController.getBadge(),
                                });
                      },
                      child: Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.only(
                            right: 8, left: 8, bottom: 5, top: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(3))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [Text("   Sửa   ")],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  DecentralizationWidget(
                    decent: true,
                    // sahaDataController.badgeUser.value.decentralization
                    //         ?.decentralizationRemove ??
                    //     false,
                    child: InkWell(
                      onTap: () {
                        SahaDialogApp.showDialogYesNo(
                            mess: "Bạn có chắc muốn xoá phân quyền này chứ ?",
                            onOK: () {
                              configDecentralizationController
                                  .deleteDecentralization(decentralization.id!);
                            });
                      },
                      child: Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.only(
                            right: 8, left: 8, bottom: 5, top: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(3))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [Text("   Xoá   ")],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
      ],
    );
  }
}
