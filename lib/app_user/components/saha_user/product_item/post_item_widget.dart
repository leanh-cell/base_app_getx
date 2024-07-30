import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty/saha_empty_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_container.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:sahashop_customer/app_customer/model/post.dart';

class PostItemWidget extends StatelessWidget {
  const PostItemWidget({
    Key? key,
    required this.post,
    this.isLoading = false,
    this.width,
  }) : super(key: key);

  final Post post;
  final bool isLoading;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: width,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(8),
          child: InkWell(
            onTap: () {
              // DataAppCustomerController dataAppCustomerController = Get.find();
              // dataAppCustomerController.toPostAllScreen();
              // Get.to(() => ReadPostScreen(
              //       inputModelPost: InputModelPost(post: post),
              //     ));
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                  child: isLoading
                      ? Container(
                          height: 70,
                          width: 70,
                          color: Colors.black,
                          child: Row(
                            children: [
                              Container(
                                height: 70,
                              )
                            ],
                          ),
                        )
                      : CachedNetworkImage(
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                          imageUrl: post.imageUrl == null ? "" : post.imageUrl!,
                          placeholder: (context, url) => SahaLoadingContainer(),
                          errorWidget: (context, url, error) =>
                              SahaEmptyImage(),
                        ), //post.images[0].imageUrl,
                ),
                SizedBox(width: 5),
                Expanded(
                  child: isLoading
                      ? Container(
                          width: 40,
                          height: 10,
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Container(
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        post.title!,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                        maxLines: 2,
                                      ),
                                      Text(
                                        post.summary ?? "",
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      post.category != null &&
                                              post.category!.length > 0
                                          ? post.category![0].title!
                                          : "",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                      maxLines: 2,
                                    ),
                                    Spacer(),
                                    Text(
                                      SahaDateUtils().getDDMMYY(
                                          post.updatedAt ?? DateTime.now()),
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
