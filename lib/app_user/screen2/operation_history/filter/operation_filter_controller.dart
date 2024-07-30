import 'package:com.ikitech.store/app_user/model/operation_filter.dart';
import 'package:get/get.dart';

import '../../../components/saha_user/toast/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';
import '../../../model/staff.dart';

class OperationFilterController extends GetxController {
  var operationFilter = OperationFilter().obs;
  OperationFilter? operationFilterInput;

  var listStaff = RxList<Staff>();

  var loading = false.obs;
  OperationFilterController({this.operationFilterInput}) {
    getListStaff();
    if (operationFilterInput != null) {
      operationFilter(operationFilterInput);
    }
  }

  Future<void> getListStaff() async {
    loading.value = true;
    try {
      var data = await RepositoryManager.staffRepository.getListStaff();
      listStaff(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading.value = false;
  }


}
