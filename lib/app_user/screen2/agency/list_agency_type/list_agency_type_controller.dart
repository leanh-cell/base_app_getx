import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';

import '../../../model/agency_type.dart';


class ListAgencyController extends GetxController {
  var listAgencyType = RxList<AgencyType>();
  var editIndex = 9999.obs;

  ListAgencyController() {
    getAllAgencyType();
  }

  Future<void> getAllAgencyType() async {
    try {
      var data = await RepositoryManager.agencyRepository.getAllAgencyType();
      listAgencyType(data!.data);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> addAgencyType(String name) async {
    try {
      var data = await RepositoryManager.agencyRepository.addAgencyType(name);
      SahaAlert.showSuccess(message: "Thành công");
      getAllAgencyType();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateAgencyType(int idAgency, String name) async {
    try {
      var data = await RepositoryManager.agencyRepository
          .updateAgencyType(idAgency: idAgency, name: name);
      SahaAlert.showSuccess(message: "Thành công");
      getAllAgencyType();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteAgencyType(int idAgency) async {
    try {
      var data =
          await RepositoryManager.agencyRepository.deleteAgencyType(idAgency);
      SahaAlert.showSuccess(message: "Thành công");
      getAllAgencyType();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
