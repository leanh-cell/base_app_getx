import 'package:com.ikitech.store/app_user/model/transfer_stock.dart';
import 'package:get/get.dart';

import '../../../components/saha_user/toast/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';
import '../../../utils/finish_handle_utils.dart';

class TransferStockController extends GetxController {
  var listTransferStock = RxList<TransferStock>();
  int currentPage = 1;
  String? textSearch;
  bool isEnd = false;
  var isLoading = false.obs;
  var isLoadingInit = false.obs;

  var finish = FinishHandle(milliseconds: 500);

  TransferStockController() {
    isLoadingInit.value = true;
    getAllTransferStocksSender(isRefresh: true);
    getAllTransferStocksRCV(isRefresh: true);
  }

  Future<void> getAllTransferStocksRCV({
    bool? isRefresh,
  }) async {
    finish.run(() async {
      if (isRefresh == true) {
        currentPage = 1;
        isEnd = false;
      }

      try {
        if (isEnd == false) {
          isLoading.value = true;
          var data = await RepositoryManager.transferStockRepository
              .getAllTransferStocksRCV(
            search: textSearch,
            page: currentPage,
          );

          if (isRefresh == true) {
            listTransferStock(data!.data!.data!);
          } else {
            listTransferStock.addAll(data!.data!.data!);
          }

          if (data.data!.nextPageUrl == null) {
            isEnd = true;
          } else {
            isEnd = false;
            currentPage = currentPage + 1;
          }
        }
        isLoading.value = false;
      } catch (err) {
        SahaAlert.showError(message: err.toString());
      }
    });
  }

  /// sender

  var listTransferStockSender = RxList<TransferStock>();
  int currentPageSender = 1;
  String? textSearchSender;
  bool isEndSender = false;
  var isLoadingSender = false.obs;

  var finishSender = FinishHandle(milliseconds: 500);

  Future<void> getAllTransferStocksSender({
    bool? isRefresh,
  }) async {
    finishSender.run(() async {
      if (isRefresh == true) {
        currentPageSender = 1;
        isEndSender = false;
      }

      try {
        if (isEndSender == false) {
          isLoadingSender.value = true;
          var data = await RepositoryManager.transferStockRepository
              .getAllTransferStocksSender(
            search: textSearchSender,
            page: currentPageSender,
          );

          if (isRefresh == true) {
            listTransferStockSender(data!.data!.data!);
          } else {
            listTransferStockSender.addAll(data!.data!.data!);
          }

          if (data.data!.nextPageUrl == null) {
            isEndSender = true;
          } else {
            isEndSender = false;
            currentPageSender = currentPageSender + 1;
          }
        }
        isLoadingSender.value = false;
        isLoadingInit.value = false;
      } catch (err) {
        SahaAlert.showError(message: err.toString());
      }
    });
  }
}
