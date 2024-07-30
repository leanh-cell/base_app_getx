import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../saha_data_controller.dart';
import 'collaborator_register_request/collaborator_register_request_screen.dart';
import 'commission_ctv/commission_ctv_screen.dart';
import 'history_request_payment/history_request_payment_screen.dart';
import 'list_ctv/list_ctv_screen.dart';
import 'list_request_payment/list_request_payment_screen.dart';
import 'top_ctv/top_ctv_screen.dart';

class CtvScreen extends StatelessWidget {
  SahaDataController sahaDataController = Get.find();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Cộng tác viên'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            itemCTV(
                assets: "assets/icons/grow_up.svg",
                title: "Cấu hình hoa hồng",
                onTap: () {
                  if (sahaDataController
                          .badgeUser.value.decentralization?.collaboratorConfig !=
                      true) {
                    SahaAlert.showError(message: "Bạn không có quyền truy cập");
                    return;
                  }
                  Get.to(() => CommissionCtvScreen());
                }),
            itemCTV(
                assets: "assets/icons/deal.svg",
                title: "Danh sách cộng tác viên",
                onTap: () {
                   if (sahaDataController
                          .badgeUser.value.decentralization?.collaboratorList !=
                      true) {
                    SahaAlert.showError(message: "Bạn không có quyền truy cập");
                    return;
                  }
                  Get.to(() => ListCtvScreen());
                }),
            itemCTV(
                assets: "assets/icons/check_list_new.svg",
                title: "Danh sách yêu cầu thanh toán",
                onTap: () {
                    if (sahaDataController
                          .badgeUser.value.decentralization?.collaboratorPaymentRequestList !=
                      true) {
                    SahaAlert.showError(message: "Bạn không có quyền truy cập");
                    return;
                  }
                  Get.to(() => ListRequestPaymentScreen());
                }),
            itemCTV(
                assets: "assets/icons/history.svg",
                title: "Lịch sử thanh toán",
                onTap: () {
                    if (sahaDataController
                          .badgeUser.value.decentralization?.collaboratorPaymentRequestHistory !=
                      true) {
                    SahaAlert.showError(message: "Bạn không có quyền truy cập");
                    return;
                  }
                  Get.to(() => HistoryRequestPaymentScreen());
                }),
            itemCTV(
                assets: "assets/icons/rank.svg",
                title: "Top Cộng tác viên",
                onTap: () {
                     if (sahaDataController
                          .badgeUser.value.decentralization?.collaboratorTopSale !=
                      true) {
                    SahaAlert.showError(message: "Bạn không có quyền truy cập");
                    return;
                  }
                  Get.to(() => TopCtvScreen());
                }),
            itemCTV(
                assets: "assets/icons/deal_2.svg",
                title: "Yêu cầu làm cộng tác viên",
                onTap: () {
                    if (sahaDataController
                          .badgeUser.value.decentralization?.collaboratorRegister !=
                      true) {
                    SahaAlert.showError(message: "Bạn không có quyền truy cập");
                    return;
                  }
                  Get.to(() => CollaboratorRegisterRequestScreen());
                }),
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
