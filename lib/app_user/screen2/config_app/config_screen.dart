import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/const/constant.dart';
import 'package:com.ikitech.store/app_user/screen2/home/home_controller.dart';
import 'package:sahashop_customer/app_customer/config_controller.dart';
import 'package:sahashop_customer/app_customer/sahashop_customer.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';
import '../../../saha_data_controller.dart';
import 'config_controller.dart';
import 'ui_data_config.dart';
import '../../utils/user_info.dart';

class ConfigAppScreen extends StatelessWidget {
  final ConfigController configController = Get.put(ConfigController());

  final CustomerConfigController customerConfigController =
      Get.put(CustomerConfigController());

  DataAppCustomerController dataAppCustomerController =
      Get.put(DataAppCustomerController())..getHomeData();

  final SahaDataController sahaDataController = Get.find();

  final HomeController homeController = Get.find();

  UIDataConfig uiDataConfig = new UIDataConfig();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Row(
              children: [
                Text(
                  "Chỉnh sửa giao diện",
                  style: TextStyle(fontSize: 18),
                ),
                Spacer(),
                if (UserInfo().getCurrentIdUser() != 1)
                  InkWell(
                    onTap: () async {
                      await StoreInfo().setRelease(UserInfo().getIsRelease());
                      Get.to(() => SahaShopCustomer(
                        // afDevKey: "CD8ufxSehrwip5wmayxGaF",
                        // appId: "6450923223",
                          storeCode: UserInfo().getCurrentStoreCode()!,
                          storeName:
                              homeController.storeCurrent?.value.name ?? "",
                          isPreview: true));
                      sahaDataController.changeStatusPreview(true);
                    },
                    child: Container(
                      child: Row(
                        children: [
                          SvgPicture.asset(
                              'assets/app_user/svg/config/preview.svg',
                              height: 30,
                              width: 30),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            "Xem trước",
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(
                            width: 5,
                          )
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          body: Obx(
            () => configController.isLoadingGet.value
                ? SahaLoadingFullScreen()
                : Column(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 90,
                              width: Get.width,
                              color: Colors.white,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: uiDataConfig.UIData.length,
                                  itemBuilder: (context, index) {
                                    return buildItem(index: index);
                                  }),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                keyboardDismissBehavior:
                                    ScrollViewKeyboardDismissBehavior.onDrag,
                                controller: sahaDataController.scrollController,
                                child: Column(
                                  children: [
                                    uiDataConfig
                                                    .UIData[configController
                                                        .indexTab.value]
                                                    .listChildConfig ==
                                                null ||
                                            uiDataConfig
                                                    .UIData[configController
                                                        .indexTab.value]
                                                    .listChildConfig!
                                                    .length ==
                                                0
                                        ? Container(
                                            height: 5,
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children:
                                                uiDataConfig
                                                    .UIData[configController
                                                        .indexTab.value]
                                                    .listChildConfig!
                                                    .map<Widget>(
                                                      (e) =>
                                                          e.editWidget == null
                                                              ? Container()
                                                              : Container(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              10.0,
                                                                          right:
                                                                              10),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                        width: double
                                                                            .infinity,
                                                                        padding: EdgeInsets.only(
                                                                            top:
                                                                                3,
                                                                            bottom:
                                                                                3,
                                                                            left:
                                                                                10),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(8)),
                                                                          gradient:
                                                                              LinearGradient(
                                                                            begin:
                                                                                Alignment.topRight,
                                                                            end:
                                                                                Alignment.bottomLeft,
                                                                            stops: [
                                                                              0.1,
                                                                              0.2
                                                                            ],
                                                                            colors: [
                                                                              Theme.of(context).primaryColor.withOpacity(0.3),
                                                                              Theme.of(context).primaryColor.withOpacity(0.1)
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          e.name ??
                                                                              "",
                                                                          style: TextStyle(
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            15,
                                                                      ),
                                                                      e.editWidget!,
                                                                      SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                    )
                                                    .toList(),
                                          )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Obx(
                            () => SahaButtonFullParent(
                              color: Theme.of(context).primaryColor,
                              textColor: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyText1!
                                  .color,
                              onPressed:
                                  configController.isLoadingCreate.value == true
                                      ? null
                                      : () async {
                                          await configController
                                              .createAppTheme();
                                          configController.updateTheme();
                                          // customerConfigController.getAppTheme(
                                          //     refresh: true);
                                        },
                              text:
                                  configController.isLoadingCreate.value == true
                                      ? "..."
                                      : "Cập nhật giao diện",
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      )
                    ],
                  ),
          )),
    );
  }

  Widget buildItem({required int index}) {
    ParentConfig parentConfig = uiDataConfig.UIData[index];
    return InkWell(
      onTap: () {
        configController.setTab(index);
      },
      child: Container(
        width: 90,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 25,
              height: 25,
              child: SvgPicture.asset(
                "assets/config/${parentConfig.icon}",
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5),
                child: Center(
                  child: Text(
                    parentConfig.name!,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: configController.indexTab.value == index
                            ? SahaPrimaryLightColor
                            : Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
