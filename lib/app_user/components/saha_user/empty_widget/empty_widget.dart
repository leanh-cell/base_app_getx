import 'package:flutter/material.dart';

class SahaEmptyWidget extends StatelessWidget {
  final String? tile;
  final String? subtitle;

  const SahaEmptyWidget({Key? key, this.tile, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Không có dữ liệu"),
    );
  }
}
