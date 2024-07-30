import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/theme_model.dart';
import 'package:com.ikitech.store/app_user/screen2/config_app/screens_config/font_type/font_data.dart';
import 'package:com.ikitech.store/app_user/utils/color.dart';
import 'package:sahashop_customer/app_customer/model/config_app.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/repository_widget_config.dart';
import 'package:sahashop_customer/app_customer/utils/text_theme.dart';

class ConfigController extends GetxController {
  ConfigApp configApp = ConfigApp();
  var currentTheme = ThemeData().obs;
  var indexTab = 0.obs;
  var isLoadingGet = false.obs;
  var isLoadingCreate = false.obs;
  var contactButton = RxList<SpeedDialChild>();

  @override
  void onInit() async {
    super.onInit();
    getAppTheme();
  }

  @override
  void onClose() {
    Get.changeTheme(SahaUserPrimaryTheme(Get.context!));
  }

  @override
  void refresh() {
  }

  @override
  void onReady() {
  }

  @override
  void update([List<Object>? ids, bool condition = true]) {
  }

  ConfigController() {
    currentTheme.value = ThemeData(
      primarySwatch: Colors.cyan,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  void setTab(int va) {
    indexTab.value = va;
  }

  void updateTheme() {
    currentTheme.value = ThemeData(
        textTheme: TextThemeUtil().textTheme(configApp.fontFamily ?? ''),
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(statusBarBrightness: Color(HexColor.getColorFromHex(configApp.colorMain1!))
              .computeLuminance() <
              0.5
              ? Brightness.dark
              : Brightness.light,),
          
        ),
        primarySwatch: MaterialColor(
          HexColor.getColorFromHex(configApp.colorMain1!),
          {
            50: HexColor(configApp.colorMain1!).withOpacity(0.1),
            100: HexColor(configApp.colorMain1!).withOpacity(0.2),
            200: HexColor(configApp.colorMain1!).withOpacity(0.3),
            300: HexColor(configApp.colorMain1!).withOpacity(0.4),
            400: HexColor(configApp.colorMain1!).withOpacity(0.5),
            500: HexColor(configApp.colorMain1!).withOpacity(0.6),
            600: HexColor(configApp.colorMain1!).withOpacity(0.7),
            700: HexColor(configApp.colorMain1!).withOpacity(0.8),
            800: HexColor(configApp.colorMain1!).withOpacity(0.9),
            900: HexColor(configApp.colorMain1!).withOpacity(1),
          },
        ));

    Get.changeTheme(currentTheme.value);
  }

  Future<bool?> getAppTheme({bool refresh = false}) async {
    try {
      if (refresh == false) isLoadingGet.value = true;
      var data = (await RepositoryManager.configUiRepository.getAppTheme())!;
      configApp.colorMain1 = data.colorMain1 ?? "#ff93b9b4";
      configApp.fontFamily =
      data.fontFamily != null && FONT_DATA.containsKey(data.fontFamily)
          ? data.fontFamily
          : FONT_DATA.keys.toList()[0];
      configApp.productItemType = data.productItemType ?? 0;
      if (configApp.productItemType! >
          RepositoryWidgetCustomer().LIST_ITEM_PRODUCT_WIDGET.length) {
        configApp.productItemType =
            RepositoryWidgetCustomer().LIST_ITEM_PRODUCT_WIDGET.length - 1;
      }
      configApp.carouselType = data.carouselType ?? 0;
      configApp.homePageType = data.homePageType ?? 0;
      configApp.categoryPageType = data.categoryPageType ?? 0;
      configApp.productPageType = data.productPageType ?? 0;
      configApp.logoUrl = data.logoUrl ?? "";
      configApp.phoneNumberHotline = data.phoneNumberHotline ?? "";
      configApp.contactEmail = data.contactEmail ?? "";
      configApp.idFacebook = data.idFacebook ?? "";
      configApp.idZalo = data.idZalo ?? "";
      configApp.isShowIconHotline = data.isShowIconHotline ?? false;
      configApp.isShowIconEmail = data.isShowIconEmail ?? false;
      configApp.isShowIconFacebook = data.isShowIconFacebook ?? false;
      configApp.isShowIconZalo = data.isShowIconZalo ?? false;
      configApp.carouselAppImages = data.carouselAppImages;
      configApp.typeButton = data.typeButton ?? 0;
      configApp.isScrollButton = data.isScrollButton ?? false;
      configApp.contactFanpage = data.contactFanpage ?? "";
      configApp.contactAddress = data.contactAddress ?? "";
      configApp.contactTimeWork = data.contactTimeWork ?? "";
      configApp.contactPhoneNumber = data.contactPhoneNumber ?? "";
      configApp.contactEmail = data.contactEmail ?? "";
      updateTheme();
      isLoadingGet.value = false;
      return true;
    } catch (err) {
      SahaAlert.showError(message: "Có lỗi khi lấy dữ liệu");
      isLoadingGet.value = false;
    }
  }

  Future<void> createAppTheme() async {
    isLoadingCreate.value = true;
    try {
      var data =
      await RepositoryManager.configUiRepository.createAppTheme(configApp);
      SahaAlert.showSuccess(message: "Cập nhật thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingCreate.value = false;
  }

}