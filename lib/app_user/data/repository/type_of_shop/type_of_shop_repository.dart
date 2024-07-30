import 'package:com.ikitech.store/app_user/data/remote/response-request/store/type_store_respones.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';

import '../handle_error.dart';

class TypeOfShopRepository {
  Future<List<DataTypeShop>?> getAll() async {
    try {
      var res = await SahaServiceManager().service!.getAllTypeOfStore();
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }
}
