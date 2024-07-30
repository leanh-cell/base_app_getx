import 'package:get/get.dart';

class NavigatorController extends GetxController {
  var indexNav = 2.obs;
  int? selectedIndex;
  NavigatorController({this.selectedIndex}) {
    if (selectedIndex != null) {
      indexNav.value = selectedIndex!;
    }
  }
}
