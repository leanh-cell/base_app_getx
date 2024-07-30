import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty_widget/empty_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'layout_sort_controller.dart';

class LayoutSortChangeScreen extends StatelessWidget {
  LayoutSortChangeController layoutSortChangeController =
      new LayoutSortChangeController();
  final Function(List<String>)? onData;

  TextEditingController textEditingController = new TextEditingController();

  LayoutSortChangeScreen({Key? key, this.onData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
          appBar: SahaAppBar(
            titleText: "Sắp xếp bố cục",
          ),
          body: Obx(
            () => layoutSortChangeController.loading.value
                ? SahaLoadingFullScreen()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Obx(() {
                            var list =
                                layoutSortChangeController.listLayout.toList();
                            if (list == null || list.length == 0) {
                              return SahaEmptyWidget(
                                tile: "Không có mục nào",
                              );
                            }

                            return ReorderableListView(
                              children: list
                                  .map(
                                    (e) => Card(
                                      key: ValueKey(e),
                                      elevation: 2,
                                      child: ListTile(
                                        title: Text(e.title ?? ""),
                                        leading: Icon(
                                          Icons.list,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onReorder: (oldIndex, newIndex) {
                                layoutSortChangeController.changeIndex(
                                    oldIndex, newIndex);
                              },
                            );
                          }),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
          )),
    );
  }
}

class ItemAttributeWidget extends StatelessWidget {
  final String? attribute;

  const ItemAttributeWidget({Key? key, this.attribute}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text(attribute!),
      ),
    );
  }
}
