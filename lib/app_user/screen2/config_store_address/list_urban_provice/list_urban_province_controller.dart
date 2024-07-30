import 'package:get/get.dart';

import '../../../components/saha_user/toast/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';
import '../../../model/location_address.dart';

class ListUrbanProvinceController extends GetxController {
  var isLoadingAddress = false.obs;
  var listLocationAddress = RxList<LocationAddress>();
  var listLocationAddressChoose = RxList<LocationAddress>();

  List<LocationAddress> listInput;

  ListUrbanProvinceController({required this.listInput}) {
    listLocationAddressChoose(listInput);
    getProvince();
  }

  Future<void> getProvince() async {
    isLoadingAddress.value = true;
    try {
      var res = await RepositoryManager.addressRepository.getProvince();

      res!.data!.forEach((element) {
        listLocationAddress.add(element);
      });
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }

    isLoadingAddress.value = false;
  }
}
