import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../components/saha_user/text/text_money.dart';

class ItemReportOrder extends StatelessWidget {
  final String? text;
  final double? totalPrice;
  final int? totalOrder;

  ItemReportOrder({ this.text, this.totalPrice, this.totalOrder});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Text(text ?? ""),
              SizedBox(
                width: 10,
              ),
              Text("${totalOrder ?? 0}"),
              Spacer(),
              SahaMoneyText(
                sizeText: 14,
                sizeVND: 12,
                price: totalPrice ?? 0,
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
      ],
    );
  }
}
