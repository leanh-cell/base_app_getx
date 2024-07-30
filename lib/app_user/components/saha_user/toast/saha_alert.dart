import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart' as FLToast;
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/const/constant.dart';

class SahaAlert {
  static void showError(
      {String? message, Color? color, Color? textColor}) async {
    FLToast.Fluttertoast.showToast(
      msg: message!,
      toastLength: FLToast.Toast.LENGTH_SHORT,
      gravity: FLToast.ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: color ?? Colors.red,
      textColor: textColor ?? Colors.white,
      fontSize: 16.0,
    );
  }

  static void showWarning({
    String message = "",
    String title = "Saha",
  }) {
    FLToast.Fluttertoast.showToast(msg: message);
    // showFlash(
    //   duration: Duration(milliseconds: 2000),
    //   context: Get.context!,
    //   builder: (_, controller) {
    //     return Flash(
    //       controller: controller,
    //       position: FlashPosition.bottom,
    //       borderRadius: BorderRadius.circular(8.0),
    //       borderColor: Colors.amber,
    //       boxShadows: kElevationToShadow[8],
    //       backgroundGradient: RadialGradient(
    //         colors: [Colors.black87, Colors.black87],
    //         center: Alignment.topLeft,
    //         radius: 2,
    //       ),
    //       onTap: () => controller.dismiss(),
    //       forwardAnimationCurve: Curves.easeInCirc,
    //       reverseAnimationCurve: Curves.bounceIn,
    //       child: DefaultTextStyle(
    //         style: TextStyle(color: Colors.white),
    //         child: FlashBar(
    //           title: Text('$title'),
    //           content: Text('$message'),
    //           indicatorColor: Colors.yellow,
    //           icon: Icon(Icons.info_outline),
    //           primaryAction: TextButton(
    //             onPressed: () => controller.dismiss(),
    //             child: Text('Đóng'),
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    // );
  }

  static void showSuccess({
    String message = "",
    String title = "Saha",
  }) {
    FLToast.Fluttertoast.showToast(
      msg: message,
      toastLength: FLToast.Toast.LENGTH_SHORT,
      gravity: FLToast.ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    // showFlash(
    //   duration: Duration(milliseconds: 1000),
    //   context: Get.context!,
    //   builder: (_, controller) {
    //     return Flash(
    //       controller: controller,
    //       position: FlashPosition.bottom,
    //       borderRadius: BorderRadius.circular(8.0),
    //       borderColor: Colors.blue,
    //       boxShadows: kElevationToShadow[8],
    //       backgroundGradient: RadialGradient(
    //         colors: [Colors.black87, Colors.black87],
    //         center: Alignment.topLeft,
    //         radius: 2,
    //       ),
    //       onTap: () => controller.dismiss(),
    //       forwardAnimationCurve: Curves.easeInCirc,
    //       reverseAnimationCurve: Curves.bounceIn,
    //       child: DefaultTextStyle(
    //         style: TextStyle(color: Colors.white),
    //         child: FlashBar(
    //           title: Text('$title'),
    //           content: Text('$message'),
    //           indicatorColor: Colors.green,
    //           icon: Icon(Icons.check),
    //         ),
    //       ),
    //     );
    //   },
    // );
  }

  // static void showBasicsFlash(
  //   String message, {
  //   Duration? duration,
  // }) {
  //   showFlash(
  //     context: Get.context!,
  //     duration: duration,
  //     builder: (context, controller) {
  //       return Flash(
  //         controller: controller,
  //         boxShadows: kElevationToShadow[4],
  //         position: FlashPosition.bottom,
  //         horizontalDismissDirection: HorizontalDismissDirection.horizontal,
  //         child: FlashBar(
  //           content: Text('$message'),
  //         ),
  //       );
  //     },
  //   );
  // }

  

  static void showToastMiddle(
      {String? message, Color? color, Color? textColor}) {
    FLToast.Fluttertoast.showToast(
        msg: message!,
        toastLength: FLToast.Toast.LENGTH_SHORT,
        gravity: FLToast.ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: color ?? Colors.red,
        textColor: textColor ?? Colors.white,
        fontSize: 16.0);
  }
}
