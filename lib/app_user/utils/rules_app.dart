import 'package:shared_preferences/shared_preferences.dart';

class RulesApp {
  static final RulesApp _singleton = RulesApp._internal();

  bool? isAgree;

  factory RulesApp() {
    return _singleton;
  }

  RulesApp._internal();

  Future<void> setAgreedRules(bool? isAgree) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("RULES_APP", isAgree!);
  }

  Future<bool> getAgreedRules() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = prefs.getBool("RULES_APP") ?? false;
    this.isAgree = result;
    return result;
  }

  bool? getAgreed() {
    return this.isAgree;
  }
}
