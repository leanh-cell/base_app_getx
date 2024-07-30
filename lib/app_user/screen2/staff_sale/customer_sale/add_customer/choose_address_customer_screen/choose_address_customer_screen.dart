import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'choose_address_customer_controller.dart';

class ChooseAddressCustomerScreen extends StatelessWidget {
  final TypeAddress? typeAddress;
  final idProvince;
  final idDistrict;
  final Function? callback;

  late ChooseAddressCustomerController chooseAddressCustomerController;

  ChooseAddressCustomerScreen(
      {Key? key,
      this.typeAddress,
      this.idProvince,
      this.idDistrict,
      this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    chooseAddressCustomerController = new ChooseAddressCustomerController(
        typeAddress, idProvince, idDistrict);

    return Scaffold(
      appBar: AppBar(
        title: Obx(() =>
            chooseAddressCustomerController.notEnteredProvince.value
                ? Text("Chưa chọn địa chỉ Tỉnh/Thành Phố")
                : Text(chooseAddressCustomerController.nameTitleAppbar.value)),
      ),
      body: Obx(
        () => chooseAddressCustomerController.notEnteredProvince.value
            ? Container(
                height: Get.height,
                width: Get.width,
                child: Center(
                  child: Text("Chưa chọn địa chỉ Tỉnh/Thành Phố"),
                ),
              )
            :chooseAddressCustomerController.isLoadingAddress.value == true ? SahaLoadingFullScreen() : ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: chooseAddressCustomerController
                    .listLocationAddress.value.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      callback!(chooseAddressCustomerController
                          .listLocationAddress.value[index]);
                      Get.back();
                    },
                    child: ListTile(
                      title: Text(
                        chooseAddressCustomerController
                            .listLocationAddress.value[index].name!,
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
