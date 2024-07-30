import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../saha_data_controller.dart';
import 'screens_config/button_style/button_style.dart';
import 'screens_config/category_product/category_product.dart';
import 'screens_config/contact_screen/contact_screen.dart';
import 'screens_config/font_type/font.dart';
import 'screens_config/home_buttons/button_config.dart';
import 'screens_config/home_screen/home_screen.dart';
import 'screens_config/icon_helpler/iconType/supportIcon.dart';
import 'screens_config/layout_sort/layout_config.dart';
import 'screens_config/logo_type/logo.dart';
import 'screens_config/main_component_config/banner_ads_config.dart';
import 'screens_config/main_component_config/banner_config.dart';
import 'screens_config/main_component_config/image_carousel/select_image_carousel.dart';
import 'screens_config/main_component_config/product_item.dart';
import 'screens_config/product_screen/product_screen.dart';
import 'screens_config/theme_color/theme_color.dart';

class UIDataConfig {
  SahaDataController sahaDataController = Get.find();
  var UIData = [];
  UIDataConfig() {
    UIData = [
      ParentConfig(
          name: "Cấu hình chính",
          icon: "main_config.svg",
          decentralization: sahaDataController
                  .badgeUser.value.decentralization?.appThemeMainConfig ??
              false,
          listChildConfig: [
            ChildConfig(
                name: "Màu sắc đặc trưng", editWidget: MainConfigThemeColor()),
            ChildConfig(name: "Logo App của bạn", editWidget: MainConfigLogo()),
            // ChildConfig(name: "Kiểu chữ", editWidget: FontConfig()),
          ]),
      ParentConfig(
          name: "Nút hỗ trợ",
          icon: "contact.svg",
          decentralization: sahaDataController
                  .badgeUser.value.decentralization?.appThemeButtonContact ??
              false,
          listChildConfig: [
            ChildConfig(name: "Contact", editWidget: SupportIcon()),
          ]),
      ParentConfig(
          name: "Màn hình trang chủ",
          icon: "home.svg",
          decentralization: sahaDataController
                  .badgeUser.value.decentralization?.appThemeHomeScreen ??
              false,
          listChildConfig: [
            ChildConfig(name: "Kiểu giao diện", editWidget: HomeScreenConfig()),
            ChildConfig(
                name: "Nút điều hướng chính", editWidget: ButtonHomeConfig()),
            ChildConfig(name: "Kiểu nút", editWidget: ButtonTypeConfig()),
            ChildConfig(name: "Sắp xếp bố cục", editWidget: LayoutConfig()),
          ]),
      ParentConfig(
          name: "Thành phần chính",
          icon: "main_component.svg",
          decentralization: sahaDataController
                  .badgeUser.value.decentralization?.appThemeMainComponent ??
              false,
          listChildConfig: [
            ChildConfig(name: "Sản phẩm", editWidget: ProductItemConfig()),
            ChildConfig(name: "Ảnh banner", editWidget: SelectCarouselImages()),
            ChildConfig(name: "Kiểu banner", editWidget: BoxPionConfig()),
            ChildConfig(name: "Banner quảng cáo", editWidget: BannerAdsConfig()),
          ]),
      ParentConfig(
          name: "Màn hình Danh mục",
          icon: "category.svg",
          decentralization: sahaDataController
                  .badgeUser.value.decentralization?.appThemeCategoryProduct ??
              false,
          listChildConfig: [
            ChildConfig(
                name: "Kiểu danh mục",
                editWidget: CategoryProductConfig()),
          ]),
      ParentConfig(
          name: "Màn hình sản phẩm",
          icon: "product.svg",
          decentralization: sahaDataController
                  .badgeUser.value.decentralization?.appThemeProductScreen ??
              false,
          listChildConfig: [
            ChildConfig(
                name: "Màn hình sản phẩm", editWidget: ProductScreenConfig())
          ]),
      ParentConfig(
          name: "Màn hình Liên hệ",
          icon: "call.svg",
          decentralization: sahaDataController
                  .badgeUser.value.decentralization?.appThemeContactScreen ??
              false,
          listChildConfig: [
            ChildConfig(name: "Liên hệ shop", editWidget: ContactScreen())
          ]),
    ];
  }
}

class ParentConfig {
  String? name;
  String? icon;
  bool? decentralization;
  List<ChildConfig>? listChildConfig;

  ParentConfig(
      {this.name, this.listChildConfig, this.icon, this.decentralization});
}

class ChildConfig {
  String? name;
  Widget? editWidget;

  ChildConfig({this.name, this.editWidget});
}
