import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';

import '../../../data/remote/response-request/address/shipment_calculate_req.dart';
import '../../../data/remote/response-request/address/shipment_calculate_res.dart';
import '../../../model/info_address.dart';
import '../../../model/location_address.dart';
import '../../../model/shipment.dart';
import '../../home/confirm_screen/confirm_controller.dart';
import '../../home/home_controller.dart';

class ShipmentSuggestionController extends GetxController {
  ConfirmUserController confirmController  = Get.find();
  var req = ShipmentCalculateReq().obs;

  var locationProvince = LocationAddress().obs;
  var locationDistrict = LocationAddress().obs;
  var locationWard = LocationAddress().obs;

  var listShipmentCalculate = RxList<ShipmentCalculate>();
  var listShipment = RxList<Shipment>();
  var isLoadingAddress = false.obs;
  var isLoadingCal = false.obs;
  var addressStore = InfoAddress().obs;
  HomeController homeController = Get.find();

  ShipmentSuggestionController() {
    req.value.length = 10;
    req.value.width = 10;
    req.value.height = 10;
    req.value.weight = 100;
    req.value.moneyCollection = confirmController.cod ?? 0;
    req.value.receiverAddress = homeController.cartCurrent.value.addressDetail;
    locationWard.value.id = homeController.cartCurrent.value.wards;
    locationDistrict.value.id = homeController.cartCurrent.value.district;
    locationProvince.value.id = homeController.cartCurrent.value.province;
    locationProvince.value.name = homeController.cartCurrent.value.provinceName;
    locationDistrict.value.name = homeController.cartCurrent.value.districtName;
    locationWard.value.name = homeController.cartCurrent.value.wardsName;
    
    getAllAddressStore().then((value) => {
          getAllShipmentStore().then((value) => {
                if (req.value.senderAddress != null) {getData()}
              })
        });
  }

  Future<void> getAllAddressStore() async {
    isLoadingAddress.value = true;
    try {
      var res = await RepositoryManager.addressRepository.getAllAddressStore();
      res!.data!.forEach((element) {
        if (element.isDefaultPickup == true) {
          addressStore.value = element;
        }
      });
      req.value.senderAddress = addressStore.value.addressDetail;
      req.value.senderWardsId = addressStore.value.wards;
      req.value.senderDistrictId = addressStore.value.district;
      req.value.senderProvinceId = addressStore.value.province;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingAddress.value = false;
  }

  Future<void> getAllShipmentStore() async {
    listShipment([]);
    try {
      var data =
          await RepositoryManager.addressRepository.getAllShipmentStore();
      data!.data!.forEach((e) {
        if (e.shipperConfig?.use == true) {
          listShipment.add(e);
        }
      });
      if (listShipment.isEmpty) {
        SahaAlert.showToastMiddle(message: "Chưa thiết lập đơn vị vận chuyển");
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> calculateShipment(int idShipment) async {
    req.value.receiverDistrictId = locationDistrict.value.id;
    req.value.receiverProvinceId = locationProvince.value.id;
    req.value.receiverWardsId = locationWard.value.id;

    try {
      var data = await RepositoryManager.addressRepository
          .calculateShipment(req.value, idShipment);
      listShipmentCalculate.addAll(data!.data!);
      isLoadingCal.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingCal.value = false;
  }

  void getData() async {
    isLoadingCal.value = true;
    listShipmentCalculate([]);
    await Future.wait(listShipment.map((e) => calculateShipment(e.id!)));
    isLoadingCal.value = false;
  }
}
