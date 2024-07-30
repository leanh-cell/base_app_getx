import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';

import 'history_order_controller.dart';
import 'order_detail_manage/order_detail_manage_screen.dart';
import 'widget/order_item_widget.dart';

class HistoryOrderScreen extends StatelessWidget {
  late HistoryOrderController historyOrderController;
  String phoneNumber;
  HistoryOrderScreen({required this.phoneNumber}) {
    historyOrderController = HistoryOrderController(phoneNumber: phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Lịch sử mua hàng"),
      ),
      body: Obx(
        () => historyOrderController.isLoadInit.value
            ? SahaLoadingFullScreen()
            : historyOrderController.listOrder.isEmpty
                ? Center(
                    child: Text("Không có lịch sử mua hàng nào"),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        ...List.generate(
                          historyOrderController.listOrder.length,
                          (index) => OrderItemWidget(
                            order: historyOrderController.listOrder[index],
                            onTap: () {

                            },
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
