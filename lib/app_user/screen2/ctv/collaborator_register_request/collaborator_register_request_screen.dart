import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../data/remote/response-request/ctv/all_collaborator_register_request_res.dart';
import '../../../utils/string_utils.dart';
import 'collaborator_register_detail/collaborator_register_detail_screen.dart';
import 'collaborator_register_request_controller.dart';

class CollaboratorRegisterRequestScreen extends StatefulWidget {
  const CollaboratorRegisterRequestScreen({Key? key}) : super(key: key);

  @override
  State<CollaboratorRegisterRequestScreen> createState() =>
      _CollaboratorRegisterRequestScreenState();
}

class _CollaboratorRegisterRequestScreenState
    extends State<CollaboratorRegisterRequestScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  RefreshController refreshController = RefreshController();
  CollaboratorRegisterController controller = CollaboratorRegisterController();
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yêu cầu làm cộng tác viên"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 45,
                width: Get.width,
                child: ColoredBox(
                  color: Colors.white,
                  child: TabBar(
                    controller: _tabController,
                    onTap: (v) {
                      controller.status = v == 0
                          ? 0
                          : v == 1
                              ? 3
                              : v == 2
                                  ? 2
                                  : 1;
                      controller.getAllCollaboratorRegisterRequest(
                          isRefresh: true);
                    },
                    tabs: [
                      Tab(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Chờ duyệt',
                              style: TextStyle(
                                color: Colors.orange,
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
                              'Duyệt lại',
                              style: TextStyle(
                                color: Colors.deepOrange,
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
                              'Đã duyệt',
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
                              'Đã huỷ',
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
            ],
          ),
          // SahaTextFieldSearch(
          //   hintText: "Tìm kiếm phòng trọ",
          //   onChanged: (va) {
          //     EasyDebounce.debounce(
          //         'list_motel_room', const Duration(milliseconds: 300), () {
          //       widget.listMotelRoomController.textSearch = va;
          //       widget.listMotelRoomController.getAllMotelRoom(isRefresh: true);
          //     });
          //   },
          //   onClose: () {
          //     widget.listMotelRoomController.textSearch = "";
          //     widget.listMotelRoomController.getAllMotelRoom(isRefresh: true);
          //   },
          // ),
          Obx(
            () => Expanded(
              child: SmartRefresher(
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
                enablePullDown: true,
                enablePullUp: true,
                header: const MaterialClassicHeader(),
                onRefresh: () async {
                  await controller.getAllCollaboratorRegisterRequest(
                      isRefresh: true);
                  refreshController.refreshCompleted();
                },
                onLoading: () async {
                  await controller.getAllCollaboratorRegisterRequest();
                  refreshController.loadComplete();
                },
                controller: refreshController,
                child: ListView.builder(
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    itemCount: controller.listRegisterRequest.length,
                    itemBuilder: (BuildContext context, int index) {
                      return itemRegisterCollab(
                          controller.listRegisterRequest[index]);
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemRegisterCollab(
      CollaboratorRegisterRequest collaboratorRegisterRequest) {
    return InkWell(
      onTap: () {
        Get.to(() => CollaboratorRegisterDetailScreen(
              collaboratorRegisterRequest: collaboratorRegisterRequest,
            ));
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Tên profile:"),
                Text(collaboratorRegisterRequest.collaborator?.customer?.name ??
                    '')
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Tên tài khoản:"),
                Text(
                    collaboratorRegisterRequest.collaborator?.accountName ?? '')
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Doanh số:"),
                Text(
                    '${SahaStringUtils().convertToUnit(collaboratorRegisterRequest.collaborator?.customer?.totalAfterDiscountNoBonus ?? 0)} đ')
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Số điện thoại:"),
                Text(collaboratorRegisterRequest
                        .collaborator?.customer?.phoneNumber ??
                    '')
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Thời gian yêu cầu:"),
                Text(
                    "${DateFormat("HH:mm").format(collaboratorRegisterRequest.createdAt!.toLocal())} - ${DateFormat("dd-MM-yyyy").format(collaboratorRegisterRequest.collaborator?.createdAt!.toLocal() ?? DateTime.now())}")
              ],
            ),
            if (collaboratorRegisterRequest.status == 0 ||
                collaboratorRegisterRequest.status == 3)
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () async {
                          await controller.updateStatusCollaboratorRequest(
                              requestId: collaboratorRegisterRequest.id!,
                              status: 2);
                          _tabController.animateTo(2);
                          controller.status = 2;
                          controller.getAllCollaboratorRegisterRequest(
                              isRefresh: true);
                        },
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                            "Duyệt",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await controller.updateStatusCollaboratorRequest(
                              requestId: collaboratorRegisterRequest.id!,
                              status: 1);
                          _tabController.animateTo(3);
                          controller.status = 1;
                          controller.getAllCollaboratorRegisterRequest(
                              isRefresh: true);
                        },
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                            "Huỷ",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                    ],
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
