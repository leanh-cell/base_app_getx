import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/cart_info.dart';
import 'package:com.ikitech.store/app_user/screen2/home/home_controller.dart';

class ListCartController extends GetxController {
  ListCartController() {
    getAllCart();
  }
  HomeController homeController = Get.find();

  var listCart = RxList<CartInfo>();

  Future<void> getAllCart() async {
    try {
      var data = await RepositoryManager.cartRepository
          .getAllCart(hasCartDefault: false);
      listCart(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteCart(int idCart) async {
    try {
      var data = await RepositoryManager.cartRepository.deleteCart(idCart);

      if (idCart == homeController.cartCurrent.value.id) {
        homeController.cartCurrent.value.id = 0;
        homeController.getCart();
      }

      getAllCart();
      SahaAlert.showSuccess(message: "Đã xoá");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

    Future<void> changeNameCart({required int idCart,required String name}) async {
    try {
      var data = await RepositoryManager.cartRepository.changeNameCart(cartId: idCart,name: name);

    

      getAllCart();
      SahaAlert.showSuccess(message: "Thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
