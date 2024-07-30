import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/model/gift.dart';
import 'package:com.ikitech.store/app_user/screen2/config/mini_game/mini_game_spin_wheel/gift/add_gift/add_gift_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/config/mini_game/mini_game_spin_wheel/gift/gift_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../../components/saha_user/empty/saha_empty_image.dart';
import '../../../../../components/saha_user/loading/loading_full_screen.dart';
import '../../../../../components/saha_user/loading/loading_widget.dart';
import '../add_mini_game/add_mini_game_controller.dart';
import '../mini_game_setting_controller.dart';
import 'add_gift/add_gift_controller.dart';

class GiftScreen extends StatelessWidget {
  GiftScreen({Key? key, required this.id}) {
    giftController = GiftController(id: id);
  }

  final int id;
  late final GiftController giftController;
  final RefreshController refreshController = RefreshController();
  AddMiniGameController addMiniGameController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách phần thưởng'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
            addMiniGameController.getMiniGame(id: id);
          },
        ),
      ),
      body: Obx(
        () => giftController.loadInit.value
            ? SahaLoadingFullScreen()
            : giftController.listGift.isEmpty
                ? const Center(
                    child: Text('Không có phần thưởng nào'),
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
                          body = Obx(() => giftController.isLoading.value
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
                      await giftController.getAllGift(isRefresh: true);
                      refreshController.refreshCompleted();
                    },
                    onLoading: () async {
                      await giftController.getAllGift();
                      refreshController.loadComplete();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: giftController.listGift
                              .map((e) => itemGift(e))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddGiftScreen(spinId: id))!.then((value) {
            giftController.getAllGift(isRefresh: true);
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget itemGift(Gift gift) {
    return InkWell(
      onTap: () {
        Get.to(() => AddGiftScreen(
                  spinId: id,
                  id: gift.id,
                ))!
            .then((value) {
          giftController.getAllGift(isRefresh: true);
        });
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: CachedNetworkImage(
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  imageUrl: gift.imageUrl ?? '',
                  placeholder: (context, url) => SahaLoadingWidget(),
                  errorWidget: (context, url, error) => SahaEmptyImage(),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(gift.name ?? 'Chưa có tên'),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Số lượng quà : ${gift.amountGift.toString()}'),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      'Phần trăm trúng thưởng: ${gift.percentReceived.toString()}%')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
