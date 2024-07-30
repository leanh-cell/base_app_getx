import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/banner_ads.dart';

class BannerAdsController extends GetxController {
  int? positionInput;
  var listBanner = RxList<BannerAds>();
  var loading  = false.obs;

  BannerAdsController({this.positionInput}) {
    loading.value = true;
    getAllBannerAds();
  }

  Future<void> getAllBannerAds() async {
    try {
      var data = await RepositoryManager.configUiRepository.getAllBannerAds();
      if (positionInput != null) {
        listBanner(
            data!.data!.where((e) => e.position == positionInput).toList());
      } else {
        listBanner(data!.data!);
      }

    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading.value = false;
  }

  Future<void> deleteBannerAds(int bannerAdsId) async {
    try {
      var data = await RepositoryManager.configUiRepository
          .deleteBannerAds(bannerAdsId);
      getAllBannerAds();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
