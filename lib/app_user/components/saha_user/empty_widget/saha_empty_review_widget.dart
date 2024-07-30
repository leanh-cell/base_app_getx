import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SahaEmptyReviewWidget extends StatelessWidget {
  final double? height;
  final double? width;

  const SahaEmptyReviewWidget({Key? key, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          SvgPicture.asset(
            "assets/icons/satisfaction.svg",
            width: width,
            height: height,
          ),
          SizedBox(
            height: 10,
          ),
          Text("Chưa có đánh giá !")
        ],
      ),
    );
  }
}
