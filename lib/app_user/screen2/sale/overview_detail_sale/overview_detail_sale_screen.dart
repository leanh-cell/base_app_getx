import 'package:com.ikitech.store/app_user/data/remote/response-request/sale/over_view_sale_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/step_bonus.dart';
import '../../../utils/string_utils.dart';

class OverViewDetailSaleScreen extends StatelessWidget {
  OverViewSale overViewSale;

  OverViewDetailSaleScreen({required this.overViewSale});

  var type = 0.obs;

  @override
  Widget build(BuildContext context) {
    type.value = overViewSale.saleConfig?.typeBonusPeriod ?? 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('Tổng quan'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  type.value = 0;
                },
                child: Container(
                  width: Get.width / 4.5,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 3,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                  child: Center(
                    child: Obx(
                      () => Text(
                        'Tháng',
                        style: TextStyle(
                          color: type.value == 0
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                          fontSize: type.value == 0 ? 17 : 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  type.value = 1;
                },
                child: Container(
                  width: Get.width / 4.5,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 3,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                  child: Center(
                    child: Obx(
                      () => Text(
                        'Tuần',
                        style: TextStyle(
                          color: type.value == 1
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                          fontSize: type.value == 1 ? 17 : 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  type.value = 2;
                },
                child: Container(
                  width: Get.width / 4.5,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 3,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                  child: Center(
                      child: Obx(
                    () => Text(
                      'Quý',
                      style: TextStyle(
                        color: type.value == 2
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                        fontSize: type.value == 2 ? 17 : 14,
                      ),
                    ),
                  )),
                ),
              ),
              InkWell(
                onTap: () {
                  type.value = 3;
                },
                child: Container(
                  width: Get.width / 4.5,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 3,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                  child: Center(
                      child: Obx(
                    () => Text(
                      'Năm',
                      style: TextStyle(
                        color: type.value == 3
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                        fontSize: type.value == 3 ? 17 : 14,
                      ),
                    ),
                  )),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Obx(
              () => SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        itemReport(
                            title: 'Tổng doanh số',
                            icon: Icon(
                              Icons.bar_chart,
                              color: Colors.red,
                            ),
                            number: (overViewSale.totalFinal ?? 0).toString()),
                        itemReport(
                            title: 'Tổng đơn',
                            icon: Icon(
                              Icons.list_alt_rounded,
                              color: Colors.red,
                            ),
                            number: (overViewSale.totalOrder ?? 0).toString()),
                      ],
                    ),
                    Row(
                      children: [
                        itemReport(
                            title: 'Doanh thu ngày',
                            icon: Icon(
                              Icons.bar_chart,
                              color: Colors.blue,
                            ),
                            number:
                                (overViewSale.totalFinalInDay ?? 0).toString()),
                        itemReport(
                            title: 'Tổng đơn ngày',
                            icon: Icon(
                              Icons.list_alt_rounded,
                              color: Colors.teal,
                            ),
                            number: (overViewSale.countInDay ?? 0).toString()),
                      ],
                    ),
                    if (type.value == 0)
                      Row(
                        children: [
                          itemReport(
                              title: 'Doanh thu tháng',
                              icon: Icon(
                                Icons.bar_chart,
                                color: Colors.blue,
                              ),
                              number: (overViewSale.totalFinalInMonth ?? 0)
                                  .toString()),
                          itemReport(
                              title: 'Tổng đơn tháng',
                              icon: Icon(
                                Icons.list_alt_rounded,
                                color: Colors.teal,
                              ),
                              number:
                                  (overViewSale.countInMonth ?? 0).toString()),
                        ],
                      ),
                    if (type.value == 1)
                      Row(
                        children: [
                          itemReport(
                              title: 'Doanh thu tuần',
                              icon: Icon(
                                Icons.bar_chart,
                                color: Colors.blue,
                              ),
                              number: (overViewSale.totalFinalInWeek ?? 0)
                                  .toString()),
                          itemReport(
                              title: 'Tổng đơn tuần',
                              icon: Icon(
                                Icons.list_alt_rounded,
                                color: Colors.teal,
                              ),
                              number:
                                  (overViewSale.countInWeek ?? 0).toString()),
                        ],
                      ),
                    if (type.value == 2)
                      Row(
                        children: [
                          itemReport(
                              title: 'Doanh thu quý',
                              icon: Icon(
                                Icons.bar_chart,
                                color: Colors.blue,
                              ),
                              number: (overViewSale.totalFinalInQuarter ?? 0)
                                  .toString()),
                          itemReport(
                              title: 'Tổng đơn quý',
                              icon: Icon(
                                Icons.list_alt_rounded,
                                color: Colors.teal,
                              ),
                              number: (overViewSale.countInQuarter ?? 0)
                                  .toString()),
                        ],
                      ),
                    if (type.value == 3)
                      Row(
                        children: [
                          itemReport(
                              title: 'Doanh thu năm',
                              icon: Icon(
                                Icons.bar_chart,
                                color: Colors.blue,
                              ),
                              number: (overViewSale.totalFinalInYear ?? 0)
                                  .toString()),
                          itemReport(
                              title: 'Tổng đơn năm',
                              icon: Icon(
                                Icons.list_alt_rounded,
                                color: Colors.teal,
                              ),
                              number: (overViewSale.countInYear ?? 0)
                                  .toString()),
                        ],
                      ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF5F6F9),
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  "packages/sahashop_customer/assets/icons/gift_fill.svg",

                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  "THƯỞNG THEO MỨC DOANH THU ${getText(overViewSale.saleConfig?.typeBonusPeriod ?? 0).toUpperCase()}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Divider(height: 1),
                          Column(
                            children: [
                              ...List.generate(
                                overViewSale.stepsBonus?.length ?? 0,
                                (index) => boxGiftBonus(
                                    svgAsset:
                                        "packages/sahashop_customer/assets/icons/point.svg",
                                    svgAssetCheck:
                                        "packages/sahashop_customer/assets/icons/checked.svg",
                                    stepsBonus: overViewSale.stepsBonus![index],
                                    overViewSale: overViewSale),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getText(int? type) {
    if (type == 0) return "Theo tháng";
    if (type == 1) return "Theo tuần";
    if (type == 2) return "Theo quý";
    if (type == 3) return "Theo năm";
    return "Chọn kỳ";
  }

  Widget boxGiftBonus({
    required String svgAsset,
    required String svgAssetCheck,
    required StepsBonus stepsBonus,
    required OverViewSale overViewSale,
  }) {
    double getTotal() {
      var t = overViewSale.saleConfig?.typeBonusPeriod;
      if (t == 0) {
        return overViewSale.totalFinalInMonth ?? 0;
      }
      if (t == 1) {
        return overViewSale.totalFinalInWeek ?? 0;
      }
      if (t == 2) {
        return overViewSale.totalFinalInQuarter ?? 0;
      }
      if (t == 3) {
        return overViewSale.totalFinalInYear ?? 0;
      }
      return 0;
    }

    return Container(
      padding:
          const EdgeInsets.only(left: 15.0, right: 15.0, top: 8, bottom: 8),
      margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 8, bottom: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          border: Border.all(
              color: getTotal() >= stepsBonus.limit!
                  ? Colors.amber
                  : Colors.grey[200]!,
              width: 1.5)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: SvgPicture.asset(
              getTotal() >= stepsBonus.limit! ? svgAssetCheck : svgAsset,
              height: 25,
              width: 25,
            ),
          ),
          Text(
            "Đạt: ${SahaStringUtils().convertToMoney(stepsBonus.limit)}₫",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          Spacer(),
          Text(
            "Thưởng: ${SahaStringUtils().convertToMoney(stepsBonus.bonus)}₫",
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  Widget itemReport(
      {required String title, required Icon icon, required String? number}) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      width: (Get.width - 40) / 2,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Column(
        children: [
          Row(
            children: [
              icon,
              SizedBox(
                width: 5,
              ),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
            ],
          ),
          Divider(),
          Text(
            SahaStringUtils().convertToMoney(number),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
