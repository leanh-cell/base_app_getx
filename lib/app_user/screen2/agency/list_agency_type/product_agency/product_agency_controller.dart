import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

import '../../../../model/agency_type.dart';

class ProductAgencyController extends GetxController {
  var loading = false.obs;
  var listProduct = RxList<Product>();
  List<Category>? categoryChoose;
  List<Category>? categoryChildChoose;

  int currentPage = 1;
  bool isEndLoadMore = false;
  AgencyType agencyTypeRequest;
  Function? updateTotal;
  String searchText = "";
  var listProductChoose = RxList<Product>();
  var typeChoose = 0.obs;
  var isShowCheckbox = false.obs;

  ProductAgencyController({required this.agencyTypeRequest}) {
    getAllProduct();
  }

  Future<bool?> getAllProduct({
    bool isLoadMore = false,
    bool isRefresh = false,
    bool isUpdateTotal = false,
    String search = "",
  }) async {
    searchText = search;

    if (isRefresh == true) {
      currentPage = 1;
      isEndLoadMore = false;
    } else if (!isLoadMore && !isUpdateTotal) {
      isEndLoadMore = false;
      loading.value = true;
      currentPage = 1;
    }

    if (isEndLoadMore && !isUpdateTotal) {
      return false;
    }

    try {
      var data = await RepositoryManager.productRepository.getAllProduct(
        search: searchText,
        page: isLoadMore ? currentPage : 1,
        agencyTypeId: agencyTypeRequest.id!,
        idCategory: (categoryChoose ?? [])
            .map((e) => e.id)
            .toString()
            .replaceAll("(", "")
            .replaceAll(")", ""),
        categoryChildrenIds: (categoryChildChoose ?? [])
            .map((e) => e.id)
            .toString()
            .replaceAll("(", "")
            .replaceAll(")", ""),
        filterBy: '',
        filterByValue: '',
        sortBy: '',
      );

      var list = data!.data;

      if (list!.length < 20) {
        isEndLoadMore = true;
      }
      currentPage++;

      if (isLoadMore == false) {
        listProduct(list);
      } else {
        listProduct.addAll(list);
      }

      loading.value = false;
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading.value = false;
  }

  Future<bool?> editOverridePriceAgency(
      {required double commissionPercent}) async {
    try {
      var data = await RepositoryManager.agencyRepository
          .editOverridePriceAgency(agencyTypeRequest.id!, commissionPercent,
              listProductChoose.map((e) => e.id!).toList());
      for (int i = 0; i < listProductChoose.length; i++) {
        var index = listProduct
            .map((e) => e.id)
            .toList()
            .indexWhere((e) => e == listProductChoose[i].id);

        if (index != -1) {
          listProduct[index].agencyPrice?.mainPrice =
              (listProduct[index].minPrice ?? 0) -
                  ((listProduct[index].minPrice ?? 0) *
                      (commissionPercent / 100));
          listProduct[index].agencyPrice?.minPrice =
              (listProduct[index].minPrice ?? 0) -
                  ((listProduct[index].minPrice ?? 0) *
                      (commissionPercent / 100));
          listProduct[index].agencyPrice?.maxPrice =
              (listProduct[index].maxPrice ?? 0) -
                  ((listProduct[index].maxPrice ?? 0) *
                      (commissionPercent / 100));
          listProduct.refresh();
        }
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<bool?> editPercentAgency(
      {required double percentAgency, bool? isAll}) async {
    try {
      var data = await RepositoryManager.agencyRepository.editPercentAgency(
        agencyTypeRequest.id!,
        percentAgency,
        listProductChoose.map((e) => e.id!).toList(),
        isAll ?? false,
      );
      for (int i = 0; i < listProductChoose.length; i++) {
        var index = listProduct
            .map((e) => e.id)
            .toList()
            .indexWhere((e) => e == listProductChoose[i].id);

        if (index != -1) {
          listProduct[index].agencyPrice?.percentAgency = percentAgency;
          listProduct.refresh();
        }
      }
      //  getAllProduct(isRefresh: true);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> editAllPrice(double commissionPercent) async {
    try {
      var data = await RepositoryManager.agencyRepository.updateAgencyType(
          idAgency: agencyTypeRequest.id!,
          name: agencyTypeRequest.name ?? '',
          commissionPercent: commissionPercent);
      getAllProduct(isRefresh: true);
      SahaAlert.showSuccess(message: "Thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
