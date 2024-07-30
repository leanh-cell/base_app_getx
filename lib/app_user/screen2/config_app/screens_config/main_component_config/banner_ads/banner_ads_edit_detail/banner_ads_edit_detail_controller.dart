import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/image_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/banner_ads.dart';

class BannerAdsEditDetailController extends GetxController {
  TextEditingController textEditingController = TextEditingController();

  var listImages = RxList<ImageDataFile>([]);

  var bannerAds = BannerAds().obs;

  BannerAds? bannerAdsInput;

  BannerAdsEditDetailController({this.bannerAdsInput}) {
    if (bannerAdsInput != null) {
      bannerAds.value = bannerAdsInput!;
      listImages([
        ImageDataFile(
            linkImage: bannerAdsInput?.imageUrl ?? "",
            uploading: false,
            errorUpload: false)
      ]);
      textEditingController.text =
          (bannerAdsInput!.value ?? '').replaceAll("https://", "");
    }
  }

  Future<void> addBannerAds() async {
    if (bannerAds.value.value == null ||
        bannerAds.value.typeAction == null ||
        bannerAds.value.imageUrl == null ||
        bannerAds.value.position == null) {
      SahaAlert.showError(message: 'Vui lòng chọn đầy đủ thông tin');
      return;
    }
    try {
      var data =
          RepositoryManager.configUiRepository.createBannerAds(bannerAds.value);
      SahaAlert.showSuccess(message: 'Thêm banner quảng cáo thành công');
      Get.back(result: 'reload');
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateBannerAds() async {
    if (bannerAds.value.value == null ||
        bannerAds.value.typeAction == null ||
        bannerAds.value.imageUrl == null ||
        bannerAds.value.position == null) {
      SahaAlert.showError(message: 'Vui lòng chọn đầy đủ thông tin');
      return;
    }

    try {
      var data = RepositoryManager.configUiRepository
          .updateBannerAds(bannerAdsInput!.id!, bannerAds.value);
      SahaAlert.showSuccess(message: 'Cập nhập thành công');
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
