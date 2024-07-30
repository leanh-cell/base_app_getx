import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SahaEmptyPaymentRequest extends StatelessWidget {
  final double? height;
  final double? width;

  const SahaEmptyPaymentRequest({Key? key, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Không có yêu cầu"),
          ),
          SvgPicture.asset(
            "assets/icons/no.svg",
            width: width,
            height: height,
          ),
        ],
      ),
    );
  }
}
