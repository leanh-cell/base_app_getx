import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DecentralizationWidget extends StatelessWidget {
  Widget child;
  bool decent;
  double? padding;
  DecentralizationWidget(
      {required this.child, required this.decent, this.padding});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return decent == true
        ? child
        : Stack(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            alignment: Alignment.center,
            children: [
              child,
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      border: Border.all(color: Colors.white)),
                  padding: EdgeInsets.all(padding ?? 10),
                ),
              ),
            ],
          );
  }
}
