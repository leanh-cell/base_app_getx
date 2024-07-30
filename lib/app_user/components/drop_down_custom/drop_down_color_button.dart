import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDownColorButtonCustom extends StatelessWidget {
  Map<String, dynamic>? value;
  List <Map<String, dynamic>>? item;
  String? title;
  Function? onChange;

  DropDownColorButtonCustom(
      {this.value, this.item, this.title, this.onChange});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DropdownButton<Map<String, dynamic>>(
      focusColor: Colors.white,
      value: value,
      //elevation: 5,
      style: TextStyle(color: Colors.white),
      iconEnabledColor: Colors.black,
      items: item!.map<DropdownMenuItem<Map<String, dynamic>>>(
              (Map<String, dynamic> value) {
            return DropdownMenuItem<Map<String, dynamic>>(
              value: value,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value.keys.first,
                    style: TextStyle(color: Colors.black),
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: value.values.last
                    ),
                  )
                ],
              ),
            );
          }).toList(),
      hint: Text(
        title!,
        style: TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
      ),
      onChanged: (Map<String, dynamic>? value) {
        onChange;
        // setState(() {
        //   chooseDropDownValue = value;
        //   _chosenValue = value.keys.first;
        // });
      },
    );
  }
}
