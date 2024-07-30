import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/const/const_database_shared_preferences.dart';
import 'package:com.ikitech.store/app_user/const/function_constant.dart';
import 'package:com.ikitech.store/app_user/load_data/load_firebase.dart';
import 'package:com.ikitech.store/app_user/model/branch.dart';
import 'package:com.ikitech.store/app_user/screen2/home/home_controller.dart';
import 'package:com.ikitech.store/app_user/screen2/login/login_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/navigator/navigator_controller.dart';
import 'package:sahashop_customer/app_customer/utils/customer_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../saha_data_controller.dart';

class UserInfo {
  static final UserInfo _singleton = UserInfo._internal();

  String? _token;
  String? _currentStoreCode;
  String? _nameCurrentBranch;
  String? _listFunctionHome;
  int? _currentIdBranch;
  bool? _isRelease;
  bool? _isPrint = false;
  bool? _isFullOrder = true;
  int? _currentIdUser = 1;

  factory UserInfo() {
    return _singleton;
  }

  UserInfo._internal();

  Future<void> setListFunctionHome(List<String>? listFunction) async {
    var castString = listFunction == null
        ? null
        : listFunction
            .toString()
            .replaceAll("[", "")
            .replaceAll("]", "")
            .replaceAll(" ", "");
    this._listFunctionHome = castString;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (castString == null) {
      await prefs.remove(LIST_FUNCTION);
    } else {
      await prefs.setString(LIST_FUNCTION, castString);
    }
  }

  List<String>? getListFunctionHome() {
    List<String>? listFunction = _listFunctionHome?.split(",");
    return listFunction;
  }

  Future<void> setCurrentNameBranch(String? nameBranch) async {
    this._nameCurrentBranch = nameBranch;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (nameBranch == null) {
      await prefs.remove(NAME_BRANCH);
    } else {
      await prefs.setString(NAME_BRANCH, nameBranch);
    }
  }

  Future<void> setCurrentBranchId(int? idBranch) async {
    this._currentIdBranch = idBranch;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (idBranch == null) {
      await prefs.remove(ID_BRANCH);
    } else {
      await prefs.setInt(ID_BRANCH, idBranch);
    }
  }

  Future<void> setIsFullOrder(bool? isFullOrder) async {
    this._isFullOrder = isFullOrder;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isFullOrder == null) {
      await prefs.remove(IS_FULL_ORDER);
    } else {
      await prefs.setBool(IS_FULL_ORDER, isFullOrder);
    }
  }

  String? getCurrentNameBranch() {
    return _nameCurrentBranch;
  }

  bool? getIsFullOrder() {
    return _isFullOrder;
  }

  int? getCurrentIdBranch() {
    return _currentIdBranch;
  }

  Future<void> setCurrentStoreCode(String? code) async {
    try {
      this._currentStoreCode = code;
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (code == null) {
        await prefs.remove(CURRENT_STORE_CODE);
      } else {
        await prefs.setString(CURRENT_STORE_CODE, code);
      }
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> setCurrentIdUser(int? idUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (idUser == null) {
      await prefs.remove(CURRENT_USER_ID);
    } else {
      await prefs.setInt(CURRENT_USER_ID, idUser);
    }
    this._currentIdUser = idUser;
  }

  Future<void> setRelease(bool? isRelease) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isRelease == null) {
      await prefs.remove(IS_RELEASE);
    } else {
      await prefs.setBool(IS_RELEASE, isRelease);
    }
    this._isRelease = isRelease;
  }

  bool? getIsRelease() {
    return _isRelease;
  }

  Future<bool?> getInitIsRelease() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isRelease = prefs.getBool(IS_RELEASE);
    print(_isRelease);
    return _isRelease;
  }

  Future<void> setPrint(bool? isPrint) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isPrint == null) {
      await prefs.remove(IS_PRINT);
    } else {
      await prefs.setBool(IS_PRINT, isPrint);
    }
    this._isPrint = isPrint;
  }

  bool? getIsPrint() {
    return _isPrint;
  }

  Future<bool?> getInitIsPrint() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isPrint = prefs.getBool(IS_PRINT) ?? false;
    print(_isPrint);
    return _isPrint;
  }

  Future<void> setToken(String? token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (token == null) {
      await prefs.remove(USER_TOKEN);
    } else {
      await prefs.setString(USER_TOKEN, token);
    }
    this._token = token;
  }

  String? getToken() {
    return _token;
  }

  String? getCurrentStoreCode() {
    return _currentStoreCode;
  }

  int? getCurrentIdUser() {
    return _currentIdUser;
  }

  Future<bool> hasLogged() async {
    await loadDataUserSaved();
    if (this._token != null)
      return true;
    else
      return false;
  }

  Future<void> loadDataUserSaved() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tokenLocal = prefs.getString(USER_TOKEN) ?? null;
    this._token = tokenLocal;

    this._currentStoreCode = prefs.getString(CURRENT_STORE_CODE) ?? null;
    this._currentIdBranch = prefs.getInt(ID_BRANCH) ?? null;
    this._nameCurrentBranch = prefs.getString(NAME_BRANCH) ?? null;
    this._isFullOrder = prefs.getBool(IS_FULL_ORDER) ?? null;

    this._listFunctionHome = prefs.getString(LIST_FUNCTION) ??
        [
          PRODUCT_F,
          REVENUE_EXPENDITURE_F,
          STAFF_F,
          CHAT_F,
          AGENCY_F,
          COLLABORATOR_F,
          SALE_F,
        
         //IMPORT_STOCK_F,
          //TALLY_SHEET_F,
         
          
        ]
            .toString()
            .replaceAll("[", "")
            .replaceAll("]", "")
            .replaceAll(" ", "");
  }

  Future<void> logout() async {
    //delete token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(USER_TOKEN);
    prefs.remove(ID_BRANCH);
    prefs.remove(NAME_BRANCH);
    prefs.remove(CURRENT_STORE_CODE);
    this._currentStoreCode = null;
    this._currentIdBranch = null;
    this._nameCurrentBranch = null;
    this._token = null;
    //delete message firebase
    FCMToken().setToken(null);
    FirebaseMessaging.instance.deleteToken();
    //back screen
    SahaDataController sahaDataController = Get.find();
    sahaDataController.branchCurrent.value = Branch();
    CustomerInfo().logout(isNotBackHome: true);
    Get.offAll(() => LoginScreen());
    Get.delete<NavigatorController>();
    Get.delete<HomeController>();
  }
}
