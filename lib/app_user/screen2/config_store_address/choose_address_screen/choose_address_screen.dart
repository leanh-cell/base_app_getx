import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'choose_address_controller.dart';

enum TypeAddress {
  Province,
  District,
  Wards,
}

class ChooseAddressScreen extends StatelessWidget {
  final TypeAddress? typeAddress;
  final idProvince;
  final idDistrict;
  final Function? callback;

  late ChooseAddressController chooseAddressController;

  ChooseAddressScreen(
      {Key? key,
      this.typeAddress,
      this.idProvince,
      this.idDistrict,
      this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    chooseAddressController =
        new ChooseAddressController(typeAddress, idProvince, idDistrict);

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(chooseAddressController.nameTitleAppbar.value)),
      ),
      body: Obx(
        () => ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: chooseAddressController.listLocationAddress.value.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                callback!(
                    chooseAddressController.listLocationAddress.value[index]);
                Get.back();
              },
              child: ListTile(
                title: Text(
                  chooseAddressController.listLocationAddress.value[index].name!,
                  style: TextStyle(fontSize: 14),
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
    );
  }
}
