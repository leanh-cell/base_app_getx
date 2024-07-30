import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ButtonHome extends StatelessWidget {
  String asset;
  String title;
  Color? color;
  Function onTap;
  ButtonHome(
      {required this.asset,
      required this.title,
      this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 100,
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: new LinearGradient(
                    colors: [
                      (color ?? Theme.of(context).primaryColor),
                      (color ?? Theme.of(context).primaryColor)
                          .withOpacity(0.85),
                    ],
                    stops: [
                      0.0,
                      1
                    ],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight,
                    tileMode: TileMode.repeated),
              ),
              child: SvgPicture.asset(
                asset,
                height: 25,
                width: 25,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(fontSize: 13),
              ),
            )
          ],
        ),
      ),
    );
  }
}
