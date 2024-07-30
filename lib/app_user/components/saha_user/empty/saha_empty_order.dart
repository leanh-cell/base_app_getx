import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SahaEmptyOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          padding: EdgeInsets.all(4),
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: Color(0xFFF5F6F9),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            "packages/sahashop_customer/assets/icons/check_list_new.svg",
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text("Không có đơn hàng nào !")
      ],
    );
  }
}