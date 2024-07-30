import 'package:flutter/widgets.dart';

class FakeDevicePixelRatio extends StatelessWidget {
  final Widget? child;

  FakeDevicePixelRatio({ this.child});

  @override
  Widget build(BuildContext context) {
    final ratio = 0.6;

    return FractionallySizedBox(
        widthFactor: 1/ratio,
        heightFactor: 1/ratio,
        child: Transform.scale(
            scale: ratio,
            child: child
        )
    );
  }
}