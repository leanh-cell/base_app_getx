import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_container.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/saha_text_field_search.dart';
import 'package:com.ikitech.store/app_user/model/ctv.dart';
import 'package:com.ikitech.store/app_user/screen2/report/report_ctv_agency/report_screen.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:screenshot/screenshot.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../saha_data_controller.dart';
import '../../../components/saha_user/call/call.dart';
import '../../../components/saha_user/toast/saha_alert.dart';
import '../../order_manage/order_manage_screen.dart';
import 'history_balance/history_balance_screen.dart';
import 'list_ctv_controller.dart';

class ListCtvScreen extends StatefulWidget {
  @override
  _ListCtvScreenState createState() => _ListCtvScreenState();
}

class _ListCtvScreenState extends State<ListCtvScreen> {
  ListCtvController listCtvController = ListCtvController();

  RefreshController refreshController = RefreshController(initialRefresh: true);
   SahaDataController sahaDataController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => listCtvController.isSearch.value
              ? SahaTextFieldSearch(
                  onSubmitted: (va) {
                    listCtvController.textSearch = va;
                    listCtvController.getListCtv(
                        searchText: listCtvController.textSearch,
                        isRefresh: true);
                  },
                  onClose: () {
                    listCtvController.textSearch = null;
                    listCtvController.isSearch.value = false;
                  },
                )
              : Text("Tất cả CTV"),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search_outlined),
              onPressed: () {
                listCtvController.isSearch.value = true;
              })
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
              body = Obx(() => listCtvController.isLoadMore.value
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
          await listCtvController.getListCtv(
              searchText: listCtvController.textSearch, isRefresh: true);
          refreshController.refreshCompleted();
        },
        onLoading: () async {
          await listCtvController.getListCtv(
              searchText: listCtvController.textSearch, isRefresh: false);
          refreshController.loadComplete();
        },
        child: SingleChildScrollView(
          child: Obx(
            () => Column(children: [
              ...List.generate(listCtvController.listCtv.length,
                  (index) => itemCtv(listCtvController.listCtv[index], index))
            ]),
          ),
        ),
      ),
    );
  }

  Widget itemCtv(Ctv ctv, int index) {
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
                        "Họ và tên: ${ctv.customer?.name ?? "'Chưa đặt tên'"}"),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        "Phone: ${ctv.customer?.phoneNumber ?? "'Chưa có sđt'"}"),
                    SizedBox(
                      height: 5,
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
                                  if (ctv.firstAndLastName != null)
                                    Text(
                                        "Tên CMND: ${ctv.firstAndLastName ?? "'Chưa đặt tên'"}"),
                                  if (ctv.firstAndLastName != null)
                                    SizedBox(
                                      height: 5,
                                    ),
                                  if (ctv.cmnd != null)
                                    Text(
                                        "CMND: ${ctv.cmnd ?? "'Chưa có cmnd'"} - ${ctv.issuedBy ?? ""}"),
                                  if (ctv.cmnd != null)
                                    SizedBox(
                                      height: 5,
                                    ),
                                  if (ctv.frontCard != null)
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
                                                      imageUrl: ctv.frontCard);
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: CachedNetworkImage(
                                                    height: 70,
                                                    width: 100,
                                                    fit: BoxFit.cover,
                                                    imageUrl:
                                                        ctv.frontCard == null
                                                            ? ""
                                                            : ctv.frontCard!,
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
                                                      imageUrl: ctv.backCard);
                                                },
                                                child: CachedNetworkImage(
                                                  height: 70,
                                                  width: 100,
                                                  fit: BoxFit.cover,
                                                  imageUrl: ctv.backCard == null
                                                      ? ""
                                                      : ctv.backCard!,
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
                                  if (ctv.frontCard != null)
                                    SizedBox(
                                      height: 5,
                                    ),
                                  if (ctv.accountNumber != null)
                                    Text(
                                        "STK: ${ctv.accountNumber ?? "'Chưa có số tài khoản'"} - ${ctv.bank ?? ""}"),
                                  if (ctv.accountNumber != null)
                                    SizedBox(
                                      height: 5,
                                    ),
                                  if (ctv.accountName != null)
                                    Text(
                                        "Tên chủ STK: ${ctv.accountName ?? "'Chưa có'"} "),
                                ],
                              )
                            : Container(),
                      ),
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
              //     Text(
              //       "Trạng thái hoạt động: ",
              //       style: TextStyle(
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //     Obx(
              //       () => CupertinoSwitch(
              //         value: listCtvController.listStatus[index],
              //         onChanged: (bool value) async {
              //           if (listCtvController.listStatus[index] == true) {
              //             listCtvController.updateCtv(
              //                 status: 0, idCtv: ctv.id!, index: index);
              //           } else {
              //             listCtvController.updateCtv(
              //                 status: 1, idCtv: ctv.id!, index: index);
              //           }
              //         },
              //       ),
              //     ),
              //   ],
              // ),
              InkWell(
                onTap: () {
                   if (sahaDataController
                          .badgeUser.value.decentralization?.collaboratorAddSubBalance !=
                      true) {
                    SahaAlert.showError(message: "Bạn không có quyền truy cập");
                    return;
                  }
                  Get.to(() => HistoryBalanceScreen(
                            ctv: ctv,
                          ))!
                      .then((v) => {
                            listCtvController.getListCtv(isRefresh: true),
                          });
                },
                child: Row(
                  children: [
                    Text(
                      "Số dư: ${SahaStringUtils().convertToMoney(ctv.balance ?? 0)}₫",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
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
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => OrderManageScreen(
                        ctvId: ctv.customerId,
                        initPageOrder: 3,
                      ));
                },
                child: Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(4)),
                  child: Center(
                    child: Row(
                      children: [
                        Icon(Icons.list_alt_outlined,
                            color: Theme.of(context).primaryColor),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Đơn hàng",
                          style: TextStyle(
                              color: Theme.of(Get.context!).primaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => ReportScreen(
                        collaboratorByCustomerId: ctv.customerId,
                      ));
                },
                child: Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(4)),
                  child: Center(
                    child: Row(
                      children: [
                        Icon(Icons.bar_chart,
                            color: Theme.of(context).primaryColor),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Báo cáo doanh số",
                          style: TextStyle(
                              color: Theme.of(Get.context!).primaryColor),
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
