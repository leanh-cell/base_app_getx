import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/saha_text_field_search.dart';
import 'package:com.ikitech.store/app_user/screen2/order_manage/order_manage_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/report/choose_time/choose_time_screen.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../components/saha_user/call/call.dart';
import '../../../../components/saha_user/dialog/dialog.dart';
import '../../../../model/agency.dart';
import '../../../report/report_ctv_agency/report_screen.dart';
import 'top_agency_controller.dart';

class TopAgencyScreen extends StatefulWidget {
  bool? isCtv;

  TopAgencyScreen({this.isCtv});

  @override
  _TopAgencyScreenState createState() => _TopAgencyScreenState();
}

class _TopAgencyScreenState extends State<TopAgencyScreen> {
  late TopAgencyController topAgencyController;

  RefreshController refreshController = RefreshController(initialRefresh: true);
  List<String> choices = [
    "Theo doanh số",
    "Theo xu",
  ];

  List<String> choices2 = [
    "Theo số đơn",
    "Theo hoa hồng",
  ];

  @override
  void initState() {
    topAgencyController = TopAgencyController(isCtv: widget.isCtv);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => topAgencyController.isSearch.value
              ? SahaTextFieldSearch(
                  onSubmitted: (va) {
                    topAgencyController.textSearch = va;
                    topAgencyController.getTopAgency(
                        searchText: topAgencyController.textSearch,
                        isRefresh: true);
                  },
                  onClose: () {
                    topAgencyController.textSearch = null;
                    topAgencyController.isSearch.value = false;
                  },
                )
              : Text(widget.isCtv == true
                  ? 'Top hoa hồng đại lý'
                  : "Top nhập hàng đại lý"),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search_outlined),
              onPressed: () {
                topAgencyController.isSearch.value = true;
              }),
          if (widget.isCtv == true)
            PopupMenuButton(
              elevation: 3.2,
              onCanceled: () {},
              icon: Icon(Icons.more_vert),
              onSelected: (v) async {
                if (v == "Theo số đơn") {
                  topAgencyController.reportType.value = "orders_count";
                } else {
                  topAgencyController.reportType.value = "sum_share_agency";
                }

                topAgencyController.getTopAgency(isRefresh: true);
              },
              itemBuilder: (BuildContext context) {
                return choices2.map((String choice) {
                  return PopupMenuItem(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            )
        ],
      ),
      body: Column(
        children: [
          head(),
          Divider(
            height: 1,
          ),
          Expanded(
            child: SmartRefresher(
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
                    body = Obx(() => topAgencyController.isLoadMore.value
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
                await topAgencyController.getTopAgency(
                    searchText: topAgencyController.textSearch,
                    isRefresh: true);
                refreshController.refreshCompleted();
              },
              onLoading: () async {
                await topAgencyController.getTopAgency(
                    searchText: topAgencyController.textSearch,
                    isRefresh: false);
                refreshController.loadComplete();
              },
              child: SingleChildScrollView(
                child: Obx(
                  () => Column(children: [
                    ...List.generate(
                        topAgencyController.listTopAgency.length,
                        (index) => itemAgency(
                            topAgencyController.listTopAgency[index], index))
                  ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemAgency(Agency agency, int index) {
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
                    Text(
                        "Tên: ${agency.customer?.name ?? "'Chưa đặt tên'"} - ${agency.customer?.sex == 0 ? "Không xác định" : agency.customer?.sex == 1 ? "Nam" : agency.customer?.sex == 2 ? "Nữ" : "Không xác định"}"),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        "Phone: ${agency.customer?.phoneNumber ?? "'Chưa có sđt'"}"),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Kiểu đại lý: ${agency.agencyType?.name ?? ""}"),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        "Số dư: ${SahaStringUtils().convertToMoney(agency.balance ?? "")}"),
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
                    "${agency.ordersCount ?? 0}",
                    style: TextStyle(
                        color: Colors.pink, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(widget.isCtv == true ? "Hoa hồng: " : 'Doanh số: '),
                  Text(
                    widget.isCtv == true
                        ? "${SahaStringUtils().convertToMoney(agency.sumShareAgency ?? 0)}₫"
                        : "${SahaStringUtils().convertToMoney(agency.sumTotalFinal ?? 0)}₫",
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
                        agencyId: agency.customerId,
                        initPageOrder: 3,
                        fromDate: topAgencyController.dateFrom.value,
                        toDate: topAgencyController.dateTo.value,
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
                  if (widget.isCtv == true) {
                    Get.to(() => ReportScreen(
                          agencyByCustomerId: agency.customerId,
                          fromDate: topAgencyController.dateFrom.value,
                          toDate: topAgencyController.dateTo.value,
                          isCtv: true,
                        ));
                  } else {
                    Get.to(() => ReportScreen(
                          agencyByCustomerId: agency.customerId,
                          fromDate: topAgencyController.dateFrom.value,
                          toDate: topAgencyController.dateTo.value,
                        ));
                  }
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
                  Call.call("${agency.customer?.phoneNumber ?? ""}");
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
                  initTab: topAgencyController.indexTabTimeSave,
                  fromDayInput: topAgencyController.dateFrom.value,
                  toDayInput: topAgencyController.dateTo.value,
                  initChoose: topAgencyController.indexChooseSave,
                  callback: (DateTime fromDate,
                      DateTime toDay,
                      DateTime fromDateCP,
                      DateTime toDayCP,
                      bool isCompare,
                      int? indexTab,
                      int? indexChoose) {
                    topAgencyController.dateFrom.value = fromDate;
                    topAgencyController.dateTo.value = toDay;
                    topAgencyController.indexTabTimeSave = indexTab;
                    topAgencyController.indexChooseSave = indexChoose;
                  },
                ))!
            .then((value) => {
                  topAgencyController.getTopAgency(isRefresh: true),
                });
      },
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => topAgencyController.dateFrom.value !=
                    topAgencyController.dateTo.value
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                  "${SahaDateUtils().getDDMMYY(topAgencyController.dateFrom.value)} "),
                              Text(
                                "Đến: ",
                                style: TextStyle(
                                    color: Theme.of(Get.context!).primaryColor),
                              ),
                              Text(
                                  "${SahaDateUtils().getDDMMYY(topAgencyController.dateTo.value)}"),
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
                : topAgencyController.dateFrom.value.day == DateTime.now().day
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
                                      "${SahaDateUtils().getDDMMYY(topAgencyController.dateFrom.value)} "),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                    "Hôm qua: ",
                                    style: TextStyle(
                                        color: Theme.of(Get.context!)
                                            .primaryColor),
                                  ),
                                  Text(
                                      "${SahaDateUtils().getDDMMYY(topAgencyController.dateFrom.value)} "),
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
