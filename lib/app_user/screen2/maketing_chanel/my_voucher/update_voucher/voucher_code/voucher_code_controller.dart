import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/voucher_code.dart';
import 'package:get/get.dart';

class VoucherCodeController extends GetxController {
  final int voucherId;
  var loadInit = false.obs;
  int currentPage = 1;
  bool isEnd = false;
  var status = 0;
  var listVoucherCode = RxList<VoucherCode>();
  var isLoading = false.obs;
  var isShutdown = false.obs;
  String? textSearch;
  var listCodeChoose = <int>[].obs;
  VoucherCodeController({required this.voucherId}) {
    getAllVoucherCode(isRefresh: true);
  }

  Future<void> getAllVoucherCode({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        loadInit.value = true;
        isLoading.value = true;
        var data = await RepositoryManager.marketingChanel.getAllVoucherCode(
            page: currentPage,
            voucherId: voucherId,
            status: status,
            search: textSearch);

        if (isRefresh == true) {
          listVoucherCode(data!.data!.data!);
        } else {
          listVoucherCode.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      isLoading.value = false;
      loadInit.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> endVoucherCode() async {
    if(listCodeChoose.isEmpty){
      SahaAlert.showError(message: "Bạn chưa chọn mã nào");
      return;
    }
    try {
      var res = await RepositoryManager.marketingChanel
          .endVoucherCode(voucherId: voucherId, voucherIds: listCodeChoose);
      getAllVoucherCode(isRefresh: true);
      SahaAlert.showSuccess(message: "Thành công");
    }  catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}
