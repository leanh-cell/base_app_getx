import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/decentralization/decentralization_widget.dart';
import 'package:com.ikitech.store/app_user/screen2/config/calculate/time_keeping_calculate_screen.dart';
import 'package:com.ikitech.store/saha_data_controller.dart';
import 'package:ionicons/ionicons.dart';

import 'revenue_exdipenture/accountant_screen.dart';

class AccountantMainScreen extends StatelessWidget {
  SahaDataController sahaDataController = Get.find();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Kế toán"),
      ),
      body: Column(
        children: [
          DecentralizationWidget(
            decent: sahaDataController
                    .badgeUser.value.decentralization?.revenueExpenditure ??
                false,
            child: itemBody(
                Icon(Ionicons.calculator,
                    color: Theme.of(context).primaryColor),
                "Thu chi", () {
              Get.to(() => AccountantScreen());
            }),
          ),
          DecentralizationWidget(
            decent: sahaDataController
                    .badgeUser.value.decentralization?.timekeeping ??
                false,
            child: itemBody(
                Icon(Ionicons.calendar_outline,
                    color: Theme.of(context).primaryColor),
                "Bảng công", () {
              Get.to(() => TimeKeepingCalculateScreen(isAccountant: true,));
            }),
          ),
        ],
      ),
    );
  }

  Widget itemBody(Icon icon, String text, Function onTap) {
    return ListTile(
      leading: icon,
      title: Text(
        text,
        style: TextStyle(fontSize: 15),
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
