import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/saha_text_field_search.dart';
import 'package:com.ikitech.store/app_user/screen2/order_manage/order_manage_screen.dart';
import 'package:ionicons/ionicons.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../../../saha_data_controller.dart';
import '../../../../components/saha_user/call/call.dart';
import '../../../../components/saha_user/loading/loading_container.dart';
import '../../../../model/agency.dart';
import '../../../../model/agency_type.dart';
import '../../../../utils/string_utils.dart';
import '../../../report/report_ctv_agency/report_screen.dart';
import 'history_balance/history_balance_agency_screen.dart';
import 'list_agency_controller.dart';

class ListAgencyScreen extends StatefulWidget {
  @override
  _ListAgencyScreenState createState() => _ListAgencyScreenState();
}

class _ListAgencyScreenState extends State<ListAgencyScreen> {
  ListAgencyController listAgencyController = ListAgencyController();

  RefreshController refreshController = RefreshController(initialRefresh: true);
  SahaDataController sahaDataController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => listAgencyController.isSearch.value
              ? SahaTextFieldSearch(
                  onSubmitted: (va) {
                    listAgencyController.textSearch = va;
                    listAgencyController.getListAgency(
                        searchText: listAgencyController.textSearch,
                        isRefresh: true);
                  },
                  onClose: () {
                    listAgencyController.textSearch = null;
                    listAgencyController.isSearch.value = false;
                    listAgencyController.getListAgency(
                        searchText: listAgencyController.textSearch,
                        isRefresh: true);
                  },
                )
              : Text("Tất cả Đại lý"),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search_outlined),
              onPressed: () {
                listAgencyController.isSearch.value = true;
              }),
          Obx(
            () => listAgencyController.isLoading.value == true
                ? Container()
                : PopupMenuButton(
                    elevation: 3.2,
                    initialValue: listAgencyController.agencyTypeField?.name,
                    onCanceled: () {},
                    icon: Icon(Icons.more_vert),
                    onSelected: (v) async {
                      var index = listAgencyController.listAgencyType
                          .indexWhere((e) => e.name == v);

                      if (index != -1) {
                        listAgencyController.agencyTypeField =
                            listAgencyController.listAgencyType[index];
                        listAgencyController.getListAgency(isRefresh: true);
                        listAgencyController.isLoading.refresh();
                      }
                      if (v == "Tất cả") {
                        listAgencyController.agencyTypeField?.id = null;
                        listAgencyController.getListAgency(isRefresh: true);
                      }

                      // listAgencyController.agencyTypeId = v as int?;
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem(
                          value: "Tất cả",
                          child: Text("Tất cả"),
                        ),
                        ...listAgencyController.listAgencyType
                            .map((e) => e.name)
                            .toList()
                            .map((String? choice) {
                          return PopupMenuItem(
                            value: choice,
                            child: Text(choice ?? ""),
                          );
                        }).toList(),
                      ];
                    },
                  ),
          ),
        ],
      ),
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
              body = Obx(() => listAgencyController.isLoadMore.value
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
          await listAgencyController.getListAgency(
              searchText: listAgencyController.textSearch, isRefresh: true);
          refreshController.refreshCompleted();
        },
        onLoading: () async {
          await listAgencyController.getListAgency(
              searchText: listAgencyController.textSearch, isRefresh: false);
          refreshController.loadComplete();
        },
        child: SingleChildScrollView(
          child: Obx(
            () => Column(children: [
              ...List.generate(
                  listAgencyController.listAgency.length,
                  (index) =>
                      itemAgency(listAgencyController.listAgency[index], index))
            ]),
          ),
        ),
      ),
    );
  }

  Widget itemAgency(Agency agency, int index) {
    AgencyType? agencyType;
    var expanded = false.obs;
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
                    Text(
                        "Họ và tên: ${agency.customer?.name ?? "'Chưa đặt tên'"}"),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        "Phone: ${agency.customer?.phoneNumber ?? "'Chưa có sđt'"}"),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Cấp đại lý: "),
                        Obx(
                          () => listAgencyController.listStatus[index] == false
                              ? Container()
                              : DropdownButton<AgencyType>(
                                  hint: agency.agencyType == null
                                      ? Text("Chọn kiểu")
                                      : Text(
                                          "${agency.agencyType?.name}",
                                        ),
                                  value: agencyType,
                                  items: listAgencyController.listAgencyType
                                      .map((AgencyType value) {
                                    return DropdownMenuItem<AgencyType>(
                                      value: value,
                                      child: Text(value.name ?? ""),
                                    );
                                  }).toList(),
                               
                                  onChanged: (v) {
                                    if(sahaDataController.badgeUser.value.decentralization?.agencyChangeLevel != false){
                                      SahaAlert.showError(message: "Bạn không có quyền chỉnh sửa cấp đại lý");
                                      return;
                                    }
                                    
                                    agencyType = v;
                                    listAgencyController.updateAgency(
                                      status: listAgencyController
                                                  .listStatus[index] ==
                                              true
                                          ? 1
                                          : 0,
                                      idAgency: agency.id!,
                                      index: index,
                                      agencyType: agencyType,
                                    );
                                    listAgencyController.listAgencyType
                                        .refresh();
                                  },
                                ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ]),
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        expanded.value = !expanded.value;
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(0, 2),
                              ),
                            ]),
                        child: Row(children: [
                          Expanded(
                              child: Text(
                            "Thông tin thanh toán",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )),
                          Obx(() => Icon(expanded.value
                              ? Icons.keyboard_arrow_down_rounded
                              : Icons.navigate_next)),
                        ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Obx(
                        () => expanded.value
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 50,
                                  ),
                                  if (agency.firstAndLastName != null)
                                    Text(
                                        "Tên CMND: ${agency.firstAndLastName ?? "'Chưa đặt tên'"}"),
                                  if (agency.firstAndLastName != null)
                                    SizedBox(
                                      height: 5,
                                    ),
                                  if (agency.cmnd != null)
                                    Text(
                                        "CMND: ${agency.cmnd ?? "'Chưa có cmnd'"} - ${agency.issuedBy ?? ""}"),
                                  if (agency.cmnd != null)
                                    SizedBox(
                                      height: 5,
                                    ),
                                  if (agency.frontCard != null)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0,
                                          right: 15,
                                          top: 10,
                                          bottom: 10),
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  seeImage(
                                                      imageUrl:
                                                          agency.frontCard);
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: CachedNetworkImage(
                                                    height: 70,
                                                    width: 100,
                                                    fit: BoxFit.cover,
                                                    imageUrl:
                                                        agency.frontCard == null
                                                            ? ""
                                                            : agency.frontCard!,
                                                    placeholder: (context,
                                                            url) =>
                                                        SahaLoadingContainer(),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            SahaEmptyImage(),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text("Mặt trước")
                                            ],
                                          ),
                                          Spacer(),
                                          Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  seeImage(
                                                      imageUrl:
                                                          agency.backCard);
                                                },
                                                child: CachedNetworkImage(
                                                  height: 70,
                                                  width: 100,
                                                  fit: BoxFit.cover,
                                                  imageUrl:
                                                      agency.backCard == null
                                                          ? ""
                                                          : agency.backCard!,
                                                  placeholder: (context, url) =>
                                                      SahaLoadingContainer(),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          SahaEmptyImage(),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text("Mặt sau")
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (agency.frontCard != null)
                                    SizedBox(
                                      height: 5,
                                    ),
                                  if (agency.accountNumber != null)
                                    Text(
                                        "STK: ${agency.accountNumber ?? "'Chưa có số tài khoản'"} - ${agency.bank ?? ""}"),
                                  if (agency.accountNumber != null)
                                    SizedBox(
                                      height: 5,
                                    ),
                                  if (agency.accountName != null)
                                    Text(
                                        "Tên chủ STK: ${agency.accountName ?? "'Chưa có'"} "),
                                ],
                              )
                            : Container(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  if (sahaDataController.badgeUser.value.decentralization
                          ?.agencyAddSubBalance !=
                      true) {
                    SahaAlert.showError(
                        message: "Bạn không có quyền");
                    return;
                  }
                  Get.to(() => HistoryBalanceAgencyScreen(
                        agency: agency,
                      ));
                },
                child: Row(
                  children: [
                    Text(
                      "Số dư: ${SahaStringUtils().convertToMoney(agency.balance ?? 0)}₫",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.history,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text("Trạng thái hoạt động: "),
              //     Obx(
              //       () => CupertinoSwitch(
              //         value: listAgencyController.listStatus[index],
              //         onChanged: (bool value) async {
              //           if (listAgencyController.listStatus[index] == true) {
              //             listAgencyController.updateAgency(
              //                 status: 0, idAgency: agency.id!, index: index);
              //           } else {
              //             listAgencyController.updateAgency(
              //                 status: 1, idAgency: agency.id!, index: index);
              //           }
              //         },
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => OrderManageScreen(
                        agencyId: agency.customerId,
                        initPageOrder: 3,
                      ));
                },
                child: Container(
                  width: (Get.width - 40) / 2,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.pink),
                      borderRadius: BorderRadius.circular(4)),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_basket_outlined,
                            color: Colors.pink),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            "Đơn hàng giới thiệu",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.pink, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  Get.to(() => ReportScreen(
                        agencyByCustomerId: agency.customerId,
                        isCtv: true,
                      ));
                },
                child: Container(
                  width: (Get.width - 40) / 2,
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.pink),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_basket_outlined,
                          color: Colors.pink,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            "Doanh số giới thiệu",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.pink, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => OrderManageScreen(
                        //agencyId: agency.customerId,
                        initPageOrder: 3,
                        phoneNumber: agency.customer?.phoneNumber,
                      ));
                },
                child: Container(
                  width: (Get.width - 40) / 2,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(4)),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.save_alt_rounded,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            "Đơn hàng nhập",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.blue, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  Get.to(() => ReportScreen(
                        agencyByCustomerId: agency.customerId,
                        isCtv: false,
                      ));
                },
                child: Container(
                  width: (Get.width - 40) / 2,
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.save_alt_rounded,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            "Doanh số nhập hàng",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.blue, fontSize: 13),
                          ),
                        ),
                      ],
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
}
