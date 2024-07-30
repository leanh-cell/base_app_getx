import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/decentralization/decentralization_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty/saha_empty_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty_widget/saha_empty_chat_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_container.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/chat/chat_user_screen/chat_user_screen.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../saha_data_controller.dart';
import '../../../model/box_chat_customer.dart';
import 'all_box_chat_user_controller.dart';

// ignore: must_be_immutable
class AllBoxChatUSerScreen extends StatefulWidget {
  AllBoxChatUSerScreen({this.customerId});
  final int? customerId;
  @override
  State<AllBoxChatUSerScreen> createState() => _AllBoxChatUSerScreenState();
}

class _AllBoxChatUSerScreenState extends State<AllBoxChatUSerScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  AllBoxChatUserController allBoxChatUserController =
      Get.put(AllBoxChatUserController());


  @override
  void initState(){
     if (widget.customerId != null) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
     Get.to(()=> Get.to(() => ChatUserScreen(
             boxChatCustomerInput: BoxChatCustomer(),
           )));
  });
}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => allBoxChatUserController.isSearch.value
              ? Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey[100],
                  ),
                  child: TextField(
                    style: TextStyle(fontSize: 14),
                    autofocus: true,
                    decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: "Search"),
                    minLines: 1,
                    maxLines: 1,
                  ),
                )
              : Text('Chat'),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                if (allBoxChatUserController.isSearch.value == false) {
                  allBoxChatUserController.isSearch.value = true;
                } else {
                  allBoxChatUserController.isSearch.value = false;
                }
              }),
        ],
      ),
      body: Obx(
        () => allBoxChatUserController.isLoadingBoxChatCustomer.value == true
            ? SahaLoadingFullScreen()
            : allBoxChatUserController.listBoxChatCustomer.isEmpty
                ? SahaEmptyChatWidget(
                    width: 50,
                    height: 50,
                  )
                : SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    header: MaterialClassicHeader(),
                    footer: CustomFooter(
                      builder: (
                        BuildContext context,
                        LoadStatus? mode,
                      ) {
                        Widget? body;
                        if (mode == LoadStatus.idle) {
                        } else if (mode == LoadStatus.loading) {
                          body = CupertinoActivityIndicator();
                        } else if (mode == LoadStatus.canLoading) {
                          body = Text("Đã hết User");
                        } else {
                          body = Text("Đã xem hết User");
                        }
                        return Container(
                          height: 55.0,
                          child: Center(child: body),
                        );
                      },
                    ),
                    controller: _refreshController,
                    onRefresh: () async {
                      await allBoxChatUserController.loadInitChatUser();
                      _refreshController.refreshCompleted();
                    },
                    onLoading: () async {
                      await allBoxChatUserController.loadMoreChatUser();
                      _refreshController.loadComplete();
                    },
                    child: ListView.builder(
                        itemCount:
                            allBoxChatUserController.listBoxChatCustomer.length,
                        itemBuilder: (context, index) {
                          return itemChatUser(allBoxChatUserController
                              .listBoxChatCustomer[index]);
                        }),
                  ),
      ),
    );
  }

  final SahaDataController sahaDataController = Get.find();

  Widget itemChatUser(BoxChatCustomer boxChatCustomer) {
    return DecentralizationWidget(
      decent: true,
      child: InkWell(
        onTap: () {
          Get.to(() => ChatUserScreen(
                boxChatCustomerInput: boxChatCustomer,
              ));
        },
        child: Column(
          children: [
            Slidable(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          child: CachedNetworkImage(
                            imageUrl:
                                boxChatCustomer.customer?.avatarImage ?? "",
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                SahaLoadingContainer(),
                            errorWidget: (context, url, error) =>
                                SahaEmptyImage(),
                          ),
                          borderRadius: BorderRadius.circular(3000),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              boxChatCustomer.customer?.name ?? "Chưa đặt tên",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: Get.width * 0.7,
                              child: Text(
                                boxChatCustomer.lastMessage?.content ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      right: 10,
                      top: 0,
                      child: Text(
                        SahaStringUtils().displayTimeAgoFromTime(
                            boxChatCustomer.lastMessage?.createdAt ??
                                DateTime.now()),
                        style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
            ),
          ],
        ),
      ),
    );
  }
}
