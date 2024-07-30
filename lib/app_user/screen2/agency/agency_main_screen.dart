import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/decentralization/decentralization_widget.dart';
import '../../../saha_data_controller.dart';
import 'agency_config/history_request_payment/history_request_payment_screen.dart';
import 'agency_config/list_agencys/list_agency_screen.dart';
import 'agency_config/list_request_payment/list_request_payment_screen.dart';
import 'agency_config/reward_agency/reward_agency_screen.dart';
import 'agency_config/top_agency/top_agency_screen.dart';
import 'agency_request_register/agency_request_register_screen.dart';
import 'commission_agency/commission_agency_screen.dart';
import 'list_agency_type/list_agency_type_screen.dart';
import 'top_rose/top_rose_screen.dart';

class AgencyMainScreen extends StatelessWidget {
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
            SizedBox(
              height: 10,
            ),
            DecentralizationWidget(
              decent: sahaDataController
                      .badgeUser.value.decentralization?.agencyList ??
                  false,
              child: itemCTV(
                  assets: "assets/icons/agency2.svg",
                  title: "Danh sách đại lý",
                  onTap: () {
                    Get.to(() => ListAgencyScreen());
                  }),
            ),
            DecentralizationWidget(
              decent: sahaDataController
                      .badgeUser.value.decentralization?.agencyConfig ??
                  false,
              child: itemCTV(
                  assets: "assets/icons/admin.svg",
                  title: "Cấu hình đại lý",
                  onTap: () {
                    Get.to(() => ListAgencyTypeScreen());
                  }),
            ),
            DecentralizationWidget(
              decent: sahaDataController
                      .badgeUser.value.decentralization?.agencyBonusProgram ??
                  false,
              child: itemCTV(
                  assets: "assets/icons/gift_color.svg",
                  title: "Thưởng đại lý",
                  onTap: () {
                    Get.to(() => RewardAgencyScreen());
                  }),
            ),
            DecentralizationWidget(
              decent: sahaDataController
                      .badgeUser.value.decentralization?.agencyRegister ??
                  false,
              child: itemCTV(
                  assets: "assets/icons/deal_2.svg",
                  title: "Yêu cầu làm đại lý",
                  onTap: () {
                    Get.to(() => AgencyRequestRegisterScreen());
                  }),
            ),
            Container(
              height: 8,
              color: Colors.grey[200],
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Nhập hàng',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        DecentralizationWidget(
                          decent: sahaDataController.badgeUser.value
                                  .decentralization?.agencyTopImport ??
                              false,
                          child: itemCTV(
                              assets: "assets/icons/rank.svg",
                              title: "Top đại lý",
                              onTap: () {
                                Get.to(() => TopAgencyScreen());
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hoa hồng',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        DecentralizationWidget(
                          decent: sahaDataController.badgeUser.value
                                  .decentralization?.agencyConfig ??
                              false,
                          child: itemCTV(
                              assets: "assets/icons/admin.svg",
                              title: "Cấu hình hoa hồng",
                              onTap: () {
                                Get.to(() => CommissionAgencyScreen());
                              }),
                        ),
                        DecentralizationWidget(
                          decent: sahaDataController.badgeUser.value
                                  .decentralization?.agencyTopCommission ??
                              false,
                          child: itemCTV(
                              assets: "assets/icons/rank.svg",
                              title: "Top hoa hồng đại lý",
                              onTap: () {
                                Get.to(() => TopAgencyScreen(
                                      isCtv: true,
                                    ));
                              }),
                        ),
                        DecentralizationWidget(
                          decent: sahaDataController.badgeUser.value
                                  .decentralization?.agencyPaymentRequestList ??
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
                                  .badgeUser
                                  .value
                                  .decentralization
                                  ?.agencyPaymentRequestHistory ??
                              false,
                          child: itemCTV(
                              assets: "assets/icons/history.svg",
                              title: "Lịch sử thanh toán",
                              onTap: () {
                                Get.to(
                                    () => HistoryRequestPaymentAgencyScreen());
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
