import 'package:flutter/cupertino.dart';

class FakeDevicePixelRatio extends StatelessWidget {
  final num fakeDevicePixelRatio;
  final Widget? child;

  FakeDevicePixelRatio({required this.fakeDevicePixelRatio, this.child})
      : assert(fakeDevicePixelRatio != null);

  @override
  Widget build(BuildContext context) {
    final ratio =
        fakeDevicePixelRatio / WidgetsBinding.instance.window.devicePixelRatio;

    return FractionallySizedBox(
        widthFactor: 1 / ratio,
        heightFactor: 1 / ratio,
        child: Transform.scale(scale: ratio, child: child));
  }
}
