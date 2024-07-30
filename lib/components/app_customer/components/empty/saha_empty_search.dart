import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SahaEmptySearch extends StatelessWidget {
  final double? height;
  final double? width;

  const SahaEmptySearch({Key? key, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SvgPicture.asset(
        "assets/icons/search_not_fount.svg",
        width: width,
        height: height,
        color: Colors.grey,
      ),
    );
  }
}
