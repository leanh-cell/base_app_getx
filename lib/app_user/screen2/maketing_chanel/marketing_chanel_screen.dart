import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/decentralization/decentralization_widget.dart';

import '../../../saha_data_controller.dart';
import 'bonus_product/bonus_product_screen.dart';
import 'my_combo/my_combo_screen.dart';
import 'my_program/my_program_screen.dart';
import 'my_voucher/my_voucher_screen.dart';

class MarketingChanelScreen extends StatelessWidget {
  SahaDataController sahaDataController = Get.find();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Chương trình khuyến mãi'),
      ),
      body: Column(
        children: [
          Container(
            height: 8,
            color: Colors.grey[200],
          ),
          DecentralizationWidget(
            decent: sahaDataController
                            .badgeUser.value.decentralization?.promotionDiscountList ??
                        false,
            child: InkWell(
              onTap: () {
                Get.to(() => MyProgram());
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.card_giftcard_rounded,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Giảm giá sản phẩm")
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios_rounded)
                  ],
                ),
              ),
            ),
          ),
          Divider(
            height: 1,
          ),
          DecentralizationWidget(
            decent:sahaDataController
                            .badgeUser.value.decentralization?.promotionVoucherList ??
                        false,
            child: InkWell(
              onTap: () {
                Get.to(() => MyVoucherScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.wysiwyg_sharp,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Mã voucher giảm giá")
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios_rounded)
                  ],
                ),
              ),
            ),
          ),
          Divider(
            height: 1,
          ),
          DecentralizationWidget(
            decent: sahaDataController
                            .badgeUser.value.decentralization?.promotionComboList ??
                        false,
            child: InkWell(
              onTap: () {
                Get.to(() => MyComboScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.assignment_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Combo sản phẩm khuyến mãi")
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios_rounded)
                  ],
                ),
              ),
            ),
          ),
          Divider(
            height: 1,
          ),
          DecentralizationWidget(
            decent: sahaDataController
                            .badgeUser.value.decentralization?.promotionBonusProductList ??
                        false,
            child: InkWell(
              onTap: () {
                Get.to(() => BonusProductScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.assignment_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Tặng thưởng sản phẩm ")
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios_rounded)
                  ],
                ),
              ),
            ),
          ),
          Divider(
            height: 1,
          ),
        ],
      ),
    );
  }
}
