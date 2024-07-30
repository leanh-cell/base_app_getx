import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StarRating extends StatelessWidget {
  int? starInput;
  double? sizeStar;
  double? spaceStar;
  EdgeInsets? padding;
  Function? onTap;

  StarRating(
      {this.starInput,
      this.sizeStar = 30,
      this.spaceStar = 10,
      this.padding = const EdgeInsets.all(25.0),
      this.onTap});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: padding!,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              onTap!(1);
            },
            child: starInput! >= 1
                ? SvgPicture.asset(
                    "assets/icons/star_around.svg",
                    height: sizeStar,
                    width: sizeStar,
                  )
                : SvgPicture.asset(
                    "assets/icons/star.svg",
                    height: 30,
                    width: 30,
                    color: Colors.yellow,
                  ),
          ),
          SizedBox(
            width: spaceStar,
          ),
          GestureDetector(
            onTap: () {
              onTap!(2);
            },
            child: starInput! >= 2
                ? SvgPicture.asset(
                    "assets/icons/star_around.svg",
                    height: sizeStar,
                    width: sizeStar,
                  )
                : SvgPicture.asset(
                    "assets/icons/star.svg",
                    height: sizeStar,
                    width: sizeStar,
                    color: Colors.yellow,
                  ),
          ),
          SizedBox(
            width: spaceStar,
          ),
          GestureDetector(
            onTap: () {
              onTap!(3);
            },
            child: starInput! >= 3
                ? SvgPicture.asset(
                    "assets/icons/star_around.svg",
                    height: sizeStar,
                    width: sizeStar,
                  )
                : SvgPicture.asset(
                    "assets/icons/star.svg",
                    height: sizeStar,
                    width: sizeStar,
                    color: Colors.yellow,
                  ),
          ),
          SizedBox(
            width: spaceStar,
          ),
          GestureDetector(
            onTap: () {
              onTap!(4);
            },
            child: starInput! >= 4
                ? SvgPicture.asset(
                    "assets/icons/star_around.svg",
                    height: sizeStar,
                    width: sizeStar,
                  )
                : SvgPicture.asset(
                    "assets/icons/star.svg",
                    height: sizeStar,
                    width: sizeStar,
                    color: Colors.yellow,
                  ),
          ),
          SizedBox(
            width: spaceStar,
          ),
          GestureDetector(
            onTap: () {
              onTap!(5);
            },
            child: starInput! >= 5
                ? SvgPicture.asset(
                    "assets/icons/star_around.svg",
                    height: sizeStar,
                    width: sizeStar,
                  )
                : SvgPicture.asset(
                    "assets/icons/star.svg",
                    height: sizeStar,
                    width: sizeStar,
                    color: Colors.yellow,
                  ),
          ),
        ],
      ),
    );
  }
}
