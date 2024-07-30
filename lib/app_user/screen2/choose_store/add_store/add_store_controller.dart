import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/store/type_store_respones.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';


class AddStoreController extends GetxController {
  var creating = false.obs;
  var listDataTypeShop = RxList<DataTypeShop>();
  var listNameShop = RxList<String?>();
  var listNameChild = RxList<String?>();
  var mapTypShop = RxList<Map<String, String>>();
  var mapTypeChild = RxList<Map<String, String>>();
  var child = RxList<Map<String, String>>();
  Future<List<DataTypeShop>?> getAllShopType() async {
    try {
      var data =
          (await RepositoryManager.typeOfShopRepository.getAll())!;
      listDataTypeShop(data);
      for (var i in listDataTypeShop[0].childs!) {
        listNameChild.add(i.name);
        mapTypeChild.add({i.id.toString(): i.name!});
      }
      mapTypeChild.refresh();
    } catch (err) {}
  }

  Future<void> createShop(
      String nameShop, String address,int? idCareer, String code) async {
    creating.value = true;
    try {
      var dataCreateShop = await RepositoryManager.storeRepository.create(
          UserInfo().getCurrentStoreCode(),
          nameShop: nameShop,
          address: address,
          idTypeShop: 1,
          idCareer: idCareer,
          code: code);

      creating.value = false;
      Get.back(result: "create_success");
      return;
    } catch (e) {
      creating.value = false;
      SahaAlert.showError(message: e.toString());
      return;
    }
  }
}
