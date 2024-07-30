import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/model/info_address_customer.dart';
import '../../../../data/repository/repository_manager.dart';

class ReceiverAddressCustomerController extends GetxController {
  var listInfoAddressCustomer = RxList<InfoAddressCustomer>();
  var isLoadingAddress = false.obs;
  String phone;

  ReceiverAddressCustomerController({required this.phone}) {
    getAllAddressCustomer();
  }

  Future<void> getAllAddressCustomer() async {
    isLoadingAddress.value = true;
    try {
      var res = await RepositoryManager.addressRepository
          .getAllAddressCustomer(phone);
      listInfoAddressCustomer(res!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingAddress.value = false;
  }
}
