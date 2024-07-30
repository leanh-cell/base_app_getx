import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/decentralization.dart';

class ConfigDecentralizationController extends GetxController {
  var decentralization = RxList<Decentralization>();

  ConfigDecentralizationController() {
    getListDecentralization();
  }

  Future<void> getListDecentralization() async {
    try {
      var data = await RepositoryManager.decentralizationRepository
          .getListDecentralization();
      decentralization(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteDecentralization(int idDecentralization) async {
    try {
      var data = await RepositoryManager.decentralizationRepository
          .deleteDecentralization(idDecentralization);
      getListDecentralization();
      SahaAlert.showSuccess(message: "Đã xoá");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
