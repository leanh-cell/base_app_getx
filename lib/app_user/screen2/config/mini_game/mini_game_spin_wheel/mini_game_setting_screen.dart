import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/model/mini_game.dart';
import 'package:com.ikitech.store/app_user/screen2/config/mini_game/mini_game_spin_wheel/mini_game_setting_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../components/saha_user/empty/saha_empty_image.dart';
import '../../../../components/saha_user/loading/loading_widget.dart';
import 'add_mini_game/add_mini_game_screen.dart';

class MiniGameSettingScreen extends StatefulWidget {
  const MiniGameSettingScreen({Key? key}) : super(key: key);

  @override
  State<MiniGameSettingScreen> createState() => _MiniGameSettingScreenState();
}

class _MiniGameSettingScreenState extends State<MiniGameSettingScreen>
    with SingleTickerProviderStateMixin {
  MiniGameSettingController miniGameSettingController =
      MiniGameSettingController();
  final RefreshController refreshController = RefreshController();
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Danh sách game vòng quay')),
        body: Column(
          children: [
            SizedBox(
              height: 45,
              width: Get.width,
              child: ColoredBox(
                color: Colors.white,
                child: TabBar(
                  controller: _tabController,
                  onTap: (v) {
                    miniGameSettingController.status.value = v == 0
                        ? 0
                        : v == 1
                            ? 2
                            : 1;
                    miniGameSettingController.getAllMiniGame(isRefresh: true);
                  },
                  tabs: [
                    Tab(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Sắp diễn ra',
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
                            'Đang diễn ra',
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
                            style:
                                TextStyle(color: Colors.black54, fontSize: 12),
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
            Expanded(
              child: Obx(
                () => miniGameSettingController.loadInit.value
                    ? SahaLoadingFullScreen()
                    : miniGameSettingController.listMiniGame.isEmpty
                        ? const Center(
                            child: Text('Không có trò chơi nào'),
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
                                      miniGameSettingController.isLoading.value
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
                              await miniGameSettingController.getAllMiniGame(
                                  isRefresh: true);
                              refreshController.refreshCompleted();
                            },
                            onLoading: () async {
                              await miniGameSettingController.getAllMiniGame();
                              refreshController.loadComplete();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: miniGameSettingController
                                      .listMiniGame
                                      .map((e) => itemMiniGame(e))
                                      .toList(),
                                ),
                              ),
                            ),
                          ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => AddMiniGameScreen())!.then((value) =>
                miniGameSettingController.getAllMiniGame(isRefresh: true));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget itemMiniGame(MiniGame miniGame) {
    double totalPercent = miniGame.listGift!
        .map((e) => e.percentReceived)
        .toList()
        .fold(0, (p, e) => p + e!);
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
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
      child: Column(
        children: [
          ListTile(
            onTap: () {
              Get.to(() => AddMiniGameScreen(
                        id: miniGame.id,
                      ))!
                  .then((value) => miniGameSettingController.getAllMiniGame(
                      isRefresh: true));
            },
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(miniGame.name ?? ''),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
            subtitle: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                    imageUrl:
                        miniGame.images!.isEmpty ? "" : miniGame.images![0],
                    placeholder: (context, url) => SahaLoadingWidget(),
                    errorWidget: (context, url, error) => SahaEmptyImage(),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Dành cho :'),
                        Text(miniGame.applyFor == 0
                            ? 'Tất cả'
                            : miniGame.applyFor == 1
                                ? 'Cộng tác viên'
                                : miniGame.applyFor == 2
                                    ? 'Đại lý'
                                    : "Nhóm khách hàng"),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        'Bắt đầu :${DateFormat('HH:mm').format(miniGame.timeStart ?? DateTime.now())} ${DateFormat('dd-MM-yyyy').format(miniGame.timeStart ?? DateTime.now())}'),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        'Kết thúc :${DateFormat('HH:mm').format(miniGame.timeEnd ?? DateTime.now())} ${DateFormat('dd-MM-yyyy').format(miniGame.timeEnd ?? DateTime.now())}')
                  ],
                ),
              ],
            ),
          ),
          if ((miniGame.listGift ?? []).isEmpty)
            Text(
              'Trò chơi này chưa có phần thưởng, vui lòng tạo lại',
              style: TextStyle(color: Colors.red),
            )
          else if (miniGame.listGift!.length < 2)
            Text(
              'Trò chơi cần phải có ít nhất 2 món quà để quay thưởng',
              style: TextStyle(color: Colors.red),
            )
        ],
      ),
    );
  }
}
