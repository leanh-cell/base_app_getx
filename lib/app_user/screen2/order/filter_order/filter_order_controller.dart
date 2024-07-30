import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/model/branch.dart';
import 'package:com.ikitech.store/app_user/model/filter_order.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';
import 'package:com.ikitech.store/saha_data_controller.dart';

import '../../../data/repository/repository_manager.dart';
import '../../../model/staff.dart';

class FilterOrderController extends GetxController {
  var expBranch = true.obs;
  var expStatus = true.obs;
  var expPayment = true.obs;
  var expStaff = true.obs;
  var exp = false.obs;
  var page = 0.obs;
  int indexTabTime = 0;
  int indexChooseTime = 0;
  int? indexFilter;
  var listFilter = RxList<FilterOrder>();
  var filterOrder = FilterOrder(
      listBranch: [], listOrderStt: [], listPaymentStt: [], listSource: []).obs;

  FilterOrder? filterOrderInput;
  SahaDataController sahaDataController = Get.find();

  var listStaff = RxList<Staff>();
  var listStaffChoose = RxList<Staff>();
  var loading = false.obs;
  List<Staff>? listStaffInput;

  FilterOrderController({this.filterOrderInput, this.indexFilter}) {
    getFilters();
    getListStaff();
    if (filterOrderInput != null) {
      filterOrder.value = filterOrderInput!;
    }
  }

  Future<void> getListStaff() async {
    loading.value = true;
    try {
      var data =
          await RepositoryManager.staffRepository.getListStaff(isSale: true);

      listStaff(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading.value = false;
  }

  void getFilters() async {
    var box = await Hive.openBox('filters');
    print(box.values);
    listFilter([]);
    box.values.forEach((element) {
      listFilter.add(element);
    });
  }

  void addFilter() async {
    final printersBox = Hive.box('filters');
    if (filterOrderInput != null) {
      printersBox.putAt(indexFilter!, filterOrder.value);
      Get.back(result: "success");
    } else {
      if (listFilter.map((e) => e.name).contains(filterOrder.value.name)) {
        SahaAlert.showToastMiddle(message: "Bộ lọc đã trùng tên");
        return;
      }
      printersBox.add(filterOrder.value);
      Get.back(result: "success");
    }
  }

  bool checkBranch(Branch branch) {
    if (filterOrder.value.listBranch!.map((e) => e.id).contains(branch.id)) {
      return true;
    } else {
      return false;
    }
  }

  bool checkOrderStt(String stt) {
    if (filterOrder.value.listOrderStt!.contains(stt)) {
      return true;
    } else {
      return false;
    }
  }

  bool checkPaymentStt(String stt) {
    if (filterOrder.value.listPaymentStt!.contains(stt)) {
      return true;
    } else {
      return false;
    }
  }
}
