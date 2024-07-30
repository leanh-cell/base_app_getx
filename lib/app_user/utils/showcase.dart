import 'package:com.ikitech.store/app_user/const/const_showcase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowCase {
  static final ShowCase _singleton = ShowCase._internal();

  bool? isFirstTime;

  factory ShowCase() {
    return _singleton;
  }

  ShowCase._internal();

  Future<void> setStateShowCase(bool? isFirstTime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SHOW_CASE, isFirstTime!);
    this.isFirstTime = isFirstTime;
    print("Check set $isFirstTime");
  }

  Future<bool?> getStateShowCase() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstTimeShowCase = prefs.getBool(SHOW_CASE) ?? true;

    this.isFirstTime = isFirstTimeShowCase;

    return isFirstTimeShowCase;
  }

  bool? getState() {
    return isFirstTime;
  }
}
