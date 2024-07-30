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
import 'package:url_launcher/url_launcher.dart';

import '../../../components/saha_user/call/call.dart';
import '../../order_manage/order_manage_screen.dart';
import 'list_ctv_controller.dart';

class ListCtvScreen extends StatefulWidget {
  @override
  _ListCtvScreenState createState() => _ListCtvScreenState();
}

class _ListCtvScreenState extends State<ListCtvScreen> {
  ListCtvController listCtvController = ListCtvController();

  RefreshController refreshController = RefreshController(initialRefresh: true);

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
                        "Tên: ${ctv.customer?.name ?? "'Chưa đặt tên'"}"),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        "Phone: ${ctv.customer?.phoneNumber ?? "'Chưa có sđt'"}"),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        "Tên CMND: ${ctv.firstAndLastName ?? "'Chưa đặt tên'"}"),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        "CMND: ${ctv.cmnd ?? "'Chưa có cmnd'"} - ${ctv.issuedBy ?? ""}"),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15, top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  seeImage(imageUrl: ctv.frontCard);
                                },
                                child: CachedNetworkImage(
                                  height: 70,
                                  width: 100,
                                  fit: BoxFit.cover,
                                  imageUrl: ctv.frontCard == null
                                      ? ""
                                      : ctv.frontCard!,
                                  placeholder: (context, url) =>
                                      SahaLoadingContainer(),
                                  errorWidget: (context, url, error) =>
                                      SahaEmptyImage(),
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
                                  seeImage(imageUrl: ctv.backCard);
                                },
                                child: CachedNetworkImage(
                                  height: 70,
                                  width: 100,
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      ctv.backCard == null ? "" : ctv.backCard!,
                                  placeholder: (context, url) =>
                                      SahaLoadingContainer(),
                                  errorWidget: (context, url, error) =>
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
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        "STK: ${ctv.accountNumber ?? "'Chưa có số tài khoản'"} - ${ctv.bank ?? ""}"),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Tên chủ STK: ${ctv.accountName ?? "'Chưa có'"} "),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Trạng thái hoạt động: "),
                        Obx(
                          () => CupertinoSwitch(
                            value: listCtvController.listStatus[index],
                            onChanged: (bool value) async {
                              if (listCtvController.listStatus[index] == true) {
                                listCtvController.updateCtv(
                                    status: 0, idCtv: ctv.id!, index: index);
                              } else {
                                listCtvController.updateCtv(
                                    status: 1, idCtv: ctv.id!, index: index);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Text(
                        "Tiền thưởng: ${SahaStringUtils().convertToMoney(ctv.balance ?? 0)}₫"),
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
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => OrderManageScreen(
                        ctvId: ctv.customerId,
                        initPageOrder: 3,
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
}
