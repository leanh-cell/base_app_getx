import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../const/banner_ads_define.dart';

class DialogBannerAds {
  static void showPosition({int? positionInput,required Function onTap}) {
    var listPosition = [0, 1, 2, 3, 4];
    showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Chọn vị trí banner",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 1,
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    ...listPosition
                        .map(
                          (e) => Column(
                        children: [
                          ListTile(
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${mapDefinePosition[e]}",
                                  ),
                                ),
                              ],
                            ),
                            onTap: () async {
                              onTap(e);
                            },
                            trailing: positionInput == e
                                ? Icon(
                              Icons.check,
                              color: Theme.of(context).primaryColor,
                            )
                                : null,
                          ),
                          Divider(
                            height: 1,
                          ),
                        ],
                      ),
                    )
                        .toList(),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        });
  }

  static void showTypeAction({String? typeActionInput,required Function onTap}) {
    var listTypeConfig = [
      "LINK",
      "PRODUCT",
      "CATEGORY_PRODUCT",
      "POST",
      "CATEGORY_POST",
    ];
    showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Chọn kiểu chuyển hướng",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 1,
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    ...listTypeConfig
                        .map(
                          (e) => Column(
                        children: [
                          ListTile(
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${mapDefineTypeAction[e]}",
                                  ),
                                ),
                              ],
                            ),
                            onTap: () async {
                              onTap(e);
                            },
                            trailing: typeActionInput == e
                                ? Icon(
                              Icons.check,
                              color: Theme.of(context).primaryColor,
                            )
                                : null,
                          ),
                          Divider(
                            height: 1,
                          ),
                        ],
                      ),
                    )
                        .toList(),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        });
  }
}
