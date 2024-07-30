import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SahaEmptyCart extends StatelessWidget {
  final double? height;
  final double? width;

  const SahaEmptyCart({Key? key, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Giỏ hàng trống\nMua hàng ngay thôi nào !",textAlign: TextAlign.center,),
          ),
          SvgPicture.asset(
            "packages/sahashop_customer/assets/icons/cart2.svg",
            width: width,
            height: height,
          ),
        ],
      ),
    );
  }
}
