import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_shimmer.dart';
import 'package:com.ikitech.store/app_user/screen2/review_manager/review_page/review_manage_controller.dart';

import 'star_page/star_page_manage_screen.dart';

// ignore: must_be_immutable
class ReviewManageScreen extends StatefulWidget {
  @override
  _ReviewManageScreenState createState() => _ReviewManageScreenState();
}

class _ReviewManageScreenState extends State<ReviewManageScreen> {

  ReviewManagerController reviewManagerController =
      Get.put(ReviewManagerController());

  final List<Widget> pages = <Widget>[
    StarPageManage(
      key: GlobalKey(),
      filterBy: "status",
      filterByValue: "0",
      status: 0,
    ),
    StarPageManage(
      key: GlobalKey(),
      filterBy: "status",
      filterByValue: "-1",
      status: -1,
    ),
    StarPageManage(
      key: GlobalKey(),
      filterBy: "stars",
      filterByValue: "1",
      status: 1,
    ),
    StarPageManage(
      key: GlobalKey(),
      filterBy: "stars",
      filterByValue: "2",
      status: 1,
    ),
    StarPageManage(
      key: GlobalKey(),
      filterBy: "stars",
      filterByValue: "3",
      status: 1,
    ),
    StarPageManage(
      key: GlobalKey(),
      filterBy: "stars",
      filterByValue: "4",
      status: 1,
    ),
    StarPageManage(
      key: GlobalKey(),
      filterBy: "stars",
      filterByValue: "5",
      status: 1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Quản lý đánh giá"),
      ),
      body: Obx(
        () => reviewManagerController.isLoading.value
            ? SahaSimmer(
                isLoading: true,
                child: Container(
                  width: Get.width,
                  height: Get.height,
                  color: Colors.black,
                ))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            reviewManagerController.changeIndexReview(0);
                          },
                          child: Container(
                            height: 35,
                            width: Get.width / 2 - 10,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(
                                  color: reviewManagerController
                                              .currentIndexReview.value ==
                                          0
                                      ? Theme.of(context).primaryColor
                                      : Colors.transparent),
                              borderRadius: BorderRadius.all(
                                Radius.circular(3),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Chờ xác nhận",
                                  style: TextStyle(fontSize: 13),
                                ),
                                Obx(
                                  () => Text(
                                    "(${reviewManagerController.totalPendingApproval.value})",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            reviewManagerController.changeIndexReview(1);
                          },
                          child: Container(
                            height: 35,
                            width: Get.width / 2 - 10,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(
                                  color: reviewManagerController
                                              .currentIndexReview.value ==
                                          1
                                      ? Theme.of(context).primaryColor
                                      : Colors.transparent),
                              borderRadius: BorderRadius.all(
                                Radius.circular(3),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Đã huỷ",
                                  style: TextStyle(fontSize: 13),
                                ),
                                Obx(
                                  () => Text(
                                    "(${reviewManagerController.totalCancel.value})",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: Get.width,
                    child: Row(
                      children: [
                        ...List.generate(5, (index) => chooseStar(index)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    height: 1,
                  ),
                  Obx(
                    () => Expanded(
                      child: pages[
                          reviewManagerController.currentIndexReview.value],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget chooseStar(int index) {
    return InkWell(
      onTap: () {
        reviewManagerController.changeIndexReview(index + 2);
      },
      child: Container(
        height: 35,
        width: Get.width / 5 - 10,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(
              color:
                  reviewManagerController.currentIndexReview.value == index + 2
                      ? Theme.of(context).primaryColor
                      : Colors.transparent),
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RatingBarIndicator(
                rating: (index + 1).toDouble(),
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: index + 1,
                itemSize: 13.0,
                direction: Axis.horizontal,
              ),
              Obx(
                () => Text(
                  "(${reviewManagerController.listStarOneToFive[index]})",
                  style: TextStyle(fontSize: 10),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
