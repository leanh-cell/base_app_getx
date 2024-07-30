import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/model/branch.dart';
import 'package:com.ikitech.store/app_user/model/filter_order.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';
import 'package:com.ikitech.store/saha_data_controller.dart';

import '../../../../data/repository/repository_manager.dart';
import '../../../../model/filter_top_sale.dart';
import '../../../../model/staff.dart';


class FilterTopSaleController extends GetxController {
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
  var filterOrder = FilterTopSale(
     staffs: []).obs;

  FilterTopSale? filterOrderInput;
  SahaDataController sahaDataController = Get.find();

  var listStaff = RxList<Staff>();
  var listStaffChoose = RxList<Staff>();
  var loading = false.obs;
  List<Staff>? listStaffInput;

  FilterTopSaleController({this.filterOrderInput, this.indexFilter}) {
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

  bool checkStaff(Staff staff) {
    if (filterOrder.value.staffs!.map((e) => e.id).contains(staff.id)) {
      return true;
    } else {
      return false;
    }
  }


}
