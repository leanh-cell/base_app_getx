import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/handle_error.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/voucher_request.dart';
import 'package:com.ikitech.store/app_user/model/voucher.dart';

class MyVoucherController extends GetxController {
  var isRefreshingData = false.obs;
  var isDeletingDiscount = false.obs;
  var isEndDiscount = false.obs;
  var listVoucherIsComing = RxList<Voucher>();
  var listVoucherIsRunning = RxList<Voucher>();
  var listVoucherIsEnd = RxList<Voucher>();
  var listAll = RxList<List<Voucher>>([[], [], []]);
  var listAllSaveStateBefore = RxList<List<Voucher>>([[], [], []]);
  var listCheckHasDiscountState = RxList<bool>([false, false, false]);
  var pageLoadMore = 1;
  var isEndPageVoucher = false;
  var isLoadMore = false.obs;
  DateTime timeNow = DateTime.now();

  Future<void> getAllVoucher() async {
    DateTime timeNow = DateTime.now();
    try {
      var res = await RepositoryManager.marketingChanel.getAllVoucher();

      res!.data!.forEach((element) {
        if (element.startTime!.isAfter(timeNow)) {
          listVoucherIsComing.add(element);
        } else {
          if (element.endTime!.isAfter(timeNow)) {
            listVoucherIsRunning.add(element);
          }
          // else {
          //   listVoucherIsEnd.value.add(element);
          // }
        }
      });

      listAll[0] = listVoucherIsComing;
      listAll[1] = listVoucherIsRunning;
      listAll[2] = listVoucherIsEnd;
      listAllSaveStateBefore.value = listAll;
    } catch (err) {
      handleError(err);
    }
  }

  Future<void> refreshData() async {
    isRefreshingData.value = true;
    listVoucherIsComing = RxList<Voucher>();
    listVoucherIsRunning = RxList<Voucher>();
    listAll = RxList<List<Voucher>>([[], [], []]);
    await getAllVoucher();
    isRefreshingData.value = false;
  }

  void loadInitEndVoucher() {
    pageLoadMore = 1;
    isEndPageVoucher = false;
    listVoucherIsEnd([]);
    loadMoreEndVoucher();
  }

  Future<void> loadMoreEndVoucher() async {
    isLoadMore.value = true;
    try {
      var res = await RepositoryManager.marketingChanel
          .getEndVoucherFromPage(pageLoadMore);

      if (!isEndPageVoucher) {
        res!.data!.data!.forEach((element) {
          listVoucherIsEnd.add(element);
        });
      } else {
        isLoadMore.value = false;
        return;
      }

      listAll[2] = listVoucherIsEnd;
      listAllSaveStateBefore = listAll;
      if (res.data!.nextPageUrl != null) {
        pageLoadMore++;
        isEndPageVoucher = false;
      } else {
        isEndPageVoucher = true;
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadMore.value = false;
  }

  Future<void> endVoucher(int? idVoucher) async {
    try {
      var data = await RepositoryManager.marketingChanel
          .updateVoucher(idVoucher, VoucherRequest(isEnd: true));
      SahaAlert.showSuccess(message: "Thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    refreshData();
  }

  Future<void> deleteVoucher(
    int? idVoucher,
  ) async {
    isDeletingDiscount.value = true;
    try {
      var data = await RepositoryManager.marketingChanel.deleteVoucher(
        idVoucher,
      );
      SahaAlert.showSuccess(message: "Xoá thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isDeletingDiscount.value = false;
    refreshData();
  }
}
