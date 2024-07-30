import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:com.ikitech.store/app_user/model/staff.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:com.ikitech.store/app_user/model/branch.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sahashop_customer/app_customer/remote/customer_service_manager.dart';
import 'package:sahashop_customer/app_customer/screen_default/navigation_scrren/navigation_screen.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'app_user/const/constant.dart';
import 'app_user/data/remote/saha_service_manager.dart';
import 'app_user/load_data/load_firebase.dart';
import 'app_user/load_data/load_login.dart';
import 'app_user/model/filter_order.dart';
import 'app_user/model/printer.dart';
import 'app_user/model/theme_model.dart';
import 'app_user/screen2/config_app/config_screen.dart';
import 'app_user/screen2/home/pay/pay_screen.dart';
import 'app_user/screen2/navigator/navigator_screen.dart';
import 'app_user/utils/user_info.dart';
import 'saha_data_controller.dart';
import 'saha_load_app.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.data.toString()}");

  FlutterAppBadger.updateBadgeCount(int.tryParse(message.data['badge']) ?? 0);
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();
  await UserInfo().getInitIsRelease();
  await StoreInfo().setRelease(UserInfo().getIsRelease());
  final directory = await getApplicationDocumentsDirectory();
  Hive
    ..init(directory.path)
    ..registerAdapter(PrinterAdapter());
  Hive
    ..init(directory.path)
    ..registerAdapter(FilterOrderAdapter());
  Hive
    ..init(directory.path)
    ..registerAdapter(BranchAdapter());
  Hive
    ..init(directory.path)
    ..registerAdapter(StaffAdapter());
  LoadFirebase.initFirebase();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  SahaServiceManager.initialize();
  CustomerServiceManager.initialize();
  LoadLogin.load();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://ceab00b097794e81950978babccf9b28@o4504693241806848.ingest.sentry.io/4504693247115264';
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(MyApp()),
  );
}

class MyApp extends StatelessWidget {
  final SahaDataController sahaDataController = Get.put(SahaDataController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IKIPOS',
      theme: SahaUserPrimaryTheme(context),
      themeMode: ThemeMode.light,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routingCallback: (routing) {
        if (routing!.current == 'ConfigScreen') {
          sahaDataController.changeStatusPreview(false);
          print("=====================");
        }
        if (routing.current == 'home_screen') {
          // if (Get.isRegistered<HomeController>()) {
          //   HomeController homeController = Get.find();
          //   homeController.refresh();
          // }
        }
      },
      home: SahaMainScreen(),
      getPages: [
        GetPage(name: "/home_screen", page: () => NavigatorScreen()),
        GetPage(name: "/pay_screen", page: () => PayScreen()),
        GetPage(name: "/ConfigScreen", page: () => ConfigAppScreen()),
        GetPage(name: "/customer_home", page: () => NavigationScreen()),
      ],
      builder: EasyLoading.init(
        builder: (context, widget) => Column(
          children: [
            Expanded(child: widget!),
            Obx(
              () => !sahaDataController.isPreview.value
                  ? Container()
                  : Material(
                      child: InkWell(
                        onTap: () {
                          Get.until(
                            (route) => route.settings.name == "ConfigScreen",
                          );
                          sahaDataController.changeStatusPreview(false);
                        },
                        child: Container(
                          height: 35,
                          width: Get.width,
                          color: SahaPrimaryColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Expanded(
                                child: Center(
                                    child: AutoSizeText(
                                  "Bạn đang xem thử App, nhấp vào đây để trở về",
                                  maxFontSize: 13,
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.white),
                                  maxLines: 2,
                                )),
                              ),
                              Icon(
                                Icons.west,
                                size: 15,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
      supportedLocales: [
        Locale('vi', 'VN'),
      ],
    );
  }
}
