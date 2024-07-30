import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/screen2/report/report_ctv_agency/report_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty/saha_empty_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/saha_text_field_search.dart';
import 'package:com.ikitech.store/app_user/model/ctv.dart';
import 'package:com.ikitech.store/app_user/screen2/report/choose_time/choose_time_screen.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/saha_user/call/call.dart';
import '../../order_manage/order_manage_screen.dart';
import 'top_ctv_controller.dart';

class TopCtvScreen extends StatefulWidget {
  @override
  _TopCtvScreenState createState() => _TopCtvScreenState();
}

class _TopCtvScreenState extends State<TopCtvScreen> {
  TopCtvController topCtvController = TopCtvController();

  RefreshController refreshController = RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Obx(
        () => topCtvController.isSearch.value
            ? SahaTextFieldSearch(
                onSubmitted: (va) {
                  topCtvController.textSearch = va;
                  topCtvController.getTopCtv(
                      searchText: topCtvController.textSearch, isRefresh: true);
                },
                onClose: () {
                  topCtvController.textSearch = null;
                  topCtvController.isSearch.value = false;
                },
              )
            : Text("Top CTV"),
      )),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: MaterialClassicHeader(),
        footer: CustomFooter(
          builder: (
            BuildContext context,
            LoadStatus? mode,
          ) {
            Widget body = Container();
            if (mode == LoadStatus.idle) {
              body = Obx(() => topCtvController.isLoadMore.value
                  ? CupertinoActivityIndicator()
                  : Container());
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            }
            return Container(
              height: 100,
              child: Center(child: body),
            );
          },
        ),
        controller: refreshController,
        onRefresh: () async {
          await topCtvController.getTopCtv(
              searchText: topCtvController.textSearch, isRefresh: true);
          refreshController.refreshCompleted();
        },
        onLoading: () async {
          await topCtvController.getTopCtv(
              searchText: topCtvController.textSearch, isRefresh: false);
          refreshController.loadComplete();
        },
        child: Column(
          children: [
            head(),
            Divider(
              height: 1,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Obx(
                  () => Column(children: [
                    ...List.generate(
                        topCtvController.listTopCtv.length,
                        (index) =>
                            itemCtv(topCtvController.listTopCtv[index], index))
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemCtv(Ctv ctv, int index) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  imageUrl: ctv.customer?.avatarImage ?? "",
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
                    Text(
                        "Tên: ${ctv.firstAndLastName ?? "'Chưa đặt tên'"} - ${ctv.customer?.sex == 0 ? "Không xác định" : ctv.customer?.sex == 1 ? "Nam" : ctv.customer?.sex == 2 ? "Nữ" : "Không xác định"}"),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        "Phone: ${ctv.customer?.phoneNumber ?? "'Chưa có sđt'"}"),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Số đơn: ",
                  ),
                  Text(
                    "${ctv.ordersCount ?? 0}",
                    style: TextStyle(
                        color: Colors.pink, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Doanh số: ",
                  ),
                  Text(
                    "${SahaStringUtils().convertToMoney(ctv.sumTotalFinal ?? 0)}₫",
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => OrderManageScreen(
                        ctvId: ctv.customerId,
                        initPageOrder: 3,
                        fromDate: topCtvController.dateFrom.value,
                        toDate: topCtvController.dateTo.value,
                      ));
                },
                child: Container(
                  height: 35,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Theme.of(Get.context!).primaryColor,
                      borderRadius: BorderRadius.circular(4)),
                  child: Center(
                    child: Text(
                      "Đơn hàng",
                      style: TextStyle(
                          color: Theme.of(Get.context!)
                              .primaryTextTheme
                              .headline6!
                              .color),
                    ),
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  Get.to(() => ReportScreen(
                        collaboratorByCustomerId: ctv.customerId,
                        fromDate: topCtvController.dateFrom.value,
                        toDate: topCtvController.dateTo.value,
                      ));
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      "Báo cáo doanh số",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  Call.call("${ctv.customer?.phoneNumber ?? ""}");
                },
                child: Container(
                  height: 35,
                  width: 70,
                  decoration: BoxDecoration(
                      color: Theme.of(Get.context!).primaryColor,
                      borderRadius: BorderRadius.circular(4)),
                  child: Center(
                    child: Text(
                      "Gọi ngay",
                      style: TextStyle(
                          color: Theme.of(Get.context!)
                              .primaryTextTheme
                              .headline6!
                              .color),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 8,
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

  Widget head() {
    return InkWell(
      onTap: () {
        Get.to(() => ChooseTimeScreen(
                  isCompare: false,
                  hideCompare: true,
                  initTab: topCtvController.indexTabTimeSave,
                  fromDayInput: topCtvController.dateFrom.value,
                  toDayInput: topCtvController.dateTo.value,
                  initChoose: topCtvController.indexChooseSave,
                  callback: (DateTime fromDate,
                      DateTime toDay,
                      DateTime fromDateCP,
                      DateTime toDayCP,
                      bool isCompare,
                      int? indexTab,
                      int? indexChoose) {
                    topCtvController.dateFrom.value = fromDate;
                    topCtvController.dateTo.value = toDay;
                    topCtvController.indexTabTimeSave = indexTab;
                    topCtvController.indexChooseSave = indexChoose;
                  },
                ))!
            .then((value) => {
                  topCtvController.getTopCtv(isRefresh: true),
                });
      },
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => topCtvController.dateFrom.value !=
                    topCtvController.dateTo.value
                ? Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Theme.of(Get.context!).primaryColor,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Từ: ",
                                style: TextStyle(
                                    color: Theme.of(Get.context!).primaryColor),
                              ),
                              Text(
                                  "${SahaDateUtils().getDDMMYY(topCtvController.dateFrom.value)} "),
                              Text(
                                "Đến: ",
                                style: TextStyle(
                                    color: Theme.of(Get.context!).primaryColor),
                              ),
                              Text(
                                  "${SahaDateUtils().getDDMMYY(topCtvController.dateTo.value)}"),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 21,
                        color: Theme.of(Get.context!).primaryColor,
                      )
                    ],
                  )
                : topCtvController.dateFrom.value.day == DateTime.now().day
                    ? Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Theme.of(Get.context!).primaryColor,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Hôm nay: ",
                                    style: TextStyle(
                                        color: Theme.of(Get.context!)
                                            .primaryColor),
                                  ),
                                  Text(
                                      "${SahaDateUtils().getDDMMYY(topCtvController.dateFrom.value)} "),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: 21,
                            color: Theme.of(Get.context!).primaryColor,
                          )
                        ],
                      )
                    : Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Theme.of(Get.context!).primaryColor,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Hôm qua: ",
                                    style: TextStyle(
                                        color: Theme.of(Get.context!)
                                            .primaryColor),
                                  ),
                                  Text(
                                      "${SahaDateUtils().getDDMMYY(topCtvController.dateFrom.value)} "),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: 21,
                            color: Theme.of(Get.context!).primaryColor,
                          )
                        ],
                      ),
          )),
    );
  }
}
