import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/screen2/config_store_address/login_shipping_company/login_shipping_company_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/model/shipment.dart';

import 'add_token_controller.dart';

class InputTokenShipmentScreen extends StatelessWidget {
  Shipment? shipment;

  late AddTokenShipment addTokenShipment;

  InputTokenShipmentScreen({this.shipment}) {
    addTokenShipment = AddTokenShipment(shipment: shipment);
    addTokenShipment.tokenEditingController.value.text =
        shipment?.shipperConfig?.token ?? "";
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Cài đặt nhà vận chuyển"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            //Text("Nhập token nhà vận chuyển :"),
            Container(
              padding: EdgeInsets.all(10),
              //height: 50,
              child: Row(
                children: [
                  Container(
                    height: 25,
                    width: 25,
                    child: Icon(Icons.money),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      enabled: (shipment?.id == 0 && shipment?.id == 1) ? true : false,
                      controller: addTokenShipment.tokenEditingController.value,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: "Nhập token nhà vận chuyển",
                      ),
                      style: TextStyle(fontSize: 15),
                      minLines: 1,
                      maxLines: 1,
                      onChanged: (v) {
                        addTokenShipment.tokenEditingController.refresh();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        child: Column(
          children: [
            if(shipment?.id == 0 || shipment?.id == 1)
            SahaButtonFullParent(
              text: "Bật",
              onPressed: () {
                if (addTokenShipment.tokenEditingController.value.text == "") {
                  SahaAlert.showError(message: "Bạn chưa nhập token");
                  return;
                }
                addTokenShipment.addTokenShipment();
              },
            ),
            if(shipment?.id != 0 && shipment?.id != 1)
            SahaButtonFullParent(
              text: "Đăng nhập tài khoản khác",
              onPressed: (){
               
                Get.to(()=>LoginShippingCompanyScreen(shipment: shipment ?? Shipment(),))!.then((value) =>
                          Get.back());
              },
            )
          ],
        ),
      ),
    );
  }
}
