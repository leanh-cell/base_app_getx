import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextSized extends StatelessWidget {
  String text;
  Color? colorBox;
  Color? colorBorder;
  TextStyle? style;
  TextSized(this.text, {this.style, this.colorBox, this.colorBorder});

  @override
  Widget build(BuildContext context) {
    final Size txtSize = _textSize(
        text,
        style ??
            TextStyle(
              fontSize: 30,
              color: Colors.white,
            ));

    return Container(
      width: txtSize.width + 15,
      height: txtSize.height + 5,
      decoration: BoxDecoration(
          color: colorBox ?? Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(3),
          border: Border.all(
            color: colorBorder ?? Theme.of(context).primaryColor,
          )),
      child: Center(
        child: Text(
          text,
          style: style,
          softWrap: false,
          overflow: TextOverflow.clip,
          maxLines: 1,
        ),
      ),
    );
  }

  // Here it is!
  Size _textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}
