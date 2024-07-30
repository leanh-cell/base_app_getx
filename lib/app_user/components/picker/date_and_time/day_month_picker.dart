import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

class MonthYearPicker {
  static void picker(
      {Function(int)? onChangeMonth,
      Function(int)? onChangeDay,
      required int currentDay,
      required int currentMonth}) {
    showModalBottomSheet(
        context: Get.context!,
        builder: (builder) {
          return ChangeMonthYear(
            currentDay: currentDay,
            currentMonth: currentMonth,
            onChangeDay: onChangeDay,
            onChangeMonth: onChangeMonth,
          );
        });
  }
}

class ChangeMonthYear extends StatefulWidget {
  final Function(int)? onChangeMonth;

  final Function(int)? onChangeDay;

  final int? currentDay;
  final int? currentMonth;

  const ChangeMonthYear(
      {Key? key,
      this.onChangeMonth,
      this.onChangeDay,
      this.currentDay,
      this.currentMonth})
      : super(key: key);

  @override
  _ChangeMonthYearState createState() => _ChangeMonthYearState();
}

class _ChangeMonthYearState extends State<ChangeMonthYear> {
  var currentDay = 1;
  var currentMonth = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentDay = widget.currentDay!;
    currentMonth = widget.currentMonth as int;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      height: 250.0,
      color: Colors.transparent, //could change this to Color(0xFF737373),
      //so you don't have to change MaterialApp canvasColor
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Ngày"),
              ),
              Expanded(
                child: NumberPicker(
                  value: currentDay,
                  minValue: 1,
                  maxValue: 31,
                  onChanged: (va) {
                    currentDay = va;
                    widget.onChangeDay!(va);
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Tháng"),
              ),
              Expanded(
                child: NumberPicker(
                  value: currentMonth,
                  minValue: 1,
                  maxValue: 12,
                  onChanged: (va) {
                    currentMonth = va;
                    widget.onChangeMonth!(va);
                    setState(() {});
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
