import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/switch_button/switch_button.dart';

class ChooseCompare extends StatelessWidget {
  final Function? onReturn;
  final isCompare;

  ChooseCompare({this.onReturn, this.isCompare = false});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          color: Colors.grey[300],
          height: 4,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Text(
                "So sánh với",
                style: TextStyle(fontSize: 15),
              ),
              Spacer(),
              CustomSwitch(
                value: isCompare,
                onChanged: (v) {
                  onReturn!(v);
                },
              )
            ],
          ),
        ),
        Container(
          color: Colors.grey[300],
          height: 4,
        ),
      ],
    );
  }
}
