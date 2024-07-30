import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com.ikitech.store/app_user/screen2/config_app/screens_config/font_type/font_data.dart';

class DropDownButtonCustom extends StatelessWidget {
  String? value;
  List<String>? item;
  String? title;
  Function? onChange;

  DropDownButtonCustom({this.value, this.item, this.title, this.onChange});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DropdownButton<dynamic>(
      focusColor: Colors.white,
      value: value,
      //elevation: 5,
      style: TextStyle(color: Colors.white),
      iconEnabledColor: Colors.black,
      items: item!.map<DropdownMenuItem<dynamic>>((String value) {
        return DropdownMenuItem<dynamic>(
          value: value,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                FONT_DATA[value]!,
                style: TextStyle(color: Colors.black,
                fontFamily: value
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }).toList(),
      hint: Text(
        title!,
        style: TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
      ),
      onChanged: onChange as void Function(dynamic)?,
    );
  }
}
