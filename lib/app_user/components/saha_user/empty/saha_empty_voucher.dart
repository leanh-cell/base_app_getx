import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:com.ikitech.store/app_user/utils/color_utils.dart';

class SahaEmptyVoucher extends StatelessWidget {
  final double? height;
  final double? width;

  const SahaEmptyVoucher({Key? key, this.height, this.width}) : super(key: key);

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
            "packages/sahashop_customer/assets/icons/empty_voucher.svg",
            width: width,
            height: height,
            color: SahaColorUtils().colorPrimaryTextWithWhiteBackground(),
          ),
          SizedBox(
            height: 10,
          ),
          Text("Chưa có Voucher nào !")
        ],
      ),
    );
  }
}
