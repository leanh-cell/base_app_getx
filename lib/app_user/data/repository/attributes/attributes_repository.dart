import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';
import '../handle_error.dart';

class AttributesRepository {

  Future<List<String>?> getAllAttributes() async {
    try {
      var res = await SahaServiceManager()
          .service!
         .getAllAttributeFields(UserInfo().getCurrentStoreCode());
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<List<String>?> updateAttributes(List<String> listAttribute) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateAttributeFields(UserInfo().getCurrentStoreCode(),
      {
        "list":listAttribute
      }
      );
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }
}
