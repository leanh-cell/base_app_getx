import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/model/popup_config.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import '../../../../saha_data_controller.dart';
import 'popup_controller.dart';
import 'popup_detail/popup_config.dart';

class PopupConfig extends StatelessWidget {
  PopupController popupController = PopupController();
  SahaDataController sahaDataController = Get.find();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Quảng cáo"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 20,
          ),
          Obx(
            () => popupController.listPopupCf.isEmpty
                ? InkWell(
                    onTap: () {
                      Get.to(() => PopupConfigDetail())!.then((value) {
                        popupController.getListPopup();
                      });
                    },
                    child: Container(
                      height: Get.height / 3.5,
                      width: Get.width,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(10)),
                      child: ClipRRect(
                        child: popupController.isUpdatingImage.value == true
                            ? SahaLoadingWidget()
                            : CachedNetworkImage(
                                imageUrl: popupController.logoUrl.value,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    SahaLoadingWidget(),
                                errorWidget: (context, url, error) => Padding(
                                  padding: const EdgeInsets.all(40.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.camera_enhance_outlined),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Thêm",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                : Expanded(
                    child: StaggeredGridView.countBuilder(
                      crossAxisCount: 1,
                      itemCount: popupController.listPopupCf.length,
                      itemBuilder: (BuildContext context, int index) =>
                          itemPopup(popupController.listPopupCf[index]),
                      staggeredTileBuilder: (int index) =>
                          new StaggeredTile.fit(1),
                      mainAxisSpacing: 30,
                      crossAxisSpacing: 30,
                    ),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 65,
        color: Colors.white,
        child: Column(
          children: [
            SahaButtonFullParent(
              text: "Thêm Quảng cáo",
              onPressed: () {
                Get.to(() => PopupConfigDetail())!.then((value) {
                  popupController.getListPopup();
                });
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget itemPopup(PopupCf popupCf) {
    return Card(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                      imageUrl: popupCf.linkImage ?? "",
                      fit: BoxFit.fitWidth,
                      placeholder: (context, url) => SahaLoadingWidget(),
                      errorWidget: (context, url, error) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SahaEmptyImage(),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 0, left: 20, right: 0, bottom: 20),
                child: InkWell(
                  onTap: () {
                    Get.to(() => PopupConfigDetail(
                              isUpdate: true,
                              popupCfInput: popupCf,
                            ))!
                        .then((value) {
                      popupController.getListPopup();
                    });
                  },
                  child: Container(
                    width: Get.width / 4,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    height: 30,
                    child: Center(
                      child: Text(
                        "Chỉnh sửa",
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
              left: 0,
              top: 0,
              child: Container(
                height: 30,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    popupController.convertTypePopup(popupCf.typeAction!),
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              )),
          Positioned(
            top: 5,
            right: 5,
            child: InkWell(
              onTap: () {
                popupController.deletePopup(popupCf.id!);
              },
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[300],
                ),
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
