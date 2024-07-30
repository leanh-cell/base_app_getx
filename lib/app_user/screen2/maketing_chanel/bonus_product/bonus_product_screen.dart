import 'package:com.ikitech.store/app_user/screen2/maketing_chanel/bonus_product/update_bonus_product/update_bonus_product_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../saha_data_controller.dart';
import '../../../components/saha_user/button/saha_button.dart';
import '../../../components/saha_user/dialog/dialog.dart';
import '../../../model/bonus_product.dart';
import '../../../utils/date_utils.dart';
import 'bonus_product_controller.dart';
import 'create_bonus_product/create_bonus_product_screen.dart';

class BonusProductScreen extends StatefulWidget {
  @override
  _BonusProductScreenState createState() => _BonusProductScreenState();
}

class _BonusProductScreenState extends State<BonusProductScreen>
    with TickerProviderStateMixin {
  bool isHasDiscount = false;
  bool isTabOnTap = false;
  TabController? tabController;
  BonusProductController bonusProductController =
      Get.put(BonusProductController());
  SahaDataController sahaDataController = Get.find();

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
          title: Text('Tặng thưởng sản phẩm'),
          bottom: TabBar(
            controller: tabController,
            onTap: (index) {
              isTabOnTap = true;
            },
            tabs: [
              Tab(text: "Sắp diễn ra"),
              Tab(text: "Đang diễn ra"),
              Tab(text: "Đã kết thúc"),
            ],
          ),
        ),
        body: TabBarView(controller: tabController, children: [
          isComing(),
          isRunning(),
          isEnd(),
        ]),
        bottomNavigationBar: Container(
          height: 65,
          color: Colors.white,
          child: Column(
            children: [
              SahaButtonFullParent(
                text: "Tạo tặng thưởng sản phẩm",
                onPressed: () {
                  Get.to(() => CreateBonusProductScreen())!.then((value) => {});
                },
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget isComing() {
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
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("Xem thêm");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("Đã hết Combo kết thúc");
            } else {
              body = Text("Đã xem hết Combo");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: () async {
          bonusProductController.getAllBonusProduct();
          _refreshController.refreshCompleted();
        },
        // onLoading: () async {
        //   if (indexState == 2) {
        //     if (!bonusProductController.isEndPageCombo) {
        //       bonusProductController.loadMoreEndCombo();
        //       _refreshController.loadComplete();
        //     } else {
        //       _refreshController.loadComplete();
        //     }
        //   }
        // },
        child: Obx(
          () => bonusProductController.listBonusProduct.isNotEmpty
              ? SingleChildScrollView(
                  child: Column(
                    children: bonusProductController.listBonusProduct
                        .map((e) => e.startTime!.isAfter(DateTime.now())
                            ? programIsComingItem(e, 1)
                            : Container())
                        .toList(),
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
                  ],
                ),
        ));
  }

  Widget isRunning() {
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
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text("Xem thêm");
          } else if (mode == LoadStatus.loading) {
            body = CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text("Load Failed!Click retry!");
          } else if (mode == LoadStatus.canLoading) {
            body = Text("Đã hết Combo kết thúc");
          } else {
            body = Text("Đã xem hết Combo");
          }
          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: () async {
        bonusProductController.getAllBonusProduct();
        _refreshController.refreshCompleted();
      },
      child: Obx(
        () => bonusProductController.listBonusProduct.isNotEmpty
            ? SingleChildScrollView(
                child: Column(
                  children: bonusProductController.listBonusProduct
                      .map((e) => e.endTime!.isAfter(DateTime.now())
                          ? programIsComingItem(e, 2)
                          : Container())
                      .toList(),
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
                ],
              ),
      ),
    );
  }

  Widget isEnd() {
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
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text("Xem thêm");
          } else if (mode == LoadStatus.loading) {
            body = CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text("Load Failed!Click retry!");
          } else if (mode == LoadStatus.canLoading) {
            body = Text("Đã hết Combo kết thúc");
          } else {
            body = Text("Đã xem hết Combo");
          }
          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: () async {
        bonusProductController.getEndBonusProduct(isRefresh: true);
        _refreshController.refreshCompleted();
      },
      onLoading: () async {
        bonusProductController.getEndBonusProduct();
        _refreshController.loadComplete();
      },
      child: Obx(
        () => bonusProductController.listBonusProduct.isNotEmpty
            ? SingleChildScrollView(
                child: Column(
                  children: bonusProductController.listBonusProduct
                      .map((e) => programIsComingItem(e, 3))
                      .toList(),
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
                ],
              ),
      ),
    );
  }

  Widget programIsComingItem(BonusProduct listComboState, int type) {
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
                        width: Get.width * 0.6,
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          listComboState.name!,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Số lượng đã sử dụng: ${listComboState.used ?? 0}",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 12),
                      ),
                      Container(
                        width: Get.width * 0.7,
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${SahaDateUtils().getDDMMYY(listComboState.startTime!)} ${SahaDateUtils().getHHMM(listComboState.startTime!)} - ${SahaDateUtils().getDDMMYY(listComboState.endTime!)} ${SahaDateUtils().getHHMM(listComboState.endTime!)}",
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                        width: 55,
                        height: 55,
                        child: SvgPicture.asset(
                          "assets/icons/gift_box.svg",
                          color: Theme.of(context).primaryColor,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              if (type != 3)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => CreateBonusProductScreen(
                                  bonusProductInput: listComboState,
                                ))!
                            .then((value) =>
                                {bonusProductController.getAllBonusProduct()});
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
                    type == 2
                        ? InkWell(
                            onTap: () {
                              bonusProductController
                                  .endBonusProduct(listComboState.id);
                            },
                            child: Container(
                              height: 35,
                              width: Get.width * 0.45,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[600]!),
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
                                      'Bạn có chắc chắn muốn xoá combo này chứ ?',
                                  onOK: () {
                                    bonusProductController
                                        .deleteCombo(listComboState.id);
                                  });
                            },
                            child: Container(
                              height: 35,
                              width: Get.width * 0.45,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[600]!),
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              child: Center(
                                child: Text("Xoá"),
                              ),
                            ),
                          ),
                  ],
                ),
              type == 3
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(() => CreateBonusProductScreen(
                                      bonusProductInput: listComboState,
                                      isWatch: true,
                                    ))!
                                .then((value) => {
                                      bonusProductController
                                          .getEndBonusProduct(isRefresh: true)
                                    });
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
                  : Container()
            ],
          )),
    );
  }
}
