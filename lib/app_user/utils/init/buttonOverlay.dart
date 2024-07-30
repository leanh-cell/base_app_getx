import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

OverlayEntry createOverlayEntry(BuildContext context) {
  RenderBox renderBox = context.findRenderObject() as RenderBox;
  var size = renderBox.size;
  var offset = renderBox.localToGlobal(Offset.zero);

  return OverlayEntry(
      builder: (context) => Positioned(
          left: offset.dx,
          top: offset.dy + size.height + 5.0,
          width: size.width,
          child: Container(
            width: 40,
            height: 40,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.red,
              child: IconButton(
                icon: Icon(Icons.exit_to_app), onPressed: () {  },
              ),
            ),
          )));
}
