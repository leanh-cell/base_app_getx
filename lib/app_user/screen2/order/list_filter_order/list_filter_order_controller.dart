import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:com.ikitech.store/app_user/model/filter_order.dart';

class ListFilterOrderController extends GetxController {
  var listFilter = RxList<FilterOrder>();
  final filtersBox = Hive.box('filters');

  ListFilterOrderController() {
    getFilters();
  }

  void getFilters() async {
    var box = await Hive.openBox('filters');
    print(box.values);
    listFilter([]);
    box.values.forEach((element) {
      listFilter.add(element);
    });
  }

  void changeIndex(int oldIndex, int newIndex) {
    var pre = listFilter[oldIndex];
    print(oldIndex);
    print(newIndex);

    if (oldIndex > newIndex) {
      filtersBox.putAt(oldIndex, listFilter[(newIndex) < 0 ? 0 : newIndex]);
      filtersBox.putAt((newIndex) < 0 ? 0 : newIndex, listFilter[oldIndex]);
      listFilter.removeAt(oldIndex);
      listFilter.insert((newIndex) < 0 ? 0 : newIndex, pre);
    } else {
      filtersBox.putAt(
          oldIndex, listFilter[(newIndex - 1) < 0 ? 0 : newIndex - 1]);
      filtersBox.putAt(
          (newIndex - 1) < 0 ? 0 : newIndex - 1, listFilter[oldIndex]);
      listFilter.removeAt(oldIndex);
      listFilter.insert((newIndex - 1) < 0 ? 0 : newIndex - 1, pre);
      print((newIndex - 1) < 0 ? 0 : newIndex - 1);
    }
    listFilter.refresh();
  }

  void deleteFilter(int index) {
    filtersBox.deleteAt(index);
    listFilter.removeAt(index);
  }
}
