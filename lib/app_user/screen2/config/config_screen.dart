import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/screen2/config/print_bluetooth/print_bluetooth_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/config/printer_screen/printer_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/education/course_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/button/button_setting.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/decentralization/decentralization_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_container.dart';
import 'package:com.ikitech.store/app_user/screen2/account/account.dart';
import 'package:com.ikitech.store/app_user/screen2/config_decentralizations/config_decentralizations_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/config_notification/noti_home.dart';
import 'package:com.ikitech.store/app_user/screen2/config_payment/config_payment_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/config_store_address/config_store_address_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/maketing_chanel/marketing_chanel_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/review_manager/review_page/review_manage_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/store_info/store_info.dart';
import 'package:com.ikitech.store/app_user/screen2/time_keeping_staff/time_keeping_staff_screen.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';

import '../../../saha_data_controller.dart';
import '../../components/saha_user/empty/saha_empty_image.dart';
import '../sale_market/sale_market_screen.dart';
import 'e-commerce/e_commerce_screen.dart';
import 'general_setting/general_setting_screen.dart';
import 'group_customer/group_customer_screen.dart';
import 'mini_game/mini_game_screen.dart';
import 'mini_game/mini_game_spin_wheel/mini_game_setting_screen.dart';
import 'point_manager/point_manager_screen.dart';
import 'print/printers_screen.dart';
import 'time_keeping/time_keeping_screen.dart';

class ConfigScreen extends StatelessWidget {
  SahaDataController sahaDataController = Get.find();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Cài đặt"),
      ),
      body: Stack(
        children: [
          Positioned(
            top: -665,
            left: -100,
            right: -100,
            child: Container(
              height: 1000,
              width: 1000,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => AccountScreen());
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(
                        top: 10, bottom: 10, left: 15, right: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.5,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Obx(
                      () => Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(3000),
                            child: CachedNetworkImage(
                                imageUrl:
                                    sahaDataController.user.value.avatarImage ??
                                        "",
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    SahaLoadingContainer(),
                                errorWidget: (context, url, error) =>
                                    SahaEmptyImage()),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${sahaDataController.user.value.name ?? "Chưa đặt tên"}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                              Text(
                                "${sahaDataController.user.value.phoneNumber ?? ""}",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                          // Spacer(),
                          // if (sahaDataController.badgeUser.value.isStaff ==
                          //     true)
                          //   TextButton(
                          //       onPressed: () {
                          //         Get.to(() => TimeKeepingStaffScreen());
                          //       },
                          //       child: Text("Chấm công")),
                          // Icon(
                          //   Icons.arrow_forward_ios_rounded,
                          //   size: 18,
                          //   color: Colors.grey,
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
                boxButton(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "© 2021 IKITECH JSC ${UserInfo().getIsRelease() == null ? "" : "(DEV)"}",
                        style: TextStyle(color: Colors.grey[500], fontSize: 13),
                      ),
                    ),
                    Container(
                      width: Get.width,
                      padding: EdgeInsets.only(
                          top: 5, right: 10, bottom: 20, left: 10),
                      child: Center(
                        child: Text(
                          "version ${sahaDataController.packageInfo.value.version} - Build ${sahaDataController.packageInfo.value.buildNumber}",
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget boxButton() {
    return Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.5,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          StaggeredGridView.countBuilder(
            shrinkWrap: true,
            primary: false,
            staggeredTileBuilder: (index) => StaggeredTile.fit(1),
            itemBuilder: (context, pos) {
              return [
                Obx(
                  () => DecentralizationWidget(
                    decent: sahaDataController.badgeUser.value.decentralization
                            ?.appThemeMainConfig ??
                        false,
                    child: ButtonSetting(
                      asset: 'assets/icons/settings/mobile_app.svg',
                      title: 'Giao diện khách hàng',
                      onTap: () async {
                        await StoreInfo().setCustomerStoreCode(
                            UserInfo().getCurrentStoreCode());
                        Get.toNamed("ConfigScreen");
                      },
                    ),
                  ),
                ),
                Obx(
                  () => DecentralizationWidget(
                    decent: sahaDataController.badgeUser.value.decentralization
                            ?.deliveryPickAddressList ??
                        false,
                    child: ButtonSetting(
                      asset: 'assets/icons/settings/tracking.svg',
                      title: 'Vận chuyển',
                      onTap: () {
                        Get.to(() => ConfigStoreAddressScreen());
                      },
                    ),
                  ),
                ),
                Obx(
                  () => DecentralizationWidget(
                    decent: sahaDataController
                            .badgeUser.value.decentralization?.paymentList ??
                        false,
                    child: ButtonSetting(
                      asset: 'assets/icons/settings/payment_setting.svg',
                      title: 'Thanh toán',
                      onTap: () {
                        Get.to(() => ConfigPayment());
                      },
                    ),
                  ),
                ),
                Obx(
                  () => DecentralizationWidget(
                    decent: sahaDataController.badgeUser.value.decentralization
                            ?.notificationScheduleList ??
                        false,
                    child: ButtonSetting(
                      asset: 'assets/icons/settings/notification_setting.svg',
                      title: 'Lên lịch thông báo',
                      onTap: () {
                        Get.to(() => NotiHome());
                      },
                    ),
                  ),
                ),
                Obx(
                  () => DecentralizationWidget(
                    decent: sahaDataController
                            .badgeUser.value.decentralization?.settingPrint ??
                        false,
                    child: ButtonSetting(
                      asset: 'assets/icons/settings/printer.svg',
                      title: 'Máy in',
                      onTap: () {
                        Get.to(() => PrinterScreen());
                      },
                    ),
                  ),
                ),
                DecentralizationWidget(
                  decent: true,
                  child: ButtonSetting(
                    asset: 'assets/icons/settings/gift.svg',
                    title: 'Chương trình khuyến mãi',
                    onTap: () {
                      Get.to(() => MarketingChanelScreen());
                    },
                  ),
                ),

                Obx(
                  () => DecentralizationWidget(
                    decent: sahaDataController.badgeUser.value.decentralization
                            ?.customerConfigPoint ??
                        false,
                    child: ButtonSetting(
                      asset: 'assets/icons/settings/reward.svg',
                      title: 'Xu thưởng khách hàng',
                      onTap: () {
                        Get.to(() => PointManagerScreen());
                      },
                    ),
                  ),
                ),
                Obx(
                  () => DecentralizationWidget(
                    decent: sahaDataController.badgeUser.value.decentralization
                            ?.customerReviewList ??
                        false,
                    child: ButtonSetting(
                      asset: 'assets/icons/review.svg',
                      title: 'Đánh giá khách hàng',
                      onTap: () {
                        Get.to(() => ReviewManageScreen());
                      },
                    ),
                  ),
                ),
                Obx(
                  () => DecentralizationWidget(
                    decent: sahaDataController.badgeUser.value.decentralization
                            ?.decentralizationList ??
                        false,
                    child: ButtonSetting(
                      asset: 'assets/icons/settings/decent.svg',
                      title: 'Phân quyền',
                      onTap: () {
                        Get.to(() => ConfigDecentralizationScreen());
                      },
                    ),
                  ),
                ),
                Obx(
                  () => DecentralizationWidget(
                    decent: sahaDataController
                            .badgeUser.value.decentralization?.storeInfo ??
                        false,
                    child: ButtonSetting(
                      asset: 'assets/icons/agency2.svg',
                      title: 'Thông tin cửa hàng',
                      onTap: () {
                        Get.to(() => StoreInfoScreen());
                      },
                    ),
                  ),
                ),
                // Obx(
                //   () => DecentralizationWidget(
                //     decent: sahaDataController
                //             .badgeUser.value.decentralization?.timekeeping ??
                //         false,
                //     child: ButtonSetting(
                //       asset: 'assets/icons/settings/time.svg',
                //       title: 'Cài đặt chấm công',
                //       onTap: () {
                //         Get.to(() => TimeKeepingScreen());
                //       },
                //     ),
                //   ),
                // ),
                Obx(
                  () => DecentralizationWidget(
                    decent: sahaDataController
                            .badgeUser.value.decentralization?.configSetting ??
                        false,
                    child: ButtonSetting(
                      asset: 'assets/icons/settings/settings.svg',
                      title: 'Cài đặt chung',
                      onTap: () {
                        Get.to(() => GeneralSettingScreen());
                      },
                    ),
                  ),
                ),
                Obx(
                  () => DecentralizationWidget(
                    decent: sahaDataController
                            .badgeUser.value.decentralization?.groupCustomer ??
                        false,
                    child: ButtonSetting(
                      asset: 'assets/icons/settings/decent.svg',
                      title: 'Nhóm khách hàng',
                      onTap: () {
                        Get.to(() => GroupCustomerScreen());
                      },
                    ),
                  ),
                ),
                Obx(
                  () => DecentralizationWidget(
                    decent: sahaDataController
                            .badgeUser.value.decentralization?.gamification ??
                        false,
                    child: ButtonSetting(
                      asset: 'assets/icons/settings/mini-game.svg',
                      title: 'Mini game',
                      onTap: () {
                        Get.to(() => MiniGameScreen());
                      },
                    ),
                  ),
                ),

                // DecentralizationWidget(
                //   decent: true,
                //   child: ButtonSetting(
                //     asset: 'assets/icons/settings/mini-game.svg',
                //     title: 'Máy in 2',
                //     onTap: () {
                //       Get.to(() => PrintBluetoothScreen());
                //     },
                //   ),
                // ),

                // Obx(
                //   () => DecentralizationWidget(
                //     decent: sahaDataController
                //             .badgeUser.value.decentralization?.configSetting ??
                //         false,
                //     child: ButtonSetting(
                //       asset: 'assets/icons/settings/e-com.svg',
                //       title: 'Sàn TMĐT',
                //       onTap: () {
                //         Get.to(() => ECommerceScreen());
                //       },
                //     ),
                //   ),
                // ),
                //  ButtonSetting(
                //       asset: 'assets/icons/settings/sale.svg',
                //       title: 'Sale thị trường',
                //       onTap: () async {
                //         Get.to(()=>SaleMarketScreen());
                //       },
                //     ),
              ][pos];
            },
            itemCount: 13,
            crossAxisCount: 4,
            mainAxisSpacing: 0,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
          ),
        ],
      ),
    );
  }
}
