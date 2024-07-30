import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/screen2/sale_market/history_check_in/history_check_in_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/sale_market/sale_check_in_agency/check_in_agency_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/sale_market/sale_market_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';

import '../../components/saha_user/empty/saha_empty_image.dart';
import '../../components/saha_user/loading/loading_full_screen.dart';
import '../../model/agency.dart';
import '../../model/sale_check_in.dart';
import '../home/home_controller.dart';
import '../navigator/navigator_controller.dart';

class SaleMarketScreen extends StatelessWidget {
  SaleMarketScreen({Key? key}) : super(key: key);
  final SaleMarketController controller = SaleMarketController();
  final RefreshController refreshController = RefreshController();
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkin đại lý"),
      ),
      body: Obx(
        () => controller.loadInit.value
            ? SahaLoadingFullScreen()
            : controller.listAgency.isEmpty
                ? const Center(
                    child: Text('Không có đại lý nào'),
                  )
                : SmartRefresher(
                    footer: CustomFooter(
                      builder: (
                        BuildContext context,
                        LoadStatus? mode,
                      ) {
                        Widget body = Container();
                        if (mode == LoadStatus.idle) {
                          body = Obx(() => controller.isLoading.value
                              ? const CupertinoActivityIndicator()
                              : Container());
                        } else if (mode == LoadStatus.loading) {
                          body = const CupertinoActivityIndicator();
                        }
                        return SizedBox(
                          height: 100,
                          child: Center(child: body),
                        );
                      },
                    ),
                    controller: refreshController,
                    enablePullDown: true,
                    enablePullUp: true,
                    header: const MaterialClassicHeader(),
                    onRefresh: () async {
                      await controller.getListAgencyForSale(isRefresh: true);
                      refreshController.refreshCompleted();
                    },
                    onLoading: () async {
                      await controller.getListAgencyForSale();
                      refreshController.loadComplete();
                    },
                    child: ListView.builder(
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: false,
                        itemCount: controller.listAgency.length,
                        itemBuilder: (BuildContext context, int index) {
                          return itemAgency(
                              controller.listAgency[index], index);
                        }),
                  ),
      ),
    );
  }

  Widget itemAgency(Agency agency, int index) {
    var timeVisit = Duration().obs;
    if (agency.staffSaleVisitAgency?.timeCheckin != null &&
        agency.staffSaleVisitAgency?.timeCheckout == null) {
      timeVisit.value = controller.countTimeVisit(
              timeCheckIn:
                  agency.staffSaleVisitAgency?.timeCheckin ?? DateTime.now()) ??
          Duration();
      Timer.periodic(Duration(seconds: 1), (timer) {
        timeVisit.value = controller.countTimeVisit(
                timeCheckIn: agency.staffSaleVisitAgency?.timeCheckin ??
                    DateTime.now()) ??
            Duration();
      });
    }
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  imageUrl: agency.customer?.avatarImage ?? "",
                  errorWidget: (context, url, error) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SahaEmptyImage(),
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, color: Colors.grey),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("${agency.customer?.name ?? "'Chưa đặt tên'"}"),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(Icons.phone, color: Colors.grey),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                            "${agency.customer?.phoneNumber ?? "'Chưa có sđt'"}"),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.rankingStar,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          agency.agencyType?.name ?? "Chưa có cấp",
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        // if (agency.staffSaleVisitAgency != null)
        //   Container(
        //     width: Get.width,
        //     color: Colors.green[300],
        //     padding: const EdgeInsets.all(10),
        //     child: Text(
        //       "Bạn đã viếng thăm lúc ${DateFormat("HH:mm").format(agency.staffSaleVisitAgency?.timeCheckin ?? DateTime.now())}",
        //       style: TextStyle(color: Colors.white),
        //     ),
        //   ),
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 10,
              ),
              // Row(
              //   children: [
              //     Text(
              //       "Số dư: ${SahaStringUtils().convertToMoney(agency.balance ?? 0)}₫",
              //       style: TextStyle(
              //           color: Colors.grey, fontWeight: FontWeight.bold),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Địa chỉ: ",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  Expanded(
                    child: Text(
                      "${agency.customer?.addressDetail == null ? "" : "${agency.customer?.addressDetail},"} ${agency.customer?.wardsName == null ? "" : "${agency.customer?.wardsName},"} ${agency.customer?.districtName == null ? "" : "${agency.customer?.districtName},"} ${agency.customer?.provinceName == null ? "" : "${agency.customer?.provinceName}"}",
                      style: TextStyle(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.back();
                    Get.find<NavigatorController>().indexNav.value = 0;

                    homeController.cartCurrent.value.customerId =
                        agency.customer?.id ?? -1;
                    homeController.cartCurrent.value.customerName =
                        agency.customer?.name;
                    homeController.cartCurrent.value.customerPhone =
                        agency.customer?.phoneNumber;
                    homeController.cartCurrent.value.province =
                        agency.customer?.province;
                    homeController.cartCurrent.value.district =
                        agency.customer?.district;
                    homeController.cartCurrent.value.wards =
                        agency.customer?.wards;
                    homeController.cartCurrent.value.addressDetail =
                        agency.customer?.addressDetail;
                    homeController.updateInfoCart();
                  },
                  child: Container(
                    //width: (Get.width - 50) / 3,
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.pink),
                        borderRadius: BorderRadius.circular(4)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart, color: Colors.pink),
                          Expanded(
                            child: Text(
                              "Đặt hàng",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.pink, fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    Get.to(() => HistoryCheckInScreen(
                          agencyId: agency.id!,
                        ));
                  },
                  child: Container(
                    //width: (Get.width - 50) / 3,
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.history,
                            color: Colors.green,
                          ),
                          Expanded(
                            child: Text(
                              "Lịch sử",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.green, fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    if (agency.staffSaleVisitAgency?.timeCheckin != null &&
                        agency.staffSaleVisitAgency?.timeCheckout == null) {
                      Get.to(() => CheckInAgencyScreen(
                                agencyId: agency.id ?? 0,
                              ))!
                          .then((value) =>
                              controller.getListAgencyForSale(isRefresh: true));
                      return;
                    }
                    SahaDialogApp.showDialogYesNo(
                        mess:
                            "Bạn đã đến địa điểm đại lý và muốn check in chứ ?",
                        onOK: () {
                          checkIn(agency, index);
                        });
                  },
                  child: Container(
                    //width: (Get.width - 50) / 3,
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.blue,
                          ),
                          Expanded(
                            child: Obx(
                              () => (controller.loadCheckIn.value &&
                                      controller.indexCheckin == index)
                                  ? SahaLoadingWidget(
                                      color: Colors.blue,
                                      size: 20,
                                    )
                                  : Text(
                                      timeVisit.value == Duration()
                                          ? "Check in"
                                          : "${timeVisit.value.inHours}:${(timeVisit.value.inMinutes % 60).toString().padLeft(2, '0')}:${(timeVisit.value.inSeconds % 60).toString().padLeft(2, '0')}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 13),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 12,
          color: Colors.grey[200],
        )
      ],
    );
  }

  void seeImage({
    dynamic imageUrl,
  }) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: Get.context!,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Container(
              child: PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    minScale: 0.0,
                    imageProvider: NetworkImage(imageUrl ?? ""),
                    initialScale: PhotoViewComputedScale.contained * 1,
                    heroAttributes:
                        PhotoViewHeroAttributes(tag: imageUrl ?? "error$index"),
                  );
                },
                itemCount: 1,
                loadingBuilder: (context, event) => Center(
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    child: CupertinoActivityIndicator(),
                  ),
                ),
              ),
            ),
            Positioned(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.5),
                ),
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Get.back();
                  },
                  color: Colors.white,
                ),
              ),
              top: 60,
              right: 20,
            )
          ],
        );
      },
    );
  }

  Future<void> checkIn(Agency agency, int index) async {
    if (controller.loadCheckIn.value == true) {
      return;
    }
    controller.indexCheckin = index;
    controller.loadCheckIn.value = true;
    await controller.initFind();
    if (controller.latitude == null || controller.longitude == null) {
      controller.loadCheckIn.value = false;
      SahaAlert.showError(message: "Chưa lấy được vị trí của bạn");
      return;
    }
    // double distance = await Geolocator.distanceBetween(20.973026441599245,
    //     105.82032551720172, controller.latitude!, controller.longitude!);
    // print('-=======> $distance');
    // if (distance < 50) {
    //   controller.loadCheckIn.value = false;
    //   SahaAlert.showError(
    //       message: "Bạn cần đến đúng vị trí đại lý để check in");
    //   return;
    // }
    if (agency.staffSaleVisitAgency?.timeCheckin == null ||
        (agency.staffSaleVisitAgency?.timeCheckin != null &&
            agency.staffSaleVisitAgency?.timeCheckout != null)) {
      if (controller.isHaveCheckOut == false) {
        controller.loadCheckIn.value = false;
        SahaAlert.showError(message: "Bạn có đại lý chưa check out");
        return;
      }
      await controller.checkInAgency(
          saleCheckIn: SaleCheckIn(
              agencyId: agency.id,
              timeCheckin: DateTime.now(),
              latitude: controller.latitude,
              longitude: controller.longitude,
              addressCheckin: controller.addressCheckin,
              deviceName: controller.deviceName,
              isAgencyOpen: true));
    }
    controller.loadCheckIn.value = false;
    Get.to(() => CheckInAgencyScreen(
              agencyId: agency.id ?? 0,
            ))!
        .then((value) => controller.getListAgencyForSale(isRefresh: true));
  }
}
