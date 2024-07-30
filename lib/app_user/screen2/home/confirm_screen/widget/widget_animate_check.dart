import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AnimateCheck extends StatelessWidget {
  final double? opacity;
  final Widget? child;
  final Color? color;
  AnimateCheck({this.opacity, this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity!,
      duration: const Duration(seconds: 1),
      child: AnimatedContainer(
        decoration: BoxDecoration(border: Border.all(color: color!)),
        duration: Duration(seconds: 1),
        child: child,
      ),
    );
  }
}
