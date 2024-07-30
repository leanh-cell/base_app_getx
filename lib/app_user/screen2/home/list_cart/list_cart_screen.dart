import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/model/cart_info.dart';

import 'list_cart_controller.dart';

class ListCartScreen extends StatelessWidget {
  ListCartController listCartController = ListCartController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách đơn lưu tạm"),
      ),
      body: Obx(
        () => listCartController.listCart.isEmpty
            ? Center(child: Text("Chưa có đơn lưu tạm"))
            : SingleChildScrollView(
                child: Column(
                  children: listCartController.listCart
                      .map((e) => itemCart(e))
                      .toList(),
                ),
              ),
      ),
    );
  }

  Widget itemCart(CartInfo cartInfo) {
    return InkWell(
      onTap: () {
        Get.back(result: {'cart_info': cartInfo, 'has_click': true});
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Text("${cartInfo.name ?? "Giỏ hàng mặc định"}"),
              ),
              Spacer(),
              Row(
                children: [
                    IconButton(
                      onPressed: () {
                        SahaDialogApp.showDialogInputText(title: "Đổi tên", textButton: "Xác nhận", textInput: cartInfo.name,onDone: (v){
                          listCartController.changeNameCart(idCart: cartInfo.id!, name: v);
                          Get.back();
                        });
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.grey,
                      )),
                  IconButton(
                      onPressed: () {
                        SahaDialogApp.showDialogYesNo(
                            mess:
                                "Bạn có chắc chắn muốn xoá đơn lưu tạm này không?",
                            onOK: () {
                              listCartController.deleteCart(cartInfo.id!);
                            });
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.grey,
                      )),
                ],
              )
            ],
          ),
          Divider(
            height: 1,
          ),
        ],
      ),
    );
  }
}
