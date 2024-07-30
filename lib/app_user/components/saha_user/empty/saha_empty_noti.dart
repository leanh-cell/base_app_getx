import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SahaEmptyNoti extends StatelessWidget {
  final double? height;
  final double? width;

  const SahaEmptyNoti({Key? key, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Không có thông báo"),
          ),
          SvgPicture.asset(
            "packages/sahashop_customer/assets/icons/silent.svg",
            width: width,
            height: height,
          ),
        ],
      ),
    );
  }
}
