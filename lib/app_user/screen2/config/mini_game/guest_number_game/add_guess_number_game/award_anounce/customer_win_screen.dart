import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../../../../../model/guess_number_game.dart';

class CustomersWinScreen extends StatelessWidget {
  const CustomersWinScreen({Key? key, required this.listCusWin})
      : super(key: key);
  final List<CustomerWin> listCusWin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách người có cùng đáp án'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...listCusWin.map((e) => customer(e, listCusWin.indexOf(e)))
          ],
        ),
      ),
    );
  }

  Widget customer(CustomerWin customerWin, int index) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(
              'Hạng ${index + 1}',
              style: TextStyle(color: Colors.white),
            )),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Họ và tên: "), Text(customerWin.name ?? '')],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Thời gian dự đoán: "),
              Text(
                  '${DateFormat("HH:mm").format(customerWin.createdAt ?? DateTime.now())} | ${DateFormat("dd-MM-yyyy").format(customerWin.createdAt ?? DateTime.now())}')
            ],
          ),
        ],
      ),
    );
  }
}
