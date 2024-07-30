

import 'package:com.ikitech.store/app_user/data/remote/response-request/popup/list_popup_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/popup/update_popup_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/success/success_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/model/popup_config.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';

import '../handle_error.dart';

class PopupRepository {
  Future<ListPopupResponse?> getListPopup() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getListPopup(UserInfo().getCurrentStoreCode());
      return res;
    } catch (err) {
      handleError(err.toString());
    }
  }

  Future<SuccessResponse?> deletePopup(
    int idPopup,
  ) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deletePopup(UserInfo().getCurrentStoreCode(), idPopup);
      return res;
    } catch (err) {
      handleError(err.toString());
    }
  }

  Future<SuccessResponse?> addPopup(PopupCf popupCf) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .addPopup(UserInfo().getCurrentStoreCode(), popupCf.toJson());
      return res;
    } catch (err) {
      handleError(err.toString());
    }
  }

  Future<UpdatePopupResponse?> updatePopup(int idPopup, PopupCf popupCf) async {
    try {
      var res = await SahaServiceManager().service!.updatePopup(
          UserInfo().getCurrentStoreCode(), idPopup, popupCf.toJson());
      return res;
    } catch (err) {
      handleError(err.toString());
    }
  }
}
