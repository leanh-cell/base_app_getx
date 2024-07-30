import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/saha_text_field_search.dart';
import 'package:com.ikitech.store/app_user/model/voucher_code.dart';
import 'package:com.ikitech.store/app_user/screen2/maketing_chanel/my_voucher/update_voucher/voucher_code/voucher_code_controller.dart';
import 'package:com.ikitech.store/app_user/utils/debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VoucherCodeScreen extends StatefulWidget {
  VoucherCodeScreen({Key? key, required this.voucherId}) : super(key: key) {
    controller = VoucherCodeController(voucherId: voucherId);
  }
  late VoucherCodeController controller;
  final int voucherId;

  @override
  State<VoucherCodeScreen> createState() => _VoucherCodeScreenState();
}

class _VoucherCodeScreenState extends State<VoucherCodeScreen>
    with SingleTickerProviderStateMixin {
  RefreshController refreshController = RefreshController();
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Danh sách mã voucher"),actions: [
        Obx(()=> widget.controller.isShutdown == true ? IconButton(onPressed: (){
          widget.controller.isShutdown.value = false;
        }, icon: Icon(Icons.clear)): const SizedBox())
      ],),
      
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            SizedBox(
              height: 45,
              width: Get.width,
              child: ColoredBox(
                color: Colors.white,
                child: TabBar(
                  controller: _tabController,
                  onTap: (v) {
                    widget.controller.status = v;
                    widget.controller.getAllVoucherCode(isRefresh: true);
                    
                  },
                  tabs: [
                    Tab(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Đã phát hành',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Tab(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Đã sử dụng',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Tab(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Đã kết thúc',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              height: 1,
            ),
            SahaTextFieldSearch(
              hintText: "Tìm kiếm",
              onChanged: (v) {
                EasyDebounce.debounce(
                    'debounce_search_code', const Duration(milliseconds: 300),
                    () {
                  widget.controller.textSearch = v;
                  widget.controller.getAllVoucherCode(isRefresh: true);
                });
              },
              onClose: () {
                widget.controller.textSearch = "";
                widget.controller.getAllVoucherCode(isRefresh: true);
              },
            ),
            Expanded(
              child: Obx(
                () => widget.controller.loadInit.value
                    ? SahaLoadingFullScreen()
                    : widget.controller.listVoucherCode.isEmpty
                        ? const Center(
                            child: Text('Không có mã nào'),
                          )
                        : SmartRefresher(
                            enablePullDown: true,
                            enablePullUp: true,
                            header: const MaterialClassicHeader(),
                            footer: CustomFooter(
                              builder: (
                                BuildContext context,
                                LoadStatus? mode,
                              ) {
                                Widget body = Container();
                                if (mode == LoadStatus.idle) {
                                  body = Obx(() =>
                                      widget.controller.isLoading.value
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
                            onRefresh: () async {
                              await widget.controller
                                  .getAllVoucherCode(isRefresh: true);
                              refreshController.refreshCompleted();
                            },
                            onLoading: () async {
                              await widget.controller.getAllVoucherCode();
                              refreshController.loadComplete();
                            },
                            child: ListView.builder(
                                addAutomaticKeepAlives: false,
                                addRepaintBoundaries: false,
                                itemCount:
                                    widget.controller.listVoucherCode.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return itemCode(
                                      widget.controller.listVoucherCode[index]);
                                }),
                          ),
              ),
            ),
          ])),
      bottomNavigationBar: Obx(() => widget.controller.isShutdown == true
          ? SizedBox(
              height: 65,
              child: Column(
                children: [
                  SahaButtonFullParent(
                    text: "Kết thúc",
                    onPressed: () {
                      widget.controller.endVoucherCode();
                    },
                  )
                ],
              ),
            )
          : const SizedBox()),
    );
  }

  Widget itemCode(VoucherCode voucherCode) {
    return InkWell(
      onLongPress: () {
        if (voucherCode.status == 0 || voucherCode.status == 1) {
          widget.controller.isShutdown.value =
              !widget.controller.isShutdown.value;
        }
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Mã voucher:"),
                      Text(
                        voucherCode.code ?? "",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Người sử dụng:"),
                      Text(voucherCode.customer?.name ?? ".....")
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Ngày sử dụng"),
                      Text(voucherCode.useTime == null
                          ? "...."
                          : DateFormat("dd-MM-yyyy")
                              .format(voucherCode.useTime!))
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Ngày phát hành"),
                      Text(voucherCode.startTime == null
                          ? "...."
                          : DateFormat("dd-MM-yyyy")
                              .format(voucherCode.startTime!))
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Ngày hết hạn"),
                      Text(voucherCode.endTime == null
                          ? "...."
                          : DateFormat("dd-MM-yyyy")
                              .format(voucherCode.endTime!))
                    ],
                  ),
                ],
              ),
            ),
            Obx(() => widget.controller.isShutdown == true && (voucherCode.status == 0 || voucherCode.status == 1)
                ? Checkbox(
                    value: widget.controller.listCodeChoose
                        .contains(voucherCode.id),
                    onChanged: (v) {
                      if (v == true) {
                        widget.controller.listCodeChoose.add(voucherCode.id!);
                      } else {
                        widget.controller.listCodeChoose
                            .remove(voucherCode.id!);
                      }
                    })
                : const SizedBox())
          ],
        ),
      ),
    );
  }
}
