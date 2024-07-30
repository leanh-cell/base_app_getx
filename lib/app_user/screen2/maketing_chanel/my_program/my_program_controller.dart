import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/handle_error.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/discount_product_list.dart';

class MyProgramController extends GetxController {
  var isRefreshingData = false.obs;
  var isDeletingDiscount = false.obs;
  var isEndDiscount = false.obs;
  var listProgramIsComing = RxList<DiscountProductsList>();
  var listProgramIsRunning = RxList<DiscountProductsList>();
  var listProgramIsEnd = RxList<DiscountProductsList>();
  var listAll = RxList<List<DiscountProductsList>>([[], [], []]);
  var listAllSaveStateBefore = RxList<List<DiscountProductsList>>([[], [], []]);
  var hasDiscounted = false.obs;
  var listCheckHasDiscountState = RxList<bool>([false, false, false]);
  DateTime timeNow = DateTime.now();

  var pageLoadMore = 1;
  var isEndPageDiscount = false;

  Future<void> getAllDiscount() async {
    DateTime timeNow = DateTime.now();
    try {
      var res = await RepositoryManager.marketingChanel.getAllDiscount();

      if (res!.data!.isNotEmpty) {
        hasDiscounted.value = true;
      }

      res.data!.forEach((element) {
        if (element.startTime!.isAfter(timeNow)) {
          listProgramIsComing.add(element);
        } else {
          if (element.endTime!.isAfter(timeNow)) {
            listProgramIsRunning.add(element);
          }
          // else {
          //   listProgramIsEnd.value.add(element);
          // }
        }
      });

      listAll[0] = listProgramIsComing;
      listAll[1] = listProgramIsRunning;
      listAll[2] = listProgramIsEnd;
      listAllSaveStateBefore.value = listAll;
    } catch (err) {
      handleError(err);
    }
  }

  void loadInitEndDiscount() {
    pageLoadMore = 1;
    isEndPageDiscount = false;
    listProgramIsEnd([]);
    loadMoreEndDiscount();
  }

  Future<void> loadMoreEndDiscount() async {
    try {
      var res = await RepositoryManager.marketingChanel
          .getEndDiscountFromPage(pageLoadMore);

      if (!isEndPageDiscount) {
        res!.data!.data!.forEach((element) {
          listProgramIsEnd.add(element);
        });
      } else {
        return;
      }

      listAll[2] = listProgramIsEnd;
      listAllSaveStateBefore = listAll;
      if (res.data!.nextPageUrl != null) {
        pageLoadMore++;
        isEndPageDiscount = false;
      } else {
        isEndPageDiscount = true;
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> refreshData() async {
    isRefreshingData.value = true;
    listProgramIsComing = RxList<DiscountProductsList>();
    listProgramIsRunning = RxList<DiscountProductsList>();
    listAll = RxList<List<DiscountProductsList>>(
        [listProgramIsComing, listProgramIsRunning, listProgramIsEnd]);
    getAllDiscount();

    isRefreshingData.value = false;
  }

  Future<void> endDiscount(
    int? idDiscount,
    bool isEnd,
    String name,
    String description,
    String imageUrl,
    String startTime,
    String endTime,
    double value,
    bool setLimitedAmount,
    int amount,
    int? groups,
    int? agencyTypeId,
    int? groupTypeId,
    String? agencyTypeName,
    String? groupTypeName,
    String listIdProduct,
  ) async {
    isEndDiscount.value = true;
    try {
      var data = await RepositoryManager.marketingChanel.updateDiscount(
        idDiscount,
        isEnd,
        name,
        description,
        imageUrl,
        startTime,
        endTime,
        value,
        setLimitedAmount,
        amount,
        [],
        [],
        [],
        listIdProduct,
      );
      SahaAlert.showSuccess(message: "Thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isEndDiscount.value = false;
    refreshData();
  }

  Future<void> deleteDiscount(
    int? idDiscount,
  ) async {
    isDeletingDiscount.value = true;
    try {
      var data = await RepositoryManager.marketingChanel.deleteDiscount(
        idDiscount,
      );
      SahaAlert.showSuccess(message: "Xoá thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isDeletingDiscount.value = false;
    refreshData();
  }
}
