import 'package:com.ikitech.store/app_user/data/remote/response-request/config_ui/banner_ads_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/success/success_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';
import 'package:sahashop_customer/app_customer/model/banner_ads.dart';
import 'package:sahashop_customer/app_customer/model/button_home.dart';
import 'package:sahashop_customer/app_customer/model/config_app.dart';
import 'package:sahashop_customer/app_customer/model/home_data.dart';
import '../../remote/response-request/config_ui/all_banner_ads_res.dart';
import '../handle_error.dart';

class ConfigUIRepository {
  Future<ConfigApp?> createAppTheme(ConfigApp configApp) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .createAppTheme(UserInfo().getCurrentStoreCode(), configApp.toJson());
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ConfigApp?> getAppTheme() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAppTheme(UserInfo().getCurrentStoreCode());
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<List<HomeButton>?> updateAppButton(List<HomeButton> listButton) async {
    try {
      var res = await SahaServiceManager().service!.updateAppButton(
          UserInfo().getCurrentStoreCode(),
          {"home_buttons": listButton.map((e) => e.toJson()).toList()});
      return res.buttons;
    } catch (err) {
      handleError(err);
    }
  }

  Future<List<LayoutHome>?> updateLayoutSort(
      List<LayoutHome> listButton) async {
    try {
      var res = await SahaServiceManager().service!.updateLayoutSort(
          UserInfo().getCurrentStoreCode(),
          {"layouts": listButton.map((e) => e.toJson()).toList()});
      return res.buttons;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllBannerAdsRes?> getAllBannerAds() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllBannerAds(UserInfo().getCurrentStoreCode());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<BannerAdsRes?> createBannerAds(BannerAds bannerAds) async {
    try {
      var res = await SahaServiceManager().service!.createBannerAds(
          UserInfo().getCurrentStoreCode(), bannerAds.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<BannerAdsRes?> updateBannerAds(
      int bannerAdsId, BannerAds bannerAds) async {
    try {
      var res = await SahaServiceManager().service!.updateBannerAds(
            UserInfo().getCurrentStoreCode(),
            bannerAdsId,
            bannerAds.toJson(),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> deleteBannerAds (int bannerAdsId,) async {
    try {
      var res = await SahaServiceManager().service!.deleteBannerAds(
        UserInfo().getCurrentStoreCode(),
        bannerAdsId,
      );
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
