import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/const/type_address.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/location_address.dart';

class ChooseAddressController extends GetxController {
  final TypeAddress? typeAddress;
  final idProvince;
  final idDistrict;

  ChooseAddressController(this.typeAddress, this.idProvince, this.idDistrict) {
    checkTypeAddress();
  }

  var nameTitleAppbar = "".obs;
  var listLocationAddress = RxList<LocationAddress>().obs;
  var isLoadingAddress = false.obs;

  void checkTypeAddress() {
    if (typeAddress == TypeAddress.Province) {
      nameTitleAppbar.value = "Tỉnh/Thành phố";
      getProvince();
    } else {
      if (typeAddress == TypeAddress.District) {
        nameTitleAppbar.value = "Quận/Huyện";
        getDistrict(idProvince);
      } else {
        nameTitleAppbar.value = "Phường/Xã";
        getWard(idDistrict);
      }
    }
  }

  Future<void> getProvince() async {
    isLoadingAddress.value = true;
    try {
      var res = await RepositoryManager.addressRepository.getProvince();

      res!.data!.forEach((element) {
        listLocationAddress.value.add(element);
      });
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }

    isLoadingAddress.value = false;
  }

  Future<void> getDistrict(int? idProvince) async {
    isLoadingAddress.value = true;
    try {
      var res =
          await RepositoryManager.addressRepository.getDistrict(idProvince);

      res!.data!.forEach((element) {
        listLocationAddress.value.add(element);
      });
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }

    isLoadingAddress.value = false;
  }

  Future<void> getWard(int? idDistrict) async {
    isLoadingAddress.value = true;
    try {
      var res = await RepositoryManager.addressRepository.getWard(idDistrict);

      res!.data!.forEach((element) {
        listLocationAddress.value.add(element);
      });
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingAddress.value = false;
  }
}
