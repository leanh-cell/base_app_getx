import 'package:com.ikitech.store/app_user/data/remote/response-request/store/all_store_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import '../handle_error.dart';

class StoreRepository {
  Future<Store?> create(String? storeCode,
      {String? nameShop,
      String? address,
      int? idTypeShop,
      int? idCareer,
      String? code}) async {
    try {
      var res = await SahaServiceManager().service!.createStore({
        "name": nameShop,
        "store_code": code,
        "address": address,
        "id_type_of_store": idTypeShop,
        "career": idCareer
      });
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<Store?> update(String? storeCode,
      {String? nameShop,
      String? address,
      int? idTypeShop,
      int? idCareer,
      String? logoUrl}) async {
    try {
      var res = await SahaServiceManager().service!.updateStore(storeCode, {
        "name": nameShop,
        "logo_url": logoUrl,
        "address": address,
        "id_type_of_store": idTypeShop,
        "career": idCareer
      });
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<Store?> getOne(String? storeCode) async {
    try {
      var res = await SahaServiceManager().service!.getStore(storeCode);
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<List<Store>?> getAll() async {
    try {
      var res = await SahaServiceManager().service!.getAllStore();
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }
}
