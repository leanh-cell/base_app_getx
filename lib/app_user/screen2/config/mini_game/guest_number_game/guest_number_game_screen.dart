import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/screen2/config/mini_game/guest_number_game/guest_number_game_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../components/saha_user/empty/saha_empty_image.dart';
import '../../../../components/saha_user/loading/loading_full_screen.dart';
import '../../../../components/saha_user/loading/loading_widget.dart';
import '../../../../model/guess_number_game.dart';
import 'add_guess_number_game/add_guess_number_game_screen.dart';

class GuestNumberGameScreen extends StatefulWidget {
  const GuestNumberGameScreen({Key? key}) : super(key: key);

  @override
  State<GuestNumberGameScreen> createState() => _GuestNumberGameScreenState();
}

class _GuestNumberGameScreenState extends State<GuestNumberGameScreen>
    with SingleTickerProviderStateMixin {
  final RefreshController refreshController = RefreshController();
  late TabController _tabController;
  GuestNumberGameController guestNumberGameController =
      GuestNumberGameController();
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Danh sách game đoán số')),
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
                  guestNumberGameController.status.value = v == 0
                      ? 0
                      : v == 1
                          ? 2
                          : 1;
                  guestNumberGameController.getAllGuessNumberGame(
                      isRefresh: true);
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
                          style: TextStyle(color: Colors.black54, fontSize: 12),
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
              () => guestNumberGameController.loadInit.value
                  ? SahaLoadingFullScreen()
                  : guestNumberGameController.listGuessGame.isEmpty
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
                                    guestNumberGameController.isLoading.value
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
                            await guestNumberGameController
                                .getAllGuessNumberGame(isRefresh: true);
                            refreshController.refreshCompleted();
                          },
                          onLoading: () async {
                            await guestNumberGameController
                                .getAllGuessNumberGame();
                            refreshController.loadComplete();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: guestNumberGameController
                                    .listGuessGame
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
          Get.to(() => AddGuessNumberGameScreen())!.then((value) =>
              guestNumberGameController.getAllGuessNumberGame(isRefresh: true));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget itemMiniGame(GuessNumberGame guessNumberGame) {
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
      child: ListTile(
        onTap: () {
          Get.to(() => AddGuessNumberGameScreen(
                    guessGameId: guessNumberGame.id,
                  ))!
              .then((value) => guestNumberGameController.getAllGuessNumberGame(
                  isRefresh: true));
        },
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(guessNumberGame.name ?? ''),
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
                imageUrl: guessNumberGame.images!.isEmpty
                    ? ""
                    : guessNumberGame.images![0],
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
                    Text(guessNumberGame.applyFor == 0
                        ? 'Tất cả'
                        : guessNumberGame.applyFor == 1
                            ? 'Cộng tác viên'
                            : guessNumberGame.applyFor == 2
                                ? 'Đại lý'
                                : "Nhóm khách hàng"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    'Bắt đầu :${DateFormat('HH:mm').format(guessNumberGame.timeStart ?? DateTime.now())} ${DateFormat('dd-MM-yyyy').format(guessNumberGame.timeStart ?? DateTime.now())}'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    'Kết thúc :${DateFormat('HH:mm').format(guessNumberGame.timeEnd ?? DateTime.now())} ${DateFormat('dd-MM-yyyy').format(guessNumberGame.timeEnd ?? DateTime.now())}')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
