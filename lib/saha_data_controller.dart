import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/sale/over_view_sale_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';

import 'app_user/components/saha_user/toast/saha_alert.dart';
import 'app_user/data/repository/repository_manager.dart';
import 'app_user/data/socket/socket.dart';
import 'app_user/model/badge_user.dart';
import 'app_user/model/branch.dart';
import 'app_user/model/staff.dart';
import 'app_user/screen2/branch/new_address_store_screen/new_branch_screen.dart';
import 'app_user/utils/thread_data.dart';
import 'app_user/utils/user_info.dart';

class SahaDataController extends GetxController {
  var isPreview = false.obs;
  var unread = 0.obs;
  var isRefresh = true.obs;
  ScrollController scrollController = new ScrollController();
  var badgeUser = BadgeUser().obs;
  var user = Staff().obs;
  var listBranch = RxList<Branch>();
  var branchCurrent = Branch().obs;
  var overViewSale = OverViewSale().obs;
  ////bluetooth
  BluetoothDevice? device;
  var isConnected = false.obs;
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  // SahaDataController(){
  //   initStreamBluetooth();
  // }
  @override
  void onInit() {
    SocketUser().connect();
    getDataBoxChatUser();
    UserInfo().getInitIsPrint();
    initPackageInfo();
    
    super.onInit();
  }

  var packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  ).obs;

  Future<void> initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    packageInfo.value = info;
  }

  Future<void> getOverViewSale() async {
    try {
      var data = await RepositoryManager.saleRepo.getOverViewSale();
      overViewSale(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void changeStatusPreview(bool status) {
    isPreview.value = status;
    if (status == true) {
      FlowData().setIsOnline(true);
    } else {
      FlowData().setIsOnline(false);
    }
  }

  Future<bool?> getAllBranch({Function? callbackAddBranch}) async {
    try {
      var data = await RepositoryManager.branchRepository.getAllBranch();
      listBranch(data!.data!);
      if (listBranch.isNotEmpty) {
        if (UserInfo().getCurrentNameBranch() == null) {
          if (data.data != null && data.data!.isNotEmpty) {
            UserInfo().setCurrentNameBranch(data.data![0].name);
            UserInfo().setCurrentBranchId(data.data![0].id);
            branchCurrent.value = data.data![0];
          }
        } else {
          branchCurrent.value = Branch(
              name: UserInfo().getCurrentNameBranch(),
              id: UserInfo().getCurrentIdBranch());
        }
        return true;
      } else {
        Get.offAll(() => NewStoreStoreScreen(
              callBack: (value) {
                if (value == "success") {
                  if (callbackAddBranch != null) {
                    //    callbackAddBranch();
                  }
                }
              },
            ));
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getUser() async {
    try {
      var data = await RepositoryManager.profileRepository.getProfile();
      user.value = data!.staff!;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getBadge() async {
    try {
      var data = await RepositoryManager.badgeRepository.getBadgeUser();
      badgeUser.value = data!.data!;
      if (badgeUser.value.isSale == true) {
        getOverViewSale();
      }
      FlutterAppBadger.updateBadgeCount(
          badgeUser.value.notificationUnread ?? 0);
    } catch (err) {}
  }

  void getDataBoxChatUser() {
    SocketUser().listenCustomer((data) {
      print("-------------${data.toString()}");

      unread.value = Unread.fromJson(data).uread!;
      print("-------------$unread");
    });
  }

  Future<void> connectBluetooth() async {
    if (device == null) return;
    await bluetoothPrint.connect(device!);
  }

  void initStreamBluetooth() {
   
   
     print("init stream");
  }
}

class Unread {
  Unread({
    this.uread,
  });

  int? uread;

  factory Unread.fromJson(Map<String, dynamic> json) => Unread(
        uread: int.parse(json["uread"]),
      );

  Map<String, dynamic> toJson() => {
        "uread": uread,
      };
}
