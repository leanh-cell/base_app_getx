import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/model/voucher.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';

import '../../../../saha_data_controller.dart';
import '../../../components/saha_user/dialog/dialog.dart';
import 'create_my_voucher/create_my_voucher_screen.dart';
import 'my_voucher_controller.dart';
import 'update_voucher/update_voucher_screen.dart';

class MyVoucherScreen extends StatefulWidget {
  @override
  _MyVoucherScreenState createState() => _MyVoucherScreenState();
}

class _MyVoucherScreenState extends State<MyVoucherScreen>
    with TickerProviderStateMixin {
  bool isHasDiscount = false;
  bool isTabOnTap = false;
  TabController? tabController;
  MyVoucherController myVoucherController = Get.put(MyVoucherController());
  SahaDataController sahaDataController = Get.find();
  List<String> stateVoucher = [
    "Chưa có Voucher nào được tạo",
    "Chưa có Voucher nào được tạo",
    "Chưa có Voucher nào được tạo",
  ];

  List<String> stateVoucherSub = [
    "Tạo mã giảm giá cho toàn shop hoặc cho các sản phẩm cụ thể để thu hút khách hàng nhé.",
    "Tạo mã giảm giá cho toàn shop hoặc cho các sản phẩm cụ thể để thu hút khách hàng nhé.",
    "Tạo mã giảm giá cho toàn shop hoặc cho các sản phẩm cụ thể để thu hút khách hàng nhé.",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = new TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('Mã voucher'),
          bottom: TabBar(
            controller: tabController,
            tabs: [
              Tab(text: "Sắp diễn ra"),
              Tab(text: "Đang diễn ra"),
              Tab(text: "Đã kết thúc"),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: List<Widget>.generate(3, (int index) {
            return buildStateProgram(index);
          }),
        ),
        bottomNavigationBar: Container(
          height: 65,
          color: Colors.white,
          child: Column(
            children: [
              SahaButtonFullParent(
                text: "Tạo Voucher mới",
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 250,
                        color: Colors.white,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                                Get.to(() => CreateMyVoucher(
                                          voucherType: 0,
                                        ))!
                                    .then((value) =>
                                        {myVoucherController.refreshData()});
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                height: 80,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Tạo Voucher toàn Shop",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Có thể áp dụng voucher này cho tất cả các sản phẩm trong Shop của bạn",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              height: 1,
                            ),
                            InkWell(
                              onTap: () {
                                Get.back();
                                Get.to(() => CreateMyVoucher(
                                          voucherType: 1,
                                        ))!
                                    .then((value) =>
                                        {myVoucherController.refreshData()});
                              },
                              child: Container(
                                height: 80,
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Tạo Voucher sản phẩm",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Có thể áp dụng voucher này cho một số sản phẩm nhất định trong Shop của bạn",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 10,
                              color: Colors.grey[200],
                            ),
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                height: 50,
                                child: Center(
                                  child: Text(
                                    "Thoát",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStateProgram(int indexState) {
    RefreshController _refreshController =
        RefreshController(initialRefresh: true);
    return SmartRefresher(
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
              body = Obx(() => myVoucherController.isLoadMore.value
                  ? CupertinoActivityIndicator()
                  : Container());
            } else if (mode == LoadStatus.loading) {
              body = Obx(() => myVoucherController.isLoadMore.value
                  ? CupertinoActivityIndicator()
                  : Container());
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: () async {
          if (indexState == 2) {
            myVoucherController.loadInitEndVoucher();
          } else {
            myVoucherController.refreshData();
          }
          _refreshController.refreshCompleted();
        },
        onLoading: () async {
          if (indexState == 2) {
            if (!myVoucherController.isEndPageVoucher) {
              await myVoucherController.loadMoreEndVoucher();
              _refreshController.loadComplete();
            } else {
              _refreshController.loadComplete();
            }
          }
        },
        child: Obx(
          () => myVoucherController
                  .listAllSaveStateBefore[indexState].isNotEmpty
              ? Obx(
                  () => myVoucherController.isRefreshingData.value == true &&
                          myVoucherController
                              .listAllSaveStateBefore[indexState].isNotEmpty
                      ? SingleChildScrollView(
                          child: Column(
                            children: [
                              ...List.generate(
                                  myVoucherController
                                      .listAllSaveStateBefore[indexState]
                                      .length, (index) {
                                return programIsComingItem(
                                    myVoucherController
                                            .listAllSaveStateBefore[indexState]
                                        [index],
                                    indexState);
                              })
                            ],
                          ),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              ...List.generate(
                                  myVoucherController
                                      .listAllSaveStateBefore[indexState]
                                      .length, (index) {
                                return programIsComingItem(
                                    myVoucherController
                                            .listAllSaveStateBefore[indexState]
                                        [index],
                                    indexState);
                              })
                            ],
                          ),
                        ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: EdgeInsets.all(15.0),
                        width: Get.width * 0.4,
                        child: AspectRatio(
                            aspectRatio: 1,
                            child:
                                SvgPicture.asset("assets/icons/time_out.svg"))),
                    Container(
                      width: Get.width * 0.9,
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        stateVoucher[indexState],
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: Get.width * 0.9,
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        stateVoucherSub[indexState],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
        ));
  }

  Widget programIsComingItem(Voucher listVoucherState, int indexState) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
          width: Get.width,
          color: Colors.white,
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          listVoucherState.name!,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        width: Get.width * 0.7,
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${SahaDateUtils().getDDMMYY(listVoucherState.startTime!)} ${SahaDateUtils().getHHMM(listVoucherState.startTime!)} - ${SahaDateUtils().getDDMMYY(listVoucherState.endTime!)} ${SahaDateUtils().getHHMM(listVoucherState.endTime!)}",
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                        width: 55,
                        height: 55,
                        child: Icon(
                          Icons.card_giftcard_rounded,
                          color: Theme.of(context).primaryColor,
                          size: 40,
                        )),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            listVoucherState.discountFor == 1
                                ? (listVoucherState.shipDiscountValue ?? 0) == 0
                                    ? Container()
                                    : Text(
                                        "Tối đa: đ${SahaStringUtils().convertToMoney(listVoucherState.shipDiscountValue ?? 0)}",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.w500),
                                      )
                                : listVoucherState.discountType == 1
                                    ? Text(
                                        "${SahaStringUtils().convertToMoney(listVoucherState.valueDiscount ?? 0)}% Giảm",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.w500),
                                      )
                                    : Text(
                                        "₫${SahaStringUtils().convertToMoney(listVoucherState.valueDiscount ?? 0)} Giảm",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                            SizedBox(
                              height: 3,
                            ),
                            if (listVoucherState.discountFor == 1)
                            Text(
                              "Miễn phí vận chuyển",
                              style: TextStyle(
                                  color:
                                  Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "Đơn tối thiểu ₫${SahaStringUtils().convertToMoney("${listVoucherState.valueLimitTotal ?? 0}")}",
                              style: TextStyle(fontSize: 13),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            listVoucherState.voucherType == 0
                                ? Text(
                                    "Voucher toàn Shop",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey[600]),
                                  )
                                : Text(
                                    "Voucher theo sản phẩm",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey[600]),
                                  ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "Số lượng đã sử dụng: ${listVoucherState.used ?? 0}",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                        Text("${listVoucherState.code}")
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              indexState == 2
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(() => UpdateMyVoucherScreen(
                                  voucher: listVoucherState,
                                  onlyWatch: true,
                                ));
                          },
                          child: Container(
                            height: 35,
                            width: Get.width * 0.9,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[600]!),
                                borderRadius: BorderRadius.circular(2.0)),
                            child: Center(
                              child: Text("Xem"),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(() => UpdateMyVoucherScreen(
                                      voucher: listVoucherState,
                                    ))!
                                .then((value) =>
                                    {myVoucherController.refreshData()});
                          },
                          child: Container(
                            height: 35,
                            width: Get.width * 0.45,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[600]!),
                                borderRadius: BorderRadius.circular(2.0)),
                            child: Center(
                              child: Text("Thay đổi"),
                            ),
                          ),
                        ),
                        indexState == 1
                            ? InkWell(
                                onTap: () {
                                  myVoucherController
                                      .endVoucher(listVoucherState.id);
                                },
                                child: Container(
                                  height: 35,
                                  width: Get.width * 0.45,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey[600]!),
                                    borderRadius: BorderRadius.circular(2.0),
                                  ),
                                  child: Center(
                                    child: Text("Kết thúc ngay"),
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  SahaDialogApp.showDialogYesNo(
                                      mess:
                                          'Bạn có chắc chắn muốn xoá voucher này chứ ?',
                                      onOK: () {
                                        myVoucherController
                                            .deleteVoucher(listVoucherState.id);
                                      });
                                },
                                child: Container(
                                  height: 35,
                                  width: Get.width * 0.45,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey[600]!),
                                    borderRadius: BorderRadius.circular(2.0),
                                  ),
                                  child: Center(
                                    child: Text("Xoá"),
                                  ),
                                ),
                              ),
                      ],
                    ),
            ],
          )),
    );
  }
}
