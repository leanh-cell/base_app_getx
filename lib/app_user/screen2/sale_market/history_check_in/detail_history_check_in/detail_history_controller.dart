import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/history_check_in.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailHistoryController extends GetxController {
  var loadInit = false.obs;
  var history = HistoryCheckIn().obs;
  final int historyId;
  var note = TextEditingController();
  DetailHistoryController({required this.historyId}) {
    getHistory();
  }
  Future<void> getHistory() async {
    loadInit.value = true;
    try {
      var res = await RepositoryManager.agencyRepository
          .getHistoryCheckIn(historyId: historyId);
      history.value = res!.data!;
      note.text = history.value.note ?? '';
      loadInit.value = false;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}
