import 'package:com.ikitech.store/app_user/data/remote/response-request/home_data/home_data_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';

import '../handle_error.dart';

class HomeDataRepository {

  Future<HomeDataUser?> getHomeData() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getHomeDataUser();
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

}
