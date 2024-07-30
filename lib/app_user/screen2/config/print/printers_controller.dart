import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:com.ikitech.store/app_user/model/printer.dart';

class PrintersController extends GetxController {
  var listPrinter = RxList<Printer>();

  PrintersController() {
    getListPrint();
  }

  void getListPrint({bool? isRefresh}) async {
    if (isRefresh == true) {
      listPrinter([]);
    }
    var box = await Hive.openBox('printers');
    print(box.values);
    box.values.forEach((element) {
      listPrinter.add(element);
    });
  }

  void deletePrinter(int index) {
    final printersBox = Hive.box('printers');
    listPrinter.removeAt(index);
    printersBox.deleteAt(index);
  }

  void addPrinter(Printer printer) {
    final printersBox = Hive.box('printers');
    printersBox.add(printer);
  }
}
