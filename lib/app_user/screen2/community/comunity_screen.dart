import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/saha_data_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_customer/app_customer/model/info_customer.dart';

import '../../components/saha_user/dialog/dialog.dart';
import '../../components/saha_user/text_field/saha_text_field_search.dart';
import 'add_update_community_post/add_update_community_post_screen.dart';
import 'community_controller.dart';
import 'widget/post_cmt_widget.dart';

class CommunityScreen extends StatelessWidget {
  final InfoCustomer? customer;

  CommunityScreen({Key? key, this.customer}) {
    communityController = CommunityController(customer: customer);
  }

  late CommunityController communityController;
  SahaDataController sahaDataController = Get.find();
  buildListBuy(int status) {
    RefreshController refreshController =
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
            body = Obx(() => communityController.isLoading.value
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
        await communityController.getPostCmt(
          isRefresh: true,
          status: status,
        );
        refreshController.refreshCompleted();
      },
      onLoading: () async {
        await communityController.getPostCmt(
          status: status,
        );
        refreshController.loadComplete();
      },
      child: Obx(() => SingleChildScrollView(
            child: Column(
              children: communityController.listPost
                  .map((e) => PostCmtWidget(
                        check: () async {
                          await communityController.updateCommunityPost(
                              e.id!, e, 0);
                          communityController.getPostCmt(
                              isRefresh: true, status: status);
                        },
                        hide: () async {
                          if (sahaDataController.badgeUser.value
                                  .decentralization?.communicationApprove !=
                              true) {
                            SahaAlert.showError(
                                message: "Bạn không có quyền ẩn bài đăng");
                            return;
                          }
                          await communityController.updateCommunityPost(
                              e.id!, e, 2);
                          communityController.getPostCmt(
                              isRefresh: true, status: status);
                        },
                        onPin: (isPin) {
                            if (sahaDataController.badgeUser.value
                                  .decentralization?.communicationApprove !=
                              true) {
                            SahaAlert.showError(
                                message: "Bạn không có quyền pin bài đăng");
                            return;
                          }
                          communityController.pinPostCmt(e.id!, isPin);
                        },
                        onResetParentList: () {
                          communityController.getPostCmt(
                              isRefresh: true, status: status);
                        },
                        post: e,
                        update: () {
                          if (sahaDataController.badgeUser.value
                                  .decentralization?.communicationUpdate !=
                              true) {
                            SahaAlert.showError(
                                message: "Bạn không có quyền sửa bài đăng");
                            return;
                          }
                          Get.to(() => AddUpdateCommunityPostScreen(
                                    communityPostInput: e,
                                  ))!
                              .then((value) => {
                                    communityController.getPostCmt(
                                      isRefresh: true,
                                      status: status,
                                    )
                                  });
                        },
                        delete: () {
                          if (sahaDataController.badgeUser.value
                                  .decentralization?.communicationDelete !=
                              true) {
                            SahaAlert.showError(
                                message: "Bạn không có quyền xoá bài đăng");
                            return;
                          }
                          SahaDialogApp.showDialogYesNo(
                              mess:
                                  "Bạn có chắc chắn muốn xoá bài đăng này chứ",
                              onOK: () async {
                                await communityController.deletePost(e.id!);
                                communityController.getPostCmt(
                                    isRefresh: true, status: status);
                              });
                        },
                        rePost: () {
                          if (sahaDataController.badgeUser.value
                                  .decentralization?.communicationUpdate !=
                              true) {
                            SahaAlert.showError(
                                message: "Bạn không có quyền đăng bài đăng");
                            return;
                          }
                          SahaDialogApp.showDialogYesNo(
                              mess: "Bạn muốn lên top lại bài này?",
                              onOK: () async {
                                await communityController.reUpPostCmt(e.id!);
                                communityController.getPostCmt(
                                    isRefresh: true, status: status);
                              });
                        },
                      ))
                  .toList(),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "Đang hiển thị",
                ),
                Tab(
                  text: "Chờ duyệt",
                ),
                Tab(
                  text: "Đang bị ẩn",
                ),
                Tab(
                  text: "Được ghim",
                ),
              ],
            ),
            title: Text('Quản lý tin đăng'),
          ),
          body: Column(
            children: [
              if (customer != null)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Bài đăng của User: " + customer!.name!,
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                ),
              SahaTextFieldSearch(
                hintText: "Tìm kiếm bài đăng",
                onChanged: (v) {
                  communityController.textSearch = v;
                  communityController.getPostCmt(isRefresh: true);
                },
                onClose: () {
                  communityController.textSearch = "";
                  communityController.getPostCmt(isRefresh: true);
                },
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    buildListBuy(0),
                    buildListBuy(1),
                    buildListBuy(2),
                    buildListBuy(3),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
