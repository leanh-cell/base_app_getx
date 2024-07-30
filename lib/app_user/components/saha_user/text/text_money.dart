import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';

// ignore: must_be_immutable
class SahaMoneyText extends StatelessWidget {
  double? price;
  double sizeVND;
  double sizeText;
  Color? color;
  FontWeight? fontWeight;

  SahaMoneyText(
      {this.price,
      this.sizeVND = 16,
      this.sizeText = 19,
      this.color,
      this.fontWeight = FontWeight.w500});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Text(
          "đ",
          style: TextStyle(
              fontSize: sizeVND,
              decoration: TextDecoration.underline,
              color: color),
        ),
        Text(
          "${SahaStringUtils().convertToMoney(price)}",
          style: TextStyle(
            fontSize: sizeText,
            fontWeight: fontWeight,
            color: color,
          ),
          maxLines: 2,
        ),
      ],
    );
  }
}
