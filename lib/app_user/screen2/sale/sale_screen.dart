import 'package:com.ikitech.store/app_user/components/saha_user/decentralization/decentralization_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../saha_data_controller.dart';
import 'commission_sale/commission_sale_screen.dart';
import 'config_sale/config_sale_screen.dart';
import 'history_request_payment/history_request_payment_screen.dart';
import 'list_ctv/list_ctv_screen.dart';
import 'list_request_payment/list_request_payment_screen.dart';
import 'list_sale/list_sale_screen.dart';
import 'top_ctv/top_ctv_screen.dart';
import 'top_sale/top_sale_screen.dart';

class SaleScreen extends StatelessWidget {
  SahaDataController sahaDataController = Get.find();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Sale'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DecentralizationWidget(
              decent: sahaDataController.badgeUser.value.decentralization?.saleConfig ?? false,
              child: itemCTV(
                  assets: "assets/icons/admin.svg",
                  title: "Cấu hình sale",
                  onTap: () {
                    Get.to(() => ConfigSaleScreen());
                  }),
            ),
            // itemCTV(
            //     assets: "assets/icons/gift_color.svg",
            //     title: "Cấu hình thưởng",
            //     onTap: () {
            //       Get.to(() => CommissionSaleScreen());
            //     }),
            DecentralizationWidget(
              decent: sahaDataController.badgeUser.value.decentralization?.saleList ?? false,
              child: itemCTV(
                  assets: "assets/icons/estate-agent.svg",
                  title: "Danh sách sale",
                  onTap: () {
                    Get.to(() => ListSaleScreen());
                  }),
            ),
            DecentralizationWidget(
              decent: sahaDataController.badgeUser.value.decentralization?.saleTop ?? false,
              child: itemCTV(
                  assets: "assets/icons/rank.svg",
                  title: "Top sale",
                  onTap: () {
                    Get.to(() => TopSaleScreen());
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemCTV(
      {required String assets,
      required String title,
      required Function onTap}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  assets,
                  height: 30,
                  width: 30,
                ),
              ),
              Text(title),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
              )
            ],
          ),
          Divider(
            height: 1,
          )
        ],
      ),
    );
  }
}
