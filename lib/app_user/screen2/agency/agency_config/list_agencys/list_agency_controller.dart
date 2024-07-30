import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:get/get.dart';


import '../../../../model/agency.dart';
import '../../../../model/agency_type.dart';

class ListAgencyController extends GetxController {
  var isSearch = false.obs;
  var isLoadMore = false.obs;
  int currentPage = 1;
  bool isEndOrder = false;
  var isLoadRefresh = true.obs;
  var listAgency = RxList<Agency>();
  var listStatus = RxList<bool>();
  String? textSearch;
  var isLoading = false.obs;
  var listAgencyType = RxList<AgencyType>();

  AgencyType? agencyTypeField;

  ListAgencyController() {
    getAllAgencyType();
  }

  Future<void> getAllAgencyType() async {
    try {
      isLoading.value = true;
      var data = await RepositoryManager.agencyRepository.getAllAgencyType();
      listAgencyType(data!.data);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }

  Future<void> updateAgency(
      {required int status,
      required int idAgency,
      required int index,
      AgencyType? agencyType}) async {
    try {
      var data = await RepositoryManager.agencyRepository
          .updateAgency(status, idAgency, agencyType?.id);
      listStatus[index] = data!.agency!.status == 1 ? true : false;
      listStatus.refresh();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getListAgency({String? searchText, bool? isRefresh}) async {
    if (isRefresh == true) {
      isLoadRefresh.value = true;
      listAgency([]);
      listStatus([]);
      currentPage = 1;
      isEndOrder = false;
    } else {
      isLoadMore.value = true;
    }

    try {
      if (isEndOrder == false) {
        var data = await RepositoryManager.agencyRepository.getListAgency(
          search: searchText,
          page: currentPage,
          descending: true,
          agencyTypeId: agencyTypeField?.id,
        );

        data!.data!.data!.forEach((e) {
          listAgency.add(e);
          listStatus.add(e.status == 1 ? true : false);
        });

        if (data.data!.nextPageUrl != null) {
          currentPage++;
          isEndOrder = false;
        } else {
          isEndOrder = true;
        }
      } else {
        isLoadMore.value = false;
        return;
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }

    isLoadMore.value = false;
    isLoadRefresh.value = false;
  }
}
