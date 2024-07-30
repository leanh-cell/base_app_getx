import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_container.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../model/bonus_product.dart';
import '../../search_bonus_product/search_bonus_product_screen.dart';
import 'list_bonus_product_controller.dart';

class ListBonusProductScreen extends StatelessWidget {
  ListBonusProductScreen({Key? key, required this.updateBonusProductId})
      : super(key: key) {
    controller =
        ListBonusProductController(updateBonusProductId: updateBonusProductId);
  }
  final int updateBonusProductId;
  late ListBonusProductController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cài đặt thưởng"),
      ),
      body: Obx(
        () => controller.loadInit.value
            ? SahaLoadingFullScreen()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...List.generate(
                                controller
                                    .bonusProduct.value.groupProducts!.length,
                                (index) => itemBonus(
                                    index,
                                    controller.bonusProduct.value
                                        .groupProducts![index])),
                            InkWell(
                              onTap: () {
                                if (controller.loadBonusProductItem.value ==
                                    true) {
                                  return;
                                }
                                controller.indexChoose.value = -1;
                                controller.bonusProductItem.value =
                                    BonusProduct(
                                        selectProducts: [], bonusProducts: []);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color:
                                            controller.indexChoose.value == -1
                                                ? Colors.red
                                                : Colors.grey)),
                                child: Text("Thêm nhóm +"),
                              ),
                            )
                          ],
                        ),
                      ),
                      Obx(
                        () => controller.loadBonusProductItem.value
                            ? SahaLoadingFullScreen()
                            : Column(
                                children: [
                                  Container(
                                    color: Colors.white,
                                    width: Get.width,
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Obx(
                                          () => Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0, bottom: 10),
                                                child: Text("Sản phẩm mua"),
                                              ),
                                              controller
                                                          .bonusProductItem
                                                          .value
                                                          .selectProducts!
                                                          .length ==
                                                      0
                                                  ? Container()
                                                  : IconButton(
                                                      icon: Icon(
                                                        Icons.add,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                      onPressed: () {
                                                        Get.to(
                                                          () =>
                                                              SearchBonusProductScreen(
                                                            isSearch: false,
                                                            listBonusProductSelected:
                                                                controller
                                                                    .bonusProductItem
                                                                    .value
                                                                    .selectProducts!
                                                                    .toList(),
                                                            onChoose: (List<
                                                                        BonusProductSelected>
                                                                    listBonusProductSelected,
                                                                bool?
                                                                    clickDone) {
                                                              Get.back();
                                                              if (clickDone ==
                                                                  true) {
                                                                controller
                                                                        .bonusProductItem
                                                                        .value
                                                                        .selectProducts =
                                                                    listBonusProductSelected;
                                                              } else {
                                                                if (controller
                                                                    .bonusProductItem
                                                                    .value
                                                                    .selectProducts!
                                                                    .isNotEmpty) {
                                                                  controller
                                                                      .bonusProductItem
                                                                      .value
                                                                      .selectProducts!
                                                                      .addAll(
                                                                          listBonusProductSelected);
                                                                } else {
                                                                  controller
                                                                          .bonusProductItem
                                                                          .value
                                                                          .selectProducts =
                                                                      listBonusProductSelected;
                                                                }
                                                              }
                                                              controller
                                                                  .bonusProductItem
                                                                  .refresh();
                                                            },
                                                          ),
                                                        );
                                                      })
                                            ],
                                          ),
                                        ),
                                        Obx(() => (controller
                                                            .bonusProductItem
                                                            .value
                                                            .selectProducts ??
                                                        [])
                                                    .length ==
                                                0
                                            ? InkWell(
                                                onTap: () {
                                                  Get.to(
                                                    () =>
                                                        SearchBonusProductScreen(
                                                      isSearch: true,
                                                      chooseOne: true,
                                                      listBonusProductSelected:
                                                          controller
                                                              .bonusProductItem
                                                              .value
                                                              .selectProducts!
                                                              .toList(),
                                                      onChoose: (List<
                                                                  BonusProductSelected>
                                                              listBonusProductSelected,
                                                          bool? clickDone) {
                                                        Get.back();
                                                        if (clickDone == true) {
                                                          controller
                                                                  .bonusProductItem
                                                                  .value
                                                                  .selectProducts =
                                                              listBonusProductSelected;
                                                        } else {
                                                          if (controller
                                                              .bonusProductItem
                                                              .value
                                                              .selectProducts!
                                                              .isNotEmpty) {
                                                            controller
                                                                .bonusProductItem
                                                                .value
                                                                .selectProducts!
                                                                .addAll(
                                                                    listBonusProductSelected);
                                                          } else {
                                                            controller
                                                                    .bonusProductItem
                                                                    .value
                                                                    .selectProducts =
                                                                listBonusProductSelected;
                                                          }
                                                        }
                                                        controller
                                                            .bonusProductItem
                                                            .refresh();
                                                      },
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.add,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                      Text(
                                                        'Thêm sản phẩm',
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor),
                                                        textAlign:
                                                            TextAlign.center,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Obx(
                                                () => Wrap(
                                                  runSpacing: 5,
                                                  spacing: 5,
                                                  children: [
                                                    ...List.generate(
                                                        (controller
                                                                    .bonusProductItem
                                                                    .value
                                                                    .selectProducts ??
                                                                [])
                                                            .length, (index) {
                                                      var e = (controller
                                                              .bonusProductItem
                                                              .value
                                                              .selectProducts ??
                                                          [])[index];
                                                      return Stack(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColor),
                                                                ),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  height: 100,
                                                                  width:
                                                                      Get.width /
                                                                          4,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  imageUrl: e
                                                                              .product
                                                                              ?.images
                                                                              ?.length ==
                                                                          0
                                                                      ? ""
                                                                      : e
                                                                          .product!
                                                                          .images![
                                                                              0]
                                                                          .imageUrl!,
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      Container(
                                                                          height:
                                                                              100,
                                                                          width: Get.width /
                                                                              4,
                                                                          child:
                                                                              Icon(
                                                                            Icons.image,
                                                                            color:
                                                                                Colors.grey,
                                                                            size:
                                                                                40,
                                                                          )),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                      child:
                                                                          Text(
                                                                        "${e.product?.name ?? ""}",
                                                                        maxLines:
                                                                            2,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                    ),
                                                                    if (e.elementDistributeName !=
                                                                        null)
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                10.0,
                                                                            right:
                                                                                10),
                                                                        child: Text(
                                                                            "Phân loại: ${e.elementDistributeName ?? ""}${e.subElementDistributeName == null ? "" : ","} ${e.subElementDistributeName == null ? "" : e.subElementDistributeName}"),
                                                                      ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        IconButton(
                                                                            icon:
                                                                                Icon(Icons.remove),
                                                                            onPressed: () {
                                                                              controller.decreaseProductSelected(index);
                                                                            }),
                                                                        SizedBox(
                                                                          width:
                                                                              20,
                                                                        ),
                                                                        Text(
                                                                            "${e.quantity ?? 0}"),
                                                                        SizedBox(
                                                                          width:
                                                                              20,
                                                                        ),
                                                                        IconButton(
                                                                            icon:
                                                                                Icon(Icons.add),
                                                                            onPressed: () {
                                                                              controller.increaseProductSelected(index);
                                                                            }),
                                                                      ],
                                                                    ),
                                                                    if (e.distributeName == null &&
                                                                        e.elementDistributeName ==
                                                                            null &&
                                                                        e.allowsAllDistribute ==
                                                                            true)
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(left: 10.0),
                                                                        child:
                                                                            Text(
                                                                          'SP cho phép mua mọi phân loại',
                                                                          maxLines:
                                                                              1,
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              color: Colors.blue,
                                                                              fontWeight: FontWeight.w600),
                                                                        ),
                                                                      ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Positioned(
                                                            top: 0,
                                                            left: -10,
                                                            child: IconButton(
                                                                icon: Icon(
                                                                  Icons.delete,
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                                onPressed: () {
                                                                  controller
                                                                      .deleteProductSelected(
                                                                          index);
                                                                }),
                                                          ),
                                                        ],
                                                      );
                                                    })
                                                  ],
                                                ),
                                              )),
                                      ],
                                    ),
                                  ),
                                  const Divider(),
                                  Container(
                                    color: Colors.white,
                                    width: Get.width,
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Obx(
                                          () => Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0, bottom: 10),
                                                child: Text("Sản phẩm tặng"),
                                              ),
                                              controller
                                                          .bonusProductItem
                                                          .value
                                                          .bonusProducts!
                                                          .length ==
                                                      0
                                                  ? Container()
                                                  : IconButton(
                                                      icon: Icon(
                                                        Icons.add,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                      onPressed: () {
                                                        Get.to(
                                                          () =>
                                                              SearchBonusProductScreen(
                                                            isSearch: true,
                                                            listBonusProductSelected:
                                                                controller
                                                                    .bonusProductItem
                                                                    .value
                                                                    .bonusProducts!
                                                                    .toList(),
                                                            onChoose: (List<
                                                                        BonusProductSelected>
                                                                    listBonusProductSelected,
                                                                bool?
                                                                    clickDone) {
                                                              Get.back();
                                                              if (clickDone ==
                                                                  true) {
                                                                controller
                                                                        .bonusProductItem
                                                                        .value
                                                                        .bonusProducts =
                                                                    listBonusProductSelected;
                                                              } else {
                                                                if (controller
                                                                    .bonusProductItem
                                                                    .value
                                                                    .bonusProducts!
                                                                    .isNotEmpty) {
                                                                  controller
                                                                      .bonusProductItem
                                                                      .value
                                                                      .bonusProducts!
                                                                      .addAll(
                                                                          listBonusProductSelected);
                                                                } else {
                                                                  controller
                                                                          .bonusProductItem
                                                                          .value
                                                                          .bonusProducts =
                                                                      listBonusProductSelected;
                                                                }
                                                              }
                                                              controller
                                                                  .bonusProductItem
                                                                  .refresh();
                                                            },
                                                          ),
                                                        );
                                                      })
                                            ],
                                          ),
                                        ),
                                        Obx(
                                          () =>
                                              controller
                                                          .bonusProductItem
                                                          .value
                                                          .bonusProducts!
                                                          .length ==
                                                      0
                                                  ? InkWell(
                                                      onTap: () {
                                                        Get.to(
                                                          () =>
                                                              SearchBonusProductScreen(
                                                            isSearch: true,
                                                            listBonusProductSelected:
                                                                controller
                                                                    .bonusProductItem
                                                                    .value
                                                                    .bonusProducts!
                                                                    .toList(),
                                                            onChoose: (List<
                                                                        BonusProductSelected>
                                                                    listBonusProductSelected,
                                                                bool?
                                                                    clickDone) {
                                                              Get.back();
                                                              if (clickDone ==
                                                                  true) {
                                                                controller
                                                                        .bonusProductItem
                                                                        .value
                                                                        .bonusProducts =
                                                                    (listBonusProductSelected);
                                                              } else {
                                                                if (controller
                                                                    .bonusProductItem
                                                                    .value
                                                                    .bonusProducts!
                                                                    .isNotEmpty) {
                                                                  controller
                                                                      .bonusProductItem
                                                                      .value
                                                                      .bonusProducts!
                                                                      .addAll(
                                                                          listBonusProductSelected);
                                                                } else {
                                                                  controller
                                                                          .bonusProductItem
                                                                          .value
                                                                          .bonusProducts =
                                                                      (listBonusProductSelected);
                                                                }
                                                              }
                                                              controller
                                                                  .bonusProductItem
                                                                  .refresh();
                                                            },
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        height: 100,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor)),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons.add,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                            ),
                                                            Text(
                                                              'Thêm sản phẩm',
                                                              style: TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : Obx(
                                                      () => Wrap(
                                                        runSpacing: 5,
                                                        spacing: 5,
                                                        children: [
                                                          ...List.generate(
                                                              controller
                                                                  .bonusProductItem
                                                                  .value
                                                                  .bonusProducts!
                                                                  .length,
                                                              (index) {
                                                            var e = controller
                                                                .bonusProductItem
                                                                .value
                                                                .bonusProducts![index];
                                                            return Stack(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border: Border.all(
                                                                            color:
                                                                                Theme.of(context).primaryColor),
                                                                      ),
                                                                      child:
                                                                          CachedNetworkImage(
                                                                        height:
                                                                            100,
                                                                        width:
                                                                            Get.width /
                                                                                4,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        imageUrl: e.product?.images?.length ==
                                                                                0
                                                                            ? ""
                                                                            : e.product!.images![0].imageUrl!,
                                                                        errorWidget: (context, url, error) => Container(
                                                                            height: 100,
                                                                            width: Get.width / 4,
                                                                            child: Icon(
                                                                              Icons.image,
                                                                              color: Colors.grey,
                                                                              size: 40,
                                                                            )),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(10.0),
                                                                            child:
                                                                                Text(
                                                                              "${e.product?.name ?? ""}",
                                                                              maxLines: 2,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: TextStyle(fontWeight: FontWeight.w500),
                                                                            ),
                                                                          ),
                                                                          if (e.elementDistributeName !=
                                                                              null)
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 10.0, right: 10),
                                                                              child: Text("Phân loại: ${e.elementDistributeName ?? ""}${e.subElementDistributeName == null ? "" : ","} ${e.subElementDistributeName == null ? "" : e.subElementDistributeName}"),
                                                                            ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            children: [
                                                                              IconButton(
                                                                                  icon: Icon(Icons.remove),
                                                                                  onPressed: () {
                                                                                    controller.decreaseBonusProductSelected(index);
                                                                                  }),
                                                                              SizedBox(
                                                                                width: 20,
                                                                              ),
                                                                              Text("${e.quantity}"),
                                                                              SizedBox(
                                                                                width: 20,
                                                                              ),
                                                                              IconButton(
                                                                                  icon: Icon(Icons.add),
                                                                                  onPressed: () {
                                                                                    controller.increaseBonusProductSelected(index);
                                                                                  }),
                                                                            ],
                                                                          ),
                                                                          if (e.allowsChooseDistribute ==
                                                                              true)
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 10.0),
                                                                              child: Text(
                                                                                'Cho phép tự chọn phân loại',
                                                                                maxLines: 1,
                                                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.blue),
                                                                              ),
                                                                            ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Positioned(
                                                                  top: 5,
                                                                  left: -10,
                                                                  child: IconButton(
                                                                      icon: Icon(
                                                                        Icons
                                                                            .delete,
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                                      onPressed: () {
                                                                        controller
                                                                            .deleteBonusProductSelected(index);
                                                                      }),
                                                                ),
                                                              ],
                                                            );
                                                          })
                                                        ],
                                                      ),
                                                    ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          if (controller.indexChoose.value ==
                                              -1) {
                                            await controller
                                                .addBonusProductItem();
                                            await controller
                                                .getBonusProduct(false);
                                            controller.indexChoose.value =
                                                controller.bonusProduct.value
                                                        .groupProducts!.length -
                                                    1;
                                          } else {
                                            await controller
                                                .updateBonusProductItem();
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 10, 20, 10),
                                          decoration: BoxDecoration(
                                              color: Colors.green[200],
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Text(
                                            "Lưu",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      if (controller.indexChoose.value != -1)
                                        InkWell(
                                          onTap: () async {
                                            await controller
                                                .deleteBonusProductItem();
                                            if ((controller.bonusProduct.value
                                                        .groupProducts ??
                                                    [])
                                                .isEmpty) {
                                              controller.indexChoose.value = -1;
                                            } else {
                                              controller.indexChoose.value = 0;
                                            }
                                            controller.getBonusProduct(true);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 10, 20, 10),
                                            decoration: BoxDecoration(
                                                color: Colors.red[300],
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Text(
                                              "Xoá",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                    ],
                                  )
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget itemBonus(int index, int idGroupProduct) {
    return InkWell(
      onTap: () {
        if (controller.loadBonusProductItem.value == true) {
          return;
        }
        controller.indexChoose.value = index;
        controller.getBonusProductItem(groupProduct: idGroupProduct);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: controller.indexChoose.value == index
                    ? Colors.red
                    : Colors.grey)),
        child: Text("Nhóm số ${index + 1}"),
      ),
    );
  }
}
