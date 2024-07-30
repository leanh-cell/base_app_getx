import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/screen2/report/choose_time/choose_time_screen.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';

import '../../../../components/saha_user/dialog/dialog.dart';
import '../../report_controller.dart';
import 'profit_loss_report_controller.dart';

class ProfitLossReportScreen extends StatelessWidget {
  ReportController reportController = Get.find();
  ProfitLossReportController profitLossReportController =
      ProfitLossReportController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Báo cáo lãi lỗ"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => ChooseTimeScreen(
                              isCompare: reportController.isCompare.value,
                              initTab: reportController.indexTabTime,
                              initChoose: reportController.indexChooseTime,
                              fromDayInput: reportController.fromDay.value,
                              toDayInput: reportController.toDay.value,
                              hideCompare: true,
                              callback: (DateTime fromDate,
                                  DateTime toDay,
                                  DateTime fromDateCP,
                                  DateTime toDayCP,
                                  bool isCompare,
                                  int index,
                                  int indexChoose) {
                                reportController.fromDay.value = fromDate;
                                reportController.toDay.value = toDay;
                                reportController.fromDayCP.value = fromDateCP;
                                reportController.toDayCP.value = toDayCP;
                                reportController.isCompare.value = isCompare;
                                reportController.indexTabTime = index;
                                reportController.indexChooseTime = indexChoose;
                              },
                            ))!
                        .then((value) {
                      profitLossReportController.getProfitAndLoss();
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 16,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Obx(
                          () => Text(
                            "${SahaDateUtils().getDDMMYY2(reportController.fromDay.value)} - ${SahaDateUtils().getDDMMYY2(reportController.toDay.value)}",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down_rounded)
                      ],
                    ),
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    SahaDialogApp.showDialogSuggestion(
                        title: 'Chú giải thông số',
                        contentWidget: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Divider(),
                              Text(
                                "Lợi nhuận",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    color: Colors.blue),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '= Doanh thu bán hàng + Chi phí bán hàng - Lợi nhuận khác',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Trong đó:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Doanh thu bán hàng = Tiền hàng thực bán + Phí giao hàng thu của khách - Chiết khấu.',
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          SahaDialogApp.showDialogSuggestion(
                                              title: 'Chú giải',
                                              contentWidget: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Divider(),
                                                  Text(
                                                      "Phí gia hàng thu của khách: Là khoản phí giao hàng thu của khách đã được tính vào giá trị đơn hàng"),
                                                  SizedBox(height: 10),
                                                  Text(
                                                      "Chiết khấu: Bao gồm cả chiết khấu cho mỗi sản phẩm và chiết khấu của tổng đơn (nếu có)"),
                                                ],
                                              ));
                                        },
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: Colors.blue,
                                              size: 20,
                                            ),
                                            Text(
                                              'i',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Chi phí bán hàng = Giá vốn hàng hoá + Thanh toán bằng xu + Phí giao hàng trả đối tác.',
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          SahaDialogApp.showDialogSuggestion(
                                              title: 'Chú giải',
                                              contentWidget: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Divider(),
                                                  Text(
                                                      "Giá vốn hàng hoá = Số lượng hàng hoá xuất kho x Giá vốn xuất kho."),
                                                  SizedBox(height: 10),
                                                  Text(
                                                      "Thanh toán bằng xu: Khách hàng thanh toán bằng đơn hàng bằng xu (Số tiền quy đổi từ xu ra tiền)."),
                                                  SizedBox(height: 10),
                                                  Text(
                                                      "Phí giao hàng trả đối tác: Khoản tiền cửa hàng bỏ ra cho viện vận chuyển (Phí trả shipper, đối tác giao hàng nhanh, vv..."),
                                                ],
                                              ));
                                        },
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: Colors.blue,
                                              size: 20,
                                            ),
                                            Text(
                                              'i',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Lợi nhuận khác = Thu nhập khác - Chi phí khác.',
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          SahaDialogApp.showDialogSuggestion(
                                              title: 'Chú giải',
                                              contentWidget: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Divider(),
                                                  Text(
                                                      "Thu nhập khác = Phiếu thu tự tạo + Phí khách trả hàng."),
                                                  SizedBox(height: 10),
                                                  Text(
                                                      "Phiếu thu tự tạo: Là các khoản thu được ghi nhậ từ các phiếu thu có hạch toán kết quả kinh doanh."),
                                                  SizedBox(height: 10),
                                                  Text(
                                                      "Phí khách trả hàng = Giá trị hàng bán bị trả lại - Tiền hoàn trả lại cho khách."),
                                                  SizedBox(height: 10),
                                                  Text(
                                                      "Chi phí khác: Là các khoản chi được ghi nhận từ các phiếu chi tự tạo có hạch toán kết quả kinh doanh."),
                                                ],
                                              ));
                                        },
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: Colors.blue,
                                              size: 20,
                                            ),
                                            Text(
                                              'i',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Tiền hàng thực bán",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    color: Colors.blue),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '= Tiền hàng bán ra - Tiền hàng trả lại',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Trong đó:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Tiền hàng bán ra = Đơn giá x Số lượng sản phẩm trong đơn hàng.',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Divider(),
                                  Text(
                                    'Tiền hàng trả lại = Giá trị hàng bán bị trả lại trên đơn trả hàng.',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Lưu ý: ',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '-Đơn hàng có gói hàng ở trạng thái "Đã giao hàng" sẽ được ghi nhận vào doanh thu. Ngày ghi nhận là ngày giao hàng thành công.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '-Đơn trả hàng xuất hiện nhận hàng hoặc hoàn tiền sẽ được ghi nhận vào báo cáo.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '-Các phiếu thu/chi chủ động có hạch toán kết quả kinh doanh sẽ được ghi nhận vào báo cáo.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ));
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.circle,
                        color: Colors.blue,
                        size: 20,
                      ),
                      Text(
                        'i',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            Obx(
              () => Container(
                color: Colors.white,
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      width: Get.width / 2 - 20,
                      height: 130,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent.withOpacity(0.07),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "LỢI NHUẬN",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            "${SahaStringUtils().convertToMoney("${profitLossReportController.profitLoss.value.profit ?? 0}")}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.pink.withOpacity(0.6)),
                                child: SvgPicture.asset(
                                  "assets/icons/box.svg",
                                  width: 20,
                                  height: 20,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "DT bán hàng (1)",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                  Text(
                                    "${SahaStringUtils().convertToMoney(profitLossReportController.profitLoss.value.salesRevenue ?? 0)}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              )
                            ],
                          ),
                          Divider(
                            height: 1,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blueAccent.withOpacity(0.5)),
                                child: SvgPicture.asset(
                                  "assets/icons/box.svg",
                                  width: 20,
                                  height: 20,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Chi phí bán hàng (2)",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                  Text(
                                    "${SahaStringUtils().convertToMoney(profitLossReportController.profitLoss.value.sellingExpenses ?? 0)}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Divider(
                                    height: 1,
                                  )
                                ],
                              )
                            ],
                          ),
                          Divider(
                            height: 1,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green.withOpacity(0.5)),
                                child: SvgPicture.asset(
                                  "assets/icons/box.svg",
                                  width: 20,
                                  height: 20,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "LN khác (3-4)",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                  Text(
                                    "${SahaStringUtils().convertToMoney(profitLossReportController.profitLoss.value.otherIncome ?? 0)}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Divider(
                                    height: 1,
                                  ),
                                ],
                              )
                            ],
                          ),
                          Divider(
                            height: 1,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Obx(
              () => Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text("KẾT QUẢ KINH DOANH"),
                    Divider(),
                    Row(
                      children: [
                        Text(
                          " Doanh thu bán hàng (1)",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Text(
                          "${SahaStringUtils().convertToMoney(profitLossReportController.profitLoss.value.salesRevenue ?? 0)}",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Divider(),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 0, top: 0, bottom: 0, right: 0),
                      child: Expandable(
                        showArrowWidget: true,
                        backgroundColor: Colors.transparent,
                        firstChild: Expanded(
                          child: Row(
                            children: [
                              Text(
                                " Tiền hàng thực bán",
                              ),
                              Spacer(),
                              Text(
                                "${SahaStringUtils().convertToMoney(profitLossReportController.profitLoss.value.realMoneyForSale ?? 0)}",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        secondChild: Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(),
                              Row(
                                children: [
                                  Text(
                                    "Tiền hàng bán ra",
                                  ),
                                  Spacer(),
                                  Text(
                                    "${SahaStringUtils().convertToMoney(profitLossReportController.profitLoss.value.moneySales ?? 0)}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Text(
                                    "Tiền hàng trả lại",
                                  ),
                                  Spacer(),
                                  Text(
                                    "${SahaStringUtils().convertToMoney(profitLossReportController.profitLoss.value.moneyBack ?? 0)}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    Row(
                      children: [
                        Text(
                          " Thuế VAT",
                        ),
                        Spacer(),
                        Text(
                          "${SahaStringUtils().convertToMoney(profitLossReportController.profitLoss.value.taxVat ?? 0)}",
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Text(
                          " Phí giao hàng thu của khách",
                        ),
                        Spacer(),
                        Text(
                          "${SahaStringUtils().convertToMoney(profitLossReportController.profitLoss.value.customerDeliveryFee ?? 0)}",
                        ),
                      ],
                    ),
                    Divider(),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 0, top: 0, bottom: 0, right: 0),
                      child: Expandable(
                        showArrowWidget: true,
                        backgroundColor: Colors.transparent,
                        firstChild: Expanded(
                          child: Row(
                            children: [
                              Text(
                                " Giảm giá ",
                              ),
                              Spacer(),
                              Text(
                                "${SahaStringUtils().convertToMoney(profitLossReportController.profitLoss.value.totalDiscount ?? 0)}",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        secondChild: Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(),
                              Row(
                                children: [
                                  Text(
                                    " Giảm giá sản phẩm",
                                  ),
                                  Spacer(),
                                  Text(
                                    "${SahaStringUtils().convertToMoney(profitLossReportController.profitLoss.value.productDiscount ?? 0)}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Text(
                                    " Giảm giá combo",
                                  ),
                                  Spacer(),
                                  Text(
                                    "${SahaStringUtils().convertToMoney(profitLossReportController.profitLoss.value.combo ?? 0)}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Text(
                                    " Giảm giá Voucher",
                                  ),
                                  Spacer(),
                                  Text(
                                    "${SahaStringUtils().convertToMoney(profitLossReportController.profitLoss.value.voucher ?? 0)}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Text(
                                    " Chiết khấu đơn hàng",
                                  ),
                                  Spacer(),
                                  Text(
                                    "${SahaStringUtils().convertToMoney(profitLossReportController.profitLoss.value.discount ?? 0)}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    Row(
                      children: [
                        Text(
                          " Chi phí bán hàng (2)",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Text(
                          "${SahaStringUtils().convertToMoney(profitLossReportController.profitLoss.value.sellingExpenses ?? 0)}",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Text(
                          " Giá vốn hàng hoá",
                        ),
                        Spacer(),
                        Text(
                          "${SahaStringUtils().convertToMoney(profitLossReportController.profitLoss.value.costOfSales ?? 0)}",
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Text(
                          " Thanh toán bằng xu",
                        ),
                        Spacer(),
                        Text(
                          "${SahaStringUtils().convertToMoney(profitLossReportController.profitLoss.value.payWithPoints ?? 0)}",
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Text(
                          " Phí giao hàng trả đối tác",
                        ),
                        Spacer(),
                        Text(
                          "${SahaStringUtils().convertToMoney(profitLossReportController.profitLoss.value.partnerDeliveryFee ?? 0)}",
                        ),
                      ],
                    ),
                    Divider(),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 0, top: 0, bottom: 0, right: 0),
                      child: Expandable(
                        showArrowWidget: true,
                        backgroundColor: Colors.transparent,
                        firstChild: Expanded(
                          child: Row(
                            children: [
                              Text(
                                " Thu nhập khác (3)",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Spacer(),
                              Text(
                                "${SahaStringUtils().convertToMoney(profitLossReportController.profitLoss.value.otherIncome ?? 0)}",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        secondChild: Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(),
                              Row(
                                children: [
                                  Text(
                                    " Phiếu thu tự tạo",
                                  ),
                                  Spacer(),
                                  Text(
                                    "${SahaStringUtils().convertToMoney(profitLossReportController.profitLoss.value.revenueAutoCreate ?? 0)}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Text(
                                    " Phí khách hàng trả",
                                  ),
                                  Spacer(),
                                  Text(
                                    "${SahaStringUtils().convertToMoney(profitLossReportController.profitLoss.value.customerReturn ?? 0)}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    Row(
                      children: [
                        Text(
                          " Chi phí khác (4)",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Text(
                          "${SahaStringUtils().convertToMoney(profitLossReportController.profitLoss.value.otherCosts ?? 0)}",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Text(
                          " Lợi nhuận (1 - 2 + 3 - 4)",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Text(
                          "${SahaStringUtils().convertToMoney(profitLossReportController.profitLoss.value.profit ?? 0)}",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
