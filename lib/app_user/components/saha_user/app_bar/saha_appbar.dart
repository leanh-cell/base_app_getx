import 'package:flutter/material.dart';

class SahaAppBar extends PreferredSize {
  final double height;
  final Widget? titleChild;
  final String? titleText;
  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  SahaAppBar(
      {this.leading,
      this.actions,
      this.titleText,
      this.bottom,
      this.titleChild,
      this.height = kToolbarHeight})
      : super(child: Container(), preferredSize: Size(100, 100));

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: titleText != null
            ? Text(
                titleText!,
              )
            : titleChild,
        leading: leading,
        actions: actions,
        elevation: 0.0,
        centerTitle: true,
        bottom: bottom != null
            ? bottom
            : PreferredSize(
                preferredSize: Size.zero,
                child: Divider(
                  height: 1,
                )));
  }
}
