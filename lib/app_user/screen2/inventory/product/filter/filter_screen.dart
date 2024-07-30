import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';

import '../../../../components/saha_user/button/saha_button.dart';
import 'filter_controller.dart';

class FilterScreen extends StatelessWidget {
  Function onFilter;

  List<Category>? categoryInput;
  List<Category>? categoryChildInput;
  bool? isNearOutOfStock;

  FilterScreen(
      {required this.onFilter,
      this.categoryInput,
      this.categoryChildInput,
      this.isNearOutOfStock}) {
    filterController = FilterController(
        categoryInput: categoryInput,
        categoryChildInput: categoryChildInput,
        isNearOutOfStock: isNearOutOfStock);
  }

  late FilterController filterController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lọc'),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              //filterOutOfStock(),
              ...filterController.listCategory.map((e) => itemCate(e))
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: SahaButtonFullParent(
                  color: Colors.white,
                  textColor: Colors.black87,
                  colorBorder: Colors.grey[500],
                  text: "Bỏ lọc",
                  onPressed: () {
                    filterController.categoryChoose([]);
                    filterController.categoryChildChoose([]);
                    filterController.isFilterOutOfStock.value = false;
                    onFilter(
                        filterController.categoryChoose.toList(),
                        filterController.categoryChildChoose.toList(),
                        filterController.isFilterOutOfStock.value);
                  },
                ),
              ),
              Expanded(
                child: SahaButtonFullParent(
                  text: "Lọc",
                  onPressed: () {
                    print(filterController.categoryChoose.length);
                    onFilter(
                        filterController.categoryChoose.toList(),
                        filterController.categoryChildChoose.toList(),
                        filterController.isFilterOutOfStock.value);
                   
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget itemCate(Category category) {
    var expanded = true.obs;
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ]),
      child: Obx(
        () => Column(
          children: [
            Row(
              children: [
                Checkbox(
                    value: filterController.categoryChoose
                        .map((e) => e.id)
                        .contains(category.id),
                    onChanged: (v) {
                      if (filterController.categoryChoose
                          .map((e) => e.id)
                          .contains(category.id)) {
                        filterController.categoryChoose
                            .removeWhere((e) => e.id == category.id);
                      } else {
                        filterController.categoryChoose.add(category);
                      }
                    }),
                Expanded(
                  child: Text(
                    category.name ?? "",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      expanded.value = !expanded.value;
                    },
                    icon: Icon(expanded.value
                        ? Icons.keyboard_arrow_down_rounded
                        : Icons.navigate_next_rounded))
              ],
            ),
            if (expanded.value)
              Divider(
                height: 1,
              ),
            if (expanded.value)
              ...(category.listCategoryChild ?? []).map(
                (c) => Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Checkbox(
                        value: filterController.categoryChildChoose
                            .map((e) => e.id)
                            .contains(c.id),
                        onChanged: (v) {
                          if (filterController.categoryChildChoose
                              .map((e) => e.id)
                              .contains(c.id)) {
                            filterController.categoryChildChoose
                                .removeWhere((e) => e.id == c.id);
                          } else {
                            filterController.categoryChildChoose.add(c);
                          }
                        }),
                    Expanded(child: Text(c.name ?? ""))
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget filterOutOfStock() {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ]),
      child: Row(
        children: [
          Checkbox(
              value: filterController.isFilterOutOfStock.value,
              onChanged: (v) {
                filterController.isFilterOutOfStock.value = v!;
              }),
          Text(
            "Sản phẩm sắp hết hàng",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
