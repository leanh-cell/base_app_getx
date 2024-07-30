import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/model/discount_product_list.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import '../../../../saha_data_controller.dart';
import 'create_my_program/create_my_program.dart';
import 'my_program_controller.dart';
import 'update_my_program/update_my_program.dart';

class MyProgram extends StatefulWidget {
  Function? onChange;

  MyProgram({this.onChange});

  @override
  _MyProgramState createState() => _MyProgramState();
}

class _MyProgramState extends State<MyProgram> with TickerProviderStateMixin {
  bool isHasDiscount = false;
  bool isTabOnTap = false;
  TabController? tabController;
  MyProgramController myProgramController = Get.put(MyProgramController());
  SahaDataController sahaDataController = Get.find();
  List<String> stateProgram = [
    "Không có khuyến mãi sắp diễn ra",
    "Không có khuyến mãi đang diễn ra",
    "Không có khuyến mãi đã kết thúc",
  ];

  List<String> stateProgramSub = [
    "Không có chương trình khuyến mãi nào sắp diễn ra",
    "Không có chương trình khuyến mãi nào đang diễn ra",
    "Không có chương trình khuyến mãi nào đã kết thúc",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = new TabController(length: 3, vsync: this, initialIndex: 0);
    //myProgramController.getAllDiscount();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('Giảm giá sản phẩm'),
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
                text: "Thêm sản phẩm giảm giá",
                onPressed: () {
                  Get.to(() => CreateMyProgram())!.then((value) => {
                        myProgramController.refreshData(),
                      });
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
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("Xem thêm");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("Đã hết Voucher kết thúc");
            } else {
              body = Text("Đã xem hết Voucher");
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
            myProgramController.loadInitEndDiscount();
          } else {
            myProgramController.refreshData();
          }
          _refreshController.refreshCompleted();
        },
        onLoading: () async {
          if (indexState == 2) {
            if (!myProgramController.isEndPageDiscount) {
              await myProgramController.loadMoreEndDiscount();
              _refreshController.loadComplete();
            } else {
              _refreshController.loadComplete();
            }
          }
        },
        child: Obx(
          () => myProgramController
                  .listAllSaveStateBefore[indexState].isNotEmpty
              ? Obx(
                  () => myProgramController.isRefreshingData.value == true &&
                          myProgramController
                              .listAllSaveStateBefore[indexState].isNotEmpty
                      ? SingleChildScrollView(
                          child: Column(
                            children: [
                              ...List.generate(
                                  myProgramController
                                      .listAllSaveStateBefore[indexState]
                                      .length, (index) {
                                return programIsComingItem(
                                    myProgramController
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
                                  myProgramController
                                      .listAllSaveStateBefore[indexState]
                                      .length, (index) {
                                return programIsComingItem(
                                    myProgramController
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
                        stateProgram[indexState],
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: Get.width * 0.9,
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        stateProgramSub[indexState],
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

  Widget programIsComingItem(
      DiscountProductsList listProgramState, int indexState) {
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
                          listProgramState.name!,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        width: Get.width * 0.7,
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${SahaDateUtils().getDDMMYY(listProgramState.startTime!)} ${SahaDateUtils().getHHMM(listProgramState.startTime!)} - ${SahaDateUtils().getDDMMYY(listProgramState.endTime!)} ${SahaDateUtils().getHHMM(listProgramState.endTime!)}",
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      imageUrl: (listProgramState.products ?? []).isEmpty
                          ? ""
                          : (listProgramState.products![0].images ?? []).isEmpty
                              ? ""
                              : "${listProgramState.products![0].images![0].imageUrl}",
                      errorWidget: (context, url, error) => ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Icon(
                            Icons.image,
                            color: Colors.grey,
                            size: 40,
                          )),
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
                            Get.to(() => UpdateMyProgram(
                                  programDiscount: listProgramState,
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
                            Get.to(() => UpdateMyProgram(
                                      programDiscount: listProgramState,
                                    ))!
                                .then((value) =>
                                    {myProgramController.refreshData()});
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
                                  myProgramController.endDiscount(
                                      listProgramState.id,
                                      true,
                                      "",
                                      "",
                                      "",
                                      "",
                                      "",
                                      0,
                                      false,
                                      0,
                                      null,
                                      null,
                                      null,
                                      null,
                                      null,
                                      "");
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
                                          'Bạn có chắc chắn muốn xoá chương trình này chứ ?',
                                      onOK: () {
                                        myProgramController.deleteDiscount(
                                          listProgramState.id,
                                        );
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
