import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/model/e_commerce.dart';
import 'package:com.ikitech.store/app_user/screen2/config/e-commerce/shop_detail/shop_detail_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../components/saha_user/button/saha_button.dart';

class ShopDetailScreen extends StatefulWidget {
  ShopDetailScreen({Key? key, required this.eCommerce}) {
    shopDetailController = ShopDetailController(eCommerce: eCommerce);
  }
  final ECommerce eCommerce;
  late ShopDetailController shopDetailController;

  @override
  State<ShopDetailScreen> createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('Cập nhật thông tin'),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                item(
                    'Nền tảng',
                    widget.shopDetailController.eCommerceReq.value.platform ??
                        'Chưa có thông tin'),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Text(
                            'Tên shop',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: widget.shopDetailController.shopName,
                              onChanged: (v) {
                                widget.shopDetailController.eCommerceReq.value
                                    .shopName = v;
                              },
                              validator: (value) {
                                if (value!.length < 1) {
                                  return 'Chưa nhập tên shop';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText: "Nhập tên shop tại đây",
                              ),
                              style: TextStyle(fontSize: 14),
                              minLines: 1,
                              maxLines: 1,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Text(
                            'Tên khách hàng',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller:
                                  widget.shopDetailController.customerName,
                              onChanged: (v) {
                                widget.shopDetailController.eCommerceReq.value
                                    .customerName = v;
                              },
                              // validator: (value) {
                              //   if (value!.length < 1) {
                              //     return 'Chưa nhập tên khách hàng';
                              //   }
                              //   return null;
                              // },
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText: "Nhập tên khách hàng tại đây",
                              ),
                              style: TextStyle(fontSize: 14),
                              minLines: 1,
                              maxLines: 1,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Text(
                            'Số điện thoại',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: widget
                                  .shopDetailController.customerPhoneNumber,
                              onChanged: (v) {
                                widget.shopDetailController.eCommerceReq.value
                                    .customerPhone = v;
                              },
                              // validator: (value) {
                              //   if (value!.length < 1) {
                              //     return 'Chưa nhập số điện thoại';
                              //   }
                              //   return null;
                              // },
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText: "Nhập số điện thoại tại đây",
                              ),
                              style: TextStyle(fontSize: 14),
                              minLines: 1,
                              maxLines: 1,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                item('Hạn token',
                    '${DateFormat('HH:mm').format(widget.shopDetailController.eCommerceReq.value.expiryToken ?? DateTime.now())} || ${DateFormat('dd-MM-yyyy').format(widget.shopDetailController.eCommerceReq.value.expiryToken ?? DateTime.now())}'),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Đồng bộ sản phẩm',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      DropdownButton(
                        value: widget.shopDetailController.dropDown1,
                        onChanged: (String? v) {
                          setState(() {
                            widget.shopDetailController.dropDown1 = v!;
                          });
                          if (v == 'Thủ công') {
                            widget.shopDetailController.eCommerceReq.value
                                .typeSyncProducts = 0;
                          } else {
                            widget.shopDetailController.eCommerceReq.value
                                .typeSyncProducts = 1;
                          }
                        },
                        items: widget.shopDetailController.list1
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                widget.eCommerce.platform == "TIKI"
                    ? Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(8),
                        width: Get.width,
                        child: Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...widget.shopDetailController.listWereHouse
                                  .map((e) => Container(
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(e.name ?? ''),
                                                  Text(
                                                      'Địa chỉ: ${e.address ?? ''}')
                                                ],
                                              ),
                                            ),
                                            CupertinoSwitch(
                                                value: e.allowSync ?? false,
                                                onChanged: (v) {
                                                  if ((e.allowSync ?? false) ==
                                                      true) {
                                                    widget.shopDetailController
                                                        .updateWarehouses(
                                                            warehouseId: e.id!,
                                                            allowSync: false);
                                                  } else {
                                                    widget.shopDetailController
                                                        .updateWarehouses(
                                                            warehouseId: e.id!,
                                                            allowSync: true);
                                                  }
                                                })
                                          ],
                                        ),
                                      ))
                                  .toList()
                            ],
                          ),
                        ),
                      )
                    : Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Đồng bộ tồn kho',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            DropdownButton(
                              value: widget.shopDetailController.dropDown2,
                              onChanged: (String? v) {
                                setState(() {
                                  widget.shopDetailController.dropDown2 = v!;
                                });
                                if (v == 'Thủ công') {
                                  widget.shopDetailController.eCommerceReq.value
                                      .typeSyncProducts = 0;
                                } else {
                                  widget.shopDetailController.eCommerceReq.value
                                      .typeSyncProducts = 1;
                                }
                              },
                              items: widget.shopDetailController.list1
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Đồng bộ đơn hàng',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      DropdownButton(
                        value: widget.shopDetailController.dropDown3,
                        onChanged: (String? v) {
                          setState(() {
                            widget.shopDetailController.dropDown3 = v!;
                          });
                          if (v == 'Thủ công') {
                            widget.shopDetailController.eCommerceReq.value
                                .typeSyncOrders = 0;
                          } else {
                            widget.shopDetailController.eCommerceReq.value
                                .typeSyncOrders = 1;
                          }
                        },
                        items: widget.shopDetailController.list3
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    SahaDialogApp.showDialogYesNo(
                        mess: 'Bạn có đồng ý huỷ kết nối sàn không ?',
                        onOK: () {
                          widget.shopDetailController.deleteCommerce();
                        });
                  },
                  child: Text('Huỷ kết nối'),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 80,
          child: Column(
            children: [
              SahaButtonFullParent(
                text: "Cập nhật thông tin",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.shopDetailController.updateECommerce();
                  }
                },
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget item(String title, String subTitle) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(subTitle),
        ],
      ),
    );
  }
}
