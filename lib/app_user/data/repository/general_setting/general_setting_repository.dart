import 'package:com.ikitech.store/app_user/data/remote/response-request/general_setting/general_settings_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/data/repository/handle_error.dart';
import 'package:com.ikitech.store/app_user/model/general_setting.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';

class GeneralSettingRepository {
  Future<GeneralSettingsRes?> getGeneralSettings() async {
    try {
      var res = await SahaServiceManager().service!.getGeneralSettings(
            UserInfo().getCurrentStoreCode(),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<GeneralSettingsRes?> editGeneralSettings(
      GeneralSetting generalSetting) async {
    try {
      var res = await SahaServiceManager().service!.editGeneralSettings(
          UserInfo().getCurrentStoreCode(), generalSetting.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
