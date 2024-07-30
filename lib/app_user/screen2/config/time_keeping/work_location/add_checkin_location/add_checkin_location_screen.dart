import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/model/checkin_location.dart';

import 'add_checkin_location_controller.dart';

class AddCheckInLocationScreen extends StatelessWidget {
  CheckInLocation? checkInLocationInput;

  AddCheckInLocationScreen({this.checkInLocationInput}) {
    addCheckInLCTController = AddCheckInLocationController(
        checkInLocationInput: checkInLocationInput);
  }

  late AddCheckInLocationController addCheckInLCTController;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Thêm địa điểm"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Obx(
            () => Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.location_city_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    Form(
                      key: _formKey,
                      child: Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: "Tên địa điểm",
                          ),
                          validator: (value) {
                            if (value!.length == 0) {
                              return 'Không được để trống';
                            }
                            return null;
                          },
                          controller:
                              addCheckInLCTController.nameEditingController,
                          onChanged: (v) {
                            addCheckInLCTController.checkInLocation.value.name =
                                v;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Icon(Icons.wifi),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "${addCheckInLCTController.checkInLocation.value.wifiName ?? ""}"),
                        Text(
                          "Tên Wifi",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Icon(Icons.router_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "${addCheckInLCTController.checkInLocation.value.wifiMac ?? ""}"),
                        Text(
                          "Địa chỉ MAC Router",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Divider(
                  height: 1,
                ),
                SizedBox(
                  height: 30,
                ),
                if (checkInLocationInput != null)
                  Divider(
                    height: 1,
                  ),
                if (checkInLocationInput != null)
                  InkWell(
                    onTap: () {
                      SahaDialogApp.showDialogYesNo(
                          mess: "Bạn có chắc chắn muốn xoá địa điểm này chứ?",
                          onOK: () {
                            addCheckInLCTController.deleteCheckInLocation();
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Xoá địa điểm"),
                        ],
                      ),
                    ),
                  ),
                if (checkInLocationInput != null)
                  Divider(
                    height: 1,
                  ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        color: Colors.white,
        child: Column(
          children: [
            SahaButtonFullParent(
              text: "Lưu",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (checkInLocationInput != null) {
                    addCheckInLCTController.updateCheckInLocation();
                  } else {
                    addCheckInLCTController.addCheckInLocation();
                  }
                }
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
