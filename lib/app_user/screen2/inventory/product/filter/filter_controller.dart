import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';

import '../../../../components/saha_user/toast/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';

class FilterController extends GetxController {
  var loading = false.obs;
  var listCategory = RxList<Category>();
  var isFilterOutOfStock = false.obs;
  var categoryChoose = RxList<Category>();
  var categoryChildChoose = RxList<Category>();

  List<Category>? categoryInput;
  List<Category>? categoryChildInput;
  bool? isNearOutOfStock;
  FilterController({this.categoryChildInput, this.categoryInput,this.isNearOutOfStock}) {
    if (categoryInput != null) {
      categoryChoose(categoryInput);
    }

    if (categoryChildInput != null) {
      categoryChildChoose(categoryChildInput);
    }
    if(isNearOutOfStock != null){
      isFilterOutOfStock.value = isNearOutOfStock!;
    }
    

    getAllCategory();
  }

  Future<void> getAllCategory() async {
    loading(true);
    try {
      var list = await RepositoryManager.categoryRepository.getAllCategory();
      listCategory(list!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading(false);
  }
}
