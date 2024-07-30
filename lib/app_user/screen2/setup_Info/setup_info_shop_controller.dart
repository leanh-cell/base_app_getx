import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/store/type_store_respones.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';

class SetUpInfoShopController extends GetxController {
  var stateCreate = "".obs;
  var creating = false.obs;
  var listNameShop = RxList<String?>();
  var mapTypeShop = RxList<Map<String, String>>();

  Future<List<DataTypeShop>> getAllShopType() async {
    try {
      var listDataTypeShop =
      (await RepositoryManager.typeOfShopRepository.getAll())!;

      for (var i in listDataTypeShop) {
        listNameShop.add(i.name);
        mapTypeShop.add({i.id.toString(): i.name!});
      }
      listNameShop.refresh();
      return listDataTypeShop.toList();
    } catch (err) {
      throw(err.toString());
    }
  }

  Future<bool> createShop(
      String nameShop, String address, int? idType, String code) async {
    creating.value = true;
    try {
      var dataCreateShop = await RepositoryManager.storeRepository.create(
          UserInfo().getCurrentStoreCode(),
          nameShop: nameShop,
          address: address,
          idTypeShop: idType,
          code: code);

      creating.value = false;
      stateCreate.value = "success";
      return true;
    } catch (e) {
      creating.value = false;
      stateCreate.value = e.toString();
      stateCreate.refresh();
      return false;
    }
  }
}
