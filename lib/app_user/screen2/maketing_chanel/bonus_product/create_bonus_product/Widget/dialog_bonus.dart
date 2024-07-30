import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

import '../../../../../model/bonus_product.dart';
import '../../search_bonus_product/search_bonus_product_screen.dart';
import 'search_offer/search_offer_screen.dart';

class DialogBonus {
  static void dialogBonusOffer(
      {ListOffer? listOfferInput, required Function onAccept}) {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          TextEditingController fromEditingController =
              new TextEditingController(
                  text: "${listOfferInput?.fromQuantity ?? ""}");
          TextEditingController bonusEditingController =
              new TextEditingController(
                  text: "${listOfferInput?.bonusQuantity ?? ""}");

          var listOffer = ListOffer().obs;
          var listBonusProductSelected = RxList<ListOffer>();
          if (listOfferInput != null) {
            listOffer(listOfferInput);
          }

          return new AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: <Widget>[
                    Expanded(
                      child: new TextField(
                        autofocus: true,
                        controller: fromEditingController,
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                          labelText: "Số lượng mua",
                          hintText: "Nhập số lượng mua",
                          hintStyle: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        onChanged: (v) {
                          listOffer.value.fromQuantity = int.tryParse(v);
                          print(listOffer.value.fromQuantity);
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        autofocus: true,
                        controller: bonusEditingController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Số lượng tặng",
                          hintText: "Nhập số lượng tặng",
                          hintStyle: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        onChanged: (v) {
                          listOffer.value.bonusQuantity = int.tryParse(v);
                          print(listOffer.value.bonusQuantity);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (listOffer.value.boProductId != null)
                          Container(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10, top: 5),
                            color: Colors.white,
                            width: Get.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(
                                      () => SearchOfferScreen(
                                        isSearch: true,
                                        listBonusProductSelected:
                                            listBonusProductSelected,
                                        onChoose: (List<ListOffer>
                                                listBonusProductSelected,
                                            bool? clickDone) {
                                          Get.back();

                                          if (listBonusProductSelected
                                              .isNotEmpty) {
                                            listOffer(
                                                listBonusProductSelected[0]);
                                            print(listOffer.value.boProductId);
                                          }
                                        },
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Sản phẩm: ${listOffer.value.productName ?? ""}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (listOffer.value.boElementDistributeName !=
                                    null)
                                  Text(
                                      "Phân loại: ${listOffer.value.boElementDistributeName ?? ""}${listOffer.value.boSubElementDistributeName == null ? "" : ","} ${listOffer.value.boSubElementDistributeName == null ? "" : listOffer.value.boSubElementDistributeName}"),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        if (listOffer.value.boProductId == null)
                          TextButton(
                              onPressed: () {
                                Get.to(
                                  () => SearchOfferScreen(
                                    isSearch: true,
                                    listBonusProductSelected:
                                        listBonusProductSelected,
                                    onChoose: (List<ListOffer>
                                            listBonusProductSelected,
                                        bool? clickDone) {
                                      Get.back();

                                      if (listBonusProductSelected.isNotEmpty) {
                                        listOffer(listBonusProductSelected[0]);
                                        print(listOffer.value.boProductId);
                                      }
                                    },
                                  ),
                                );
                              },
                              child: Text('Chọn sản phẩm tặng'))
                      ],
                    )),
              ],
            ),
            actions: <Widget>[
              new TextButton(
                  child: const Text('Hủy'),
                  onPressed: () {
                    Get.back();
                  }),
              new TextButton(
                  child: const Text('Đồng ý'),
                  onPressed: () {
                    if (listOffer.value.fromQuantity == null) {
                      SahaAlert.showError(message: "Chưa chọn số lượng mua");
                      return;
                    }

                    if (listOffer.value.bonusQuantity == null) {
                      SahaAlert.showError(message: "Chưa chọn số lượng tặng");
                      return;
                    }

                    if (listOffer.value.productName == null) {
                      SahaAlert.showError(message: "Chưa chọn sản phẩm");
                      return;
                    }
                    listOffer.value.fromQuantity =
                        int.tryParse("${fromEditingController.text}") ?? 0;
                    listOffer.value.bonusQuantity =
                        int.tryParse("${bonusEditingController.text}") ?? 0;

                    onAccept(listOffer.value);
                    Get.back();
                  })
            ],
          );
        });
  }
}
