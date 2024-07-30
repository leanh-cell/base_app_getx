import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SahaEmptyStore extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;

  const SahaEmptyStore({Key? key, this.height, this.width, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Tạo cửa hàng ngay nào!",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Theme.of(context).primaryColor),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: SvgPicture.asset(
            "assets/svg/down_arrow.svg",
            width: width,
            height: height,
            color: color,
          ),
        ),
      ],
    );
  }
}
