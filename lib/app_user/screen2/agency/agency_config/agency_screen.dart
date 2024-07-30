import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/decentralization/decentralization_widget.dart';
import '../../../../saha_data_controller.dart';
import 'commission_agency/commission_agency_screen.dart';
import 'history_request_payment/history_request_payment_screen.dart';
import 'list_request_payment/list_request_payment_screen.dart';

class AgencyScreen extends StatelessWidget {
  SahaDataController sahaDataController = Get.find();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Đại lý'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DecentralizationWidget(
              decent: sahaDataController
                      .badgeUser.value.decentralization?.collaboratorConfig ??
                  false,
              child: itemCTV(
                  assets: "assets/icons/grow_up.svg",
                  title: "Cấu hình doanh số",
                  onTap: () {
                    Get.to(() => CommissionAgencyScreen());
                  }),
            ),

            DecentralizationWidget(
              decent: sahaDataController
                  .badgeUser.value.decentralization?.collaboratorPaymentRequestList ??
                  false,
              child: itemCTV(
                  assets: "assets/icons/check_list_new.svg",
                  title: "Danh sách yêu cầu thanh toán",
                  onTap: () {
                    Get.to(() => ListRequestPaymentAgencyScreen());
                  }),
            ),
            DecentralizationWidget(
              decent: sahaDataController
                  .badgeUser.value.decentralization?.collaboratorPaymentRequestHistory ??
                  false,
              child: itemCTV(
                  assets: "assets/icons/history.svg",
                  title: "Lịch sử yêu cầu thanh toán",
                  onTap: () {
                    Get.to(() => HistoryRequestPaymentAgencyScreen());
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
