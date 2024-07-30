import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/pdf_generate.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';

import '../../../../../../saha_data_controller.dart';

class PdfInvoiceApi {
  static Future<File> generate(Order order) async {
    SahaDataController sahaDataController = Get.find();
    var data = sahaDataController.listBranch
        .where((e) => e.id == sahaDataController.branchCurrent.value.id).first;
    final pdf = Document();
    final customFont =
        Font.ttf(await rootBundle.load('assets/fonts/roboto_regular.ttf'));

    pdf.addPage(MultiPage(
      build: (context) => [
        Container(
          decoration:
              BoxDecoration(border: Border.all(style: BorderStyle.dotted)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text(
                '  Mã đơn hàng: ',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    font: customFont),
              ),
              Text(
                '${order.orderCode ?? ""}',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    font: customFont),
              ),
            ]),
            Divider(height: 1, borderStyle: BorderStyle.dotted),
            Row(children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(style: BorderStyle.dotted),
                          bottom: BorderSide(style: BorderStyle.dotted))),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Từ: ",
                            style: TextStyle(font: customFont, fontSize: 13)),
                        Text("Tên: ${data.name ?? ""}",
                            style: TextStyle(
                                font: customFont,
                                fontWeight: FontWeight.bold,
                                fontSize: 13)),
                        Text(
                            "Địa chỉ: ${data.addressDetail ?? ""} ${data.wardsName ?? ""}, ${data.districtName ?? ""}, ${data.provinceName ?? ""}",
                            style: TextStyle(font: customFont, fontSize: 13)),
                        Text("Số điện thoại: ${data.phone ?? ""}",
                            style: TextStyle(font: customFont, fontSize: 13))
                      ]),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(style: BorderStyle.dotted))),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Đến: ",
                            style: TextStyle(font: customFont, fontSize: 13)),
                        Text("Tên: ${order.infoCustomer?.name ?? ""}",
                            style: TextStyle(
                                font: customFont,
                                fontWeight: FontWeight.bold,
                                fontSize: 13)),
                        Text(
                            "Địa chỉ: ${order.customerAddress?.addressDetail ?? ""} ${order.customerAddress?.wardsName ?? ""}, ${order.customerAddress?.districtName ?? ""}, ${order.customerAddress?.provinceName ?? ""}",
                            style: TextStyle(font: customFont, fontSize: 13)),
                        Text(
                            "Số điện thoại: ${order.customerAddress?.phone ?? ""}",
                            style: TextStyle(font: customFont, fontSize: 13))
                      ]),
                ),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: Column(children: [
                  Text(
                    'Ngày đặt hàng: ',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        font: customFont),
                  ),
                  Text(
                    '${SahaDateUtils().getDDMMYY(order.createdAt ?? DateTime.now())} ${DateFormat('HH:mm:ss').format(order.createdAt ?? DateTime.now())}',
                    style: TextStyle(font: customFont),
                  ),
                ]),
              )
            ]),
            Divider(height: 1, borderStyle: BorderStyle.dotted),
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                'Nội dung đơn hàng: (Tổng số loại sản phẩm: ${order.lineItemsAtTime?.length ?? 0})',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    font: customFont),
              ),
            )
          ]),
        ),
        rowTable(
            isTitle: true,
            customFont: customFont,
            c1: "STT",
            c2: "Tên sản phẩm",
            c3: "Số lượng",
            c4: "Thành tiền"),
        if (order.lineItemsAtTime != null)
          ...List.generate(order.lineItemsAtTime!.length, (index) {
            if (order.lineItemsAtTime!.length == index + 1) {
              return rowTable(
                  customFont: customFont,
                  isEnd: true,
                  c1: '${index + 1}',
                  c2: '${order.lineItemsAtTime![index].name ?? ""}',
                  c3: '${order.lineItemsAtTime![index].quantity ?? "0"}',
                  c4: '${SahaStringUtils().convertToMoney((order.lineItemsAtTime![index].quantity ?? 0) * (order.lineItemsAtTime![index].itemPrice ?? 0))}₫');
            }
            return rowTable(
                customFont: customFont,
                c1: '${index + 1}',
                c2: '${order.lineItemsAtTime![index].name ?? ""}',
                c3: '${order.lineItemsAtTime![index].quantity ?? "0"}',
                c4: '${SahaStringUtils().convertToMoney((order.lineItemsAtTime![index].quantity ?? 0) * (order.lineItemsAtTime![index].itemPrice ?? 0))}₫');
          }),
        if (order.totalShippingFee != 0 && order.totalShippingFee != null)
          rowTable(
              customFont: customFont,
              c1: '+',
              isEnd: true,
              c2: 'Phí vận chuyển',
              c3: '1',
              c4: '${SahaStringUtils().convertToMoney(order.totalShippingFee ?? 0)}₫'),
        if (order.productDiscountAmount != 0 &&
            order.productDiscountAmount != null)
          rowTable(
              customFont: customFont,
              c1: '-',
              isEnd: true,
              c2: 'Giảm giá sàn phẩm',
              c3: '1',
              c4: '-${SahaStringUtils().convertToMoney(order.productDiscountAmount ?? 0)}₫'),
        if (order.voucherDiscountAmount != 0 &&
            order.voucherDiscountAmount != null)
          rowTable(
              customFont: customFont,
              c1: '-',
              isEnd: true,
              c2: 'Giảm giá Voucher',
              c3: '1',
              c4: '-${SahaStringUtils().convertToMoney(order.voucherDiscountAmount ?? 0)}₫'),
        if (order.comboDiscountAmount != 0 && order.comboDiscountAmount != null)
          rowTable(
              customFont: customFont,
              c1: '-',
              isEnd: true,
              c2: 'Giảm giá Combo',
              c3: '1',
              c4: '-${SahaStringUtils().convertToMoney(order.comboDiscountAmount ?? 0)}₫'),
        SizedBox(height: 10),
        if (order.bonusAgencyHistory != null &&
            order.bonusAgencyHistory!.rewardValue != 0)
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.only(left: 0, top: 5, bottom: 5),
              child: Column(children: [
                Text(
                  'Thưởng đại lý: ',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      font: customFont),
                ),
              ]),
            )
          ]),
        if (order.bonusAgencyHistory != null &&
            order.bonusAgencyHistory!.rewardValue != 0)
          SizedBox(height: 5),
        if (order.bonusAgencyHistory != null &&
            order.bonusAgencyHistory!.rewardValue != 0)
          rowTable(
              isTitle: true,
              customFont: customFont,
              c1: "STT",
              c2: "Tên phần thưởng",
              c3: "Số lượng",
              c4: "Trị giá"),
        if (order.bonusAgencyHistory != null &&
            order.bonusAgencyHistory!.rewardValue != 0)
          rowTable(
              customFont: customFont,
              c1: '-',
              isEnd: true,
              c2: '${order.bonusAgencyHistory!.rewardName ?? ""}',
              c3: '1',
              c4: '${SahaStringUtils().convertToMoney(order.bonusAgencyHistory?.rewardValue ?? 0)}₫'),
        SizedBox(height: 10),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(5),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  "Tiền thu người nhận:",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      font: customFont),
                ),
                Text(
                  "${SahaStringUtils().convertToMoney(order.totalFinal)}₫",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      font: customFont),
                ),
                SizedBox(height: 10),
                Text(
                    "Quý khách vui lòng kiểm tra danh sách đơn hàng trước khi nhận hàng. Cảm ơn Quý khách đã tin tưởng và sử dụng sản phẩm của ${data.name ?? "cửa hàng"}",
                    style: TextStyle(font: customFont, fontSize: 7))
              ]),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 100,
              padding: EdgeInsets.all(10),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  "Chữ kí người nhận:",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      font: customFont),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "(Xác nhận hàng nguyên vẹn không bóp méo, bể vỡ)",
                  style: TextStyle(fontSize: 7, font: customFont),
                ),
              ]),
            ),
          ),
        ]),
      ],
    ));

    return PdfApi.saveDocument(name: '${order.orderCode ?? ""}.pdf', pdf: pdf);
  }

  static Widget rowTable({
    required String c1,
    required String c2,
    required String c3,
    required String c4,
    required Font customFont,
    bool? isEnd,
    bool? isTitle,
  }) {
    return Row(mainAxisSize: MainAxisSize.max, children: [
      Expanded(
          flex: 1,
          child: Container(
              padding: EdgeInsets.all(5),
              decoration: isEnd == true
                  ? BoxDecoration(
                      border: Border(
                          top: BorderSide(style: BorderStyle.dotted),
                          right: BorderSide(style: BorderStyle.dotted),
                          left: BorderSide(
                            style: BorderStyle.dotted,
                          ),
                          bottom: BorderSide(
                            style: BorderStyle.dotted,
                          )),
                    )
                  : BoxDecoration(
                      border: Border(
                        top: BorderSide(style: BorderStyle.dotted),
                        right: BorderSide(style: BorderStyle.dotted),
                        left: BorderSide(
                          style: BorderStyle.dotted,
                        ),
                      ),
                    ),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  c1,
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                  style: TextStyle(font: customFont),
                )
              ]))),
      Expanded(
          flex: 9,
          child: Container(
              padding: EdgeInsets.all(5),
              decoration: isEnd == true
                  ? BoxDecoration(
                      border: Border(
                          top: BorderSide(style: BorderStyle.dotted),
                          right: BorderSide(style: BorderStyle.dotted),
                          bottom: BorderSide(
                            style: BorderStyle.dotted,
                          )))
                  : BoxDecoration(
                      border: Border(
                      top: BorderSide(style: BorderStyle.dotted),
                      right: BorderSide(style: BorderStyle.dotted),
                    )),
              child: isTitle == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text(c2, style: TextStyle(font: customFont))])
                  : Text(c2,
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      style: TextStyle(font: customFont)))),
      Expanded(
          flex: 2,
          child: Container(
              padding: EdgeInsets.all(5),
              decoration: isEnd == true
                  ? BoxDecoration(
                      border: Border(
                          top: BorderSide(style: BorderStyle.dotted),
                          right: BorderSide(style: BorderStyle.dotted),
                          bottom: BorderSide(
                            style: BorderStyle.dotted,
                          )))
                  : BoxDecoration(
                      border: Border(
                      top: BorderSide(style: BorderStyle.dotted),
                      right: BorderSide(style: BorderStyle.dotted),
                    )),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(c3,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    style: TextStyle(font: customFont))
              ]))),
      Expanded(
          flex: 3,
          child: Container(
              padding: EdgeInsets.all(5),
              decoration: isEnd == true
                  ? BoxDecoration(
                      border: Border(
                          top: BorderSide(style: BorderStyle.dotted),
                          right: BorderSide(style: BorderStyle.dotted),
                          bottom: BorderSide(
                            style: BorderStyle.dotted,
                          )))
                  : BoxDecoration(
                      border: Border(
                      top: BorderSide(style: BorderStyle.dotted),
                      right: BorderSide(style: BorderStyle.dotted),
                    )),
              child: isTitle == true
                  ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(c4,
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: TextStyle(font: customFont))
                    ])
                  : Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Text(c4,
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: TextStyle(font: customFont))
                    ]))),
    ]);
  }
}
