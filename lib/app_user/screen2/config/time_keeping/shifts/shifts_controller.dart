import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/shifts.dart';

class ShiftsController extends GetxController {
  var listShift = RxList<Shifts>();

  int currentPage = 1;
  String? textSearch;
  bool isEnd = false;
  var isLoading = false.obs;

  var listShiftsChoose = RxList<Shifts>();
  var listDisable = RxList<Shifts>();
  List<Shifts>? listShiftsInput;

  ShiftsController({this.listShiftsInput}) {
    if (listShiftsInput != null) {
      listShiftsChoose(listShiftsInput);
    }
    getListShift(isRefresh: true);
  }

  bool checkChoose(Shifts shifts) {
    if (listShiftsChoose.map((e) => e.id).toList().contains(shifts.id))
      return true;
    return false;
  }

  bool checkDuplicate(Shifts shifts) {
    listDisable([]);
    var check = false;
    for (var e in listShiftsChoose) {
      check = checkDuplicate2(shifts, e);
      if (check == true) {
        listDisable.add(shifts);
      }
    }
    if (listDisable.map((e) => e.id).contains(shifts.id)) {
      check = true;
    }
    return check;
  }

  bool checkDuplicate2(Shifts shifts1, Shifts shifts2) {
    var hasDaySame = false;
    for (var date in shifts1.daysOfWeekList ?? []) {
      if ((shifts2.daysOfWeekList ?? []).contains(date)) {
        hasDaySame = true;
        break;
      }
    }
    if (hasDaySame == false) {
      return false;
    } else {
      var start1 =
          (shifts1.startWorkHour ?? 0) * 100 + (shifts1.startWorkMinute ?? 0);
      var end1 =
          (shifts1.endWorkHour ?? 0) * 100 + (shifts1.endWorkMinute ?? 0);
      var start2 =
          (shifts2.startWorkHour ?? 0) * 100 + (shifts2.startWorkMinute ?? 0);
      var end2 =
          (shifts2.endWorkHour ?? 0) * 100 + (shifts2.endWorkMinute ?? 0);
      return !checkSpace(start1, end1, start2, end2);
    }
  }

  bool checkSpace(int start1, int end1, int start2, int end2) {
    if (start1 == start2) return false;

    if (start1 > start2) {
      if (start1 > end2) return true;
      return false;
    }

    if (start1 < start2) {
      if (end1 < start2) return true;
      return false;
    }

    return false;
  }

  Future<void> getListShift({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.timeKeepingRepository
            .getListShifts(page: currentPage);

        if (isRefresh == true) {
          listShift(data!.data!.data!);
        } else {
          listShift.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
        }
      }
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
