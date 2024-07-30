import 'package:flutter/material.dart';

import '../../../const/constant.dart';

class SearchField extends StatelessWidget {
  final Function? onSearch;
  final Function? onClick;

  const SearchField({
    Key? key,
    this.onSearch,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: SahaSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (value) => onSearch!(value),
        onTap: () {
          if (onClick != null) {
            onClick!();
          }
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Tìm kiếm ",
            prefixIcon: Icon(Icons.search)),
      ),
    );
  }
}
