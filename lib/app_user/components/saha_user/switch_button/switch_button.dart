import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final bool? value;
  final ValueChanged<bool>? onChanged;

  CustomSwitch({Key? key, this.value, this.onChanged}) : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.value == false
            ? widget.onChanged!(true)
            : widget.onChanged!(false);
      },
      child: Container(
        width: 45.0,
        height: 28.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          color: widget.value! ? Colors.green : Colors.grey,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 2.0, bottom: 2.0, right: 2.0, left: 2.0),
          child: Container(
            alignment:
                widget.value! ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: 20.0,
              height: 20.0,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
