import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/model/filter_order.dart';
import 'package:com.ikitech.store/app_user/screen2/order/filter_order/filter_order_screen.dart';

import 'list_filter_order_controller.dart';

class ListFilterOrderScreen extends StatelessWidget {
  ListFilterOrderController filterController = ListFilterOrderController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Bộ lọc được lưu"),
      ),
      body: Obx(
        () => Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ReorderableListView(
                  onReorder: (int oldIndex, int newIndex) {
                    filterController.changeIndex(oldIndex, newIndex);
                  },
                  children: [
                    ...List.generate(
                        filterController.listFilter.length,
                        (index) => itemFilter(
                            filterController.listFilter[index], index)),
                  ]),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        color: Colors.white,
        child: Column(
          children: [
            SahaButtonFullParent(
              text: "Thêm bộ lọc",
              onPressed: () {
                Get.to(() => filterOrderScreen(isEdit: true))!
                    .then((value) => {filterController.getFilters()});
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget itemFilter(FilterOrder filterOrder, int index) {
    return Card(
      key: ValueKey(filterOrder),
      elevation: 2,
      child: ListTile(
          title: Text(filterOrder.name ?? ""),
          onTap: () {
            Get.to(() => filterOrderScreen(
                      isEdit: true,
                      filterOrderInput: filterOrder,
                      indexFilter: index,
                    ))!
                .then((value) => {filterController.getFilters()});
          },
          leading: Icon(
            Icons.list,
            color: Colors.black,
          ),
          trailing: InkWell(
            onTap: () {
              SahaDialogApp.showDialogYesNo(
                  mess: "Bạn có chắc muốn xoá bộ lọc này chứ",
                  onOK: () {
                    filterController.deleteFilter(index);
                  });
              // layoutSortChangeController.changeHide(e);
            },
            child: Icon(Icons.delete),
          )),
    );
  }
}
