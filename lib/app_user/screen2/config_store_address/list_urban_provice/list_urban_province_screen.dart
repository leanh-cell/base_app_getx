import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/saha_user/button/saha_button.dart';
import '../../../model/location_address.dart';
import 'list_urban_province_controller.dart';

class ListUrbanProvinceScreen extends StatelessWidget {
  List<LocationAddress> listInput;

  ListUrbanProvinceScreen({required this.listInput}) {
    listUrbanProvinceController =
        ListUrbanProvinceController(listInput: listInput);
  }

  late ListUrbanProvinceController listUrbanProvinceController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách các tỉnh"),
      ),
      body: Obx(
        () => ListView.separated(

          itemCount: listUrbanProvinceController.listLocationAddress.length,
          itemBuilder: (BuildContext context, int index) {
            var item = listUrbanProvinceController.listLocationAddress[index];
            return InkWell(
              onTap: () {
                if (listUrbanProvinceController.listLocationAddressChoose
                    .map((e) => e.id)
                    .contains(item.id)) {
                  listUrbanProvinceController.listLocationAddressChoose
                      .removeWhere((e) => e.id == item.id);
                } else {
                  listUrbanProvinceController.listLocationAddressChoose
                      .add(item);
                }
              },
              child: Obx(
                () => Container(
                  color: listUrbanProvinceController.listLocationAddressChoose
                          .map((e) => e.id)
                          .contains(item.id)
                      ? Colors.red.withOpacity(0.1)
                      : null,
                  child: ListTile(
                    title: Row(
                      children: [
                        Text(
                          item.name!,
                          style: TextStyle(fontSize: 14),
                        ),
                        Spacer(),
                        listUrbanProvinceController.listLocationAddressChoose
                                .map((e) => e.id)
                                .contains(item.id)
                            ? Icon(
                                Icons.check,
                                color: Theme.of(context).primaryColor,
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              height: 1,
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        color: Colors.white,
        child: Column(
          children: [
            SahaButtonFullParent(
              text: "LƯU",
              onPressed: () {
                Get.back(
                    result:
                        listUrbanProvinceController.listLocationAddressChoose);
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
