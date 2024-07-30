import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:sahashop_customer/app_customer/model/agency_type.dart';

import '../../../../model/agency.dart';

class TopAgencyController extends GetxController {
  var isSearch = false.obs;
  var isLoadMore = false.obs;
  int currentPage = 1;
  bool isEndOrder = false;
  var isLoadRefresh = true.obs;
  var listTopAgency = RxList<Agency>();
  var dateFrom = DateTime.now().obs;
  var dateTo = DateTime.now().obs;
  String? textSearch;
  AgencyType? agencyType;
  int? indexTabTimeSave;
  int? indexChooseSave;
  var reportType = 'order'.obs;
  bool? isCtv;

  TopAgencyController({this.isCtv}) {
    if (isCtv == true) {
      reportType.value = 'sum_share_agency';
    }
    dateFrom.value = DateTime(dateTo.value.year, dateTo.value.month, 1);
  }

  Future<void> getTopAgency({String? searchText, bool? isRefresh}) async {
    if (isRefresh == true) {
      isLoadRefresh.value = true;
      listTopAgency([]);
      currentPage = 1;
      isEndOrder = false;
    } else {
      isLoadMore.value = true;
    }

    try {
      if (isEndOrder == false) {
        var data = await RepositoryManager.agencyRepository.getTopAgency(
            search: searchText,
            sortBy: reportType.value,
            page: currentPage,
            descending: true,
            timeFrom: dateFrom.value.toIso8601String(),
            timeTo: dateTo.value.toIso8601String(),
            reportType: 'order',
            isCtv: isCtv);

        data!.data!.data!.forEach((e) {
          listTopAgency.add(e);
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
