import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_avatar.dart';

import '../../../../../../components/saha_user/loading/loading_widget.dart';
import '../../../../../../model/guess_number_game.dart';
import 'customer_win_screen.dart';

class AwardAnounceScreen extends StatelessWidget {
  AwardAnounceScreen({Key? key, required this.guessNumberGame})
      : super(key: key);
  GuessNumberGame guessNumberGame;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin người trúng thưởng'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ClipOval(
              child: CachedNetworkImage(
                height: 150,
                width: 150,
                fit: BoxFit.cover,
                imageUrl:
                    guessNumberGame.finalResultAnnounced?.customerWin != null &&
                            guessNumberGame
                                .finalResultAnnounced!.customerWin!.isNotEmpty
                        ? (guessNumberGame.finalResultAnnounced?.customerWin?[0]
                                .avatarImage ??
                            '')
                        : '',
                placeholder: (context, url) => SahaLoadingWidget(),
                errorWidget: (context, url, error) => SahaEmptyAvata(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text('Tên người trúng giải:'),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text(guessNumberGame.finalResultAnnounced?.customerWin !=
                                  null &&
                              guessNumberGame
                                  .finalResultAnnounced!.customerWin!.isNotEmpty
                          ? (guessNumberGame
                                  .finalResultAnnounced?.customerWin?[0].name ??
                              'Chưa có thông tin')
                          : ''),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(),
            Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text('Số điện thoại:'),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text(guessNumberGame.finalResultAnnounced?.customerWin !=
                                  null &&
                              guessNumberGame
                                  .finalResultAnnounced!.customerWin!.isNotEmpty
                          ? (guessNumberGame.finalResultAnnounced
                                  ?.customerWin?[0].phoneNumber ??
                              'Chưa có thông tin')
                          : ""),
                    ],
                  ),
                ),
              ],
            ),
            // const Divider(),
            // Column(
            //   children: [
            //     Container(
            //       color: Colors.white,
            //       padding: const EdgeInsets.all(10.0),
            //       child: Row(
            //         children: [
            //           Text('Email:'),
            //         ],
            //       ),
            //     ),
            //     Container(
            //       color: Colors.white,
            //       padding: const EdgeInsets.all(10.0),
            //       child: Row(
            //         children: [
            //           Text(guessNumberGame
            //                   .finalResultAnnounced?.customerWin?.email ??
            //               'Chưa có thông tin'),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),

            // Column(
            //   children: [
            //     Container(
            //       color: Colors.white,
            //       padding: const EdgeInsets.all(10.0),
            //       child: Row(
            //         children: [
            //           Text('Địa chỉ:'),
            //         ],
            //       ),
            //     ),
            //     Container(
            //       color: Colors.white,
            //       padding: const EdgeInsets.all(10.0),
            //       child: Row(
            //         children: [
            //           Expanded(
            //             child: Text(guessNumberGame.finalResultAnnounced
            //                             ?.customerWin?.addressDetail !=
            //                         null &&
            //                     guessNumberGame.finalResultAnnounced
            //                             ?.customerWin?.wardsName !=
            //                         null &&
            //                     guessNumberGame.finalResultAnnounced
            //                             ?.customerWin?.districtName !=
            //                         null &&
            //                     guessNumberGame.finalResultAnnounced
            //                             ?.customerWin?.provinceName !=
            //                         null
            //                 ? '${guessNumberGame.finalResultAnnounced?.customerWin?.addressDetail ?? ''} - ${guessNumberGame.finalResultAnnounced?.customerWin?.wardsName ?? ''} - ${guessNumberGame.finalResultAnnounced?.customerWin?.districtName ?? ''} - ${guessNumberGame.finalResultAnnounced?.customerWin?.provinceName ?? ''}'
            //                 : 'Chưa có thông tin'),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            const Divider(),
            Card(
              child: ListTile(
                onTap: () {
                  Get.to(() => CustomersWinScreen(
                        listCusWin:
                            guessNumberGame.finalResultAnnounced?.customerWin ??
                                [],
                      ));
                },
                title: Text('Danh sách người chơi cùng đáp án'),
                trailing: const Icon(Icons.keyboard_arrow_right),
              ),
            )
          ],
        ),
      ),
    );
  }
}
