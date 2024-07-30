import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'guest_number_game/guest_number_game_screen.dart';
import 'mini_game_spin_wheel/mini_game_setting_screen.dart';

class MiniGameScreen extends StatelessWidget {
  const MiniGameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mini Game')),
      body: Column(
        children: [
          itemGame(
              title: 'Game vòng quay',
              onTap: () {
                Get.to(() => MiniGameSettingScreen());
              }),
          itemGame(
              title: 'Game đoán số',
              onTap: () {
                Get.to(() => GuestNumberGameScreen());
              })
        ],
      ),
    );
  }

  Widget itemGame({required String title, required Function onTap}) {
    return Card(
      child: ListTile(
        onTap: () {
          onTap();
        },
        title: Text(title),
        trailing: Icon(Icons.keyboard_arrow_right_outlined),
      ),
    );
  }
}
