import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/const/const_revenue_expenditure.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/import_stock.dart';
import 'package:com.ikitech.store/app_user/model/revenue_expenditure.dart';
import 'package:com.ikitech.store/app_user/model/supplier.dart';

class SuppliersProfileController extends GetxController {
  var listRevenueExpenditure = RxList<RevenueExpenditure>();
  Supplier supplier;
  var supplierShow = Supplier().obs;

  int currentPage = 1;
  String? textSearch;
  bool isEnd = false;
  var isLoading = false.obs;

  var listImportStock = RxList<ImportStock>();
  int currentPageImportStock = 1;
  bool isEndImportStock = false;
  var isLoadingImportStock = false.obs;

  SuppliersProfileController({required this.supplier}) {
    getSupplier();
    getAllRevenueExpenditure(isRefresh: true);
    getAllImportStock(isRefresh: true);
  }

  Future<void> getSupplier() async {
    try {
      var data = await RepositoryManager.supplierRepository
          .getSupplier(idSupplier: supplier.id);
      supplierShow.value = data!.data!;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getAllRevenueExpenditure({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    if (textSearch != null && textSearch != "") {
      currentPage = 1;
      listRevenueExpenditure([]);
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.revenueExpenditureRepository
            .getAllRevenueExpenditure(
                page: currentPage,
                recipientGroup: RECIPIENT_GROUP_SUPPLIER,
                recipientReferencesId: supplier.id);

        if (isRefresh == true) {
          listRevenueExpenditure(data!.data!.data!);
        } else {
          listRevenueExpenditure.addAll(data!.data!.data!);
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

  Future<void> getAllImportStock({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPageImportStock = 1;
      isEndImportStock = false;
    }

    try {
      if (isEndImportStock == false) {
        isLoadingImportStock.value = true;
        var data = await RepositoryManager.importStockRepository
            .getAllImportStock(
                currentPage: currentPageImportStock, supplierId: supplier.id);

        if (isRefresh == true) {
          listImportStock(data!.data!.data!);
        } else {
          listImportStock.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
        }
      }
      isLoadingImportStock.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
