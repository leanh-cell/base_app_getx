import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:readmore/readmore.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_avatar.dart';
import 'package:sahashop_customer/app_customer/components/widget/image_post.dart';
import 'package:sahashop_customer/app_customer/const/community.dart';
import 'package:sahashop_customer/app_customer/model/community_post.dart';
import 'package:screenshot/screenshot.dart';
import '../../../components/saha_user/dialog/dialog.dart';
import '../../../components/saha_user/loading/loading_container.dart';
import '../../../utils/string_utils.dart';

class PostCmtWidget extends StatelessWidget {
  CommunityPost post;
  bool hiddenCommentAction;
  Function update;
  Function? check;
  Function? hide;
  Function delete;
  Function rePost;
  Function onPin;
  Function? onResetParentList;

  PostCmtWidget(
      {required this.post,
      required this.onPin,
      this.onResetParentList,
      this.check,
      this.hide,
      this.hiddenCommentAction = false,
      required this.delete,
      required this.rePost,
      required this.update});

  buildButton(
      {required Icon icon,
      String? text,
      required Function onTap,
      Color? colorsText}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.all(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            Container(
              width: 2,
            ),
            Text(
              text!,
              style: TextStyle(color: colorsText ?? Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  String getName() {
    if (post.customer?.name != null) return post.customer!.name!;
    if (post.staff?.name != null) return post.staff!.name!;
    if (post.user?.name != null) return post.user!.name!;
    return '';
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return itemPost(communityPost: post);

    Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: post.images == null
                                ? ""
                                : post.images!.isNotEmpty
                                    ? "${post.images![0]}"
                                    : "",
                            height: 35,
                            width: 35,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => SahaLoadingContainer(
                              height: 35,
                              width: 35,
                            ),
                            errorWidget: (context, url, error) => Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Icon(Icons.person),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getName(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "${SahaStringUtils().displayTimeAgoFromTime(post.updatedAt ?? DateTime.now())}",
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 12,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 4,
                                    right: 2,
                                  ),
                                  child: Icon(
                                    Icons.fiber_manual_record_rounded,
                                    size: 5,
                                    color: Colors.black54,
                                  ),
                                ),
                                Icon(
                                  Icons.public_rounded,
                                  size: 15,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      child: Row(
                        children: [
                          if (post.isPin == true)
                            InkWell(
                              onTap: () {
                                onPin(false);
                              },
                              child: Icon(
                                Icons.push_pin,
                                color: Colors.red,
                              ),
                            ),
                          if (post.isPin == false || post.isPin == null)
                            InkWell(
                              onTap: () {
                                onPin(true);
                              },
                              child: Icon(
                                Icons.push_pin,
                                color: Colors.grey.shade400,
                              ),
                            ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            child: Icon(
                              Icons.close_rounded,
                              color: Colors.black54,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReadMoreText(
                      post.content ?? "",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      trimLength: 150,
                      trimCollapsedText: 'Xem thêm',
                      trimExpandedText: "Ẩn bớt",
                      lessStyle: TextStyle(color: Colors.grey.shade700),
                      moreStyle: TextStyle(color: Colors.grey.shade700),
                    ),
                  ],
                ),
              ),
              Container(
                child: CachedNetworkImage(
                  imageUrl: post.images != null && post.images!.isNotEmpty
                      ? post.images![0]
                      : "",
                  width: Get.width,
                  errorWidget: (context, url, error) => Container(
                    color: Colors.blue.withOpacity(0.1),
                    width: Get.width,
                    height: 200,
                    child: Center(
                      child: Text(
                        "${post.content ?? ""}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Icon(
                              FontAwesomeIcons.solidThumbsUp,
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            '${post.likes ?? 0}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Text(
                            'Sửa bình luận (${post.totalComment ?? 0})',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: Divider(
                  height: 1,
                  color: Colors.black26,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    buildButton(
                        icon: Icon(
                          Ionicons.create_outline,
                          color: Colors.blue,
                        ),
                        text: "Sửa",
                        colorsText: Colors.blue,
                        onTap: () {
                          update();
                        }),
                    buildButton(
                        icon: Icon(
                          Ionicons.refresh,
                          color: Theme.of(context).primaryColor,
                        ),
                        colorsText: Theme.of(context).primaryColor,
                        text: "Đăng lại",
                        onTap: () {
                          rePost();
                        }),
                    buildButton(
                        icon: Icon(
                          Ionicons.remove_circle_outline,
                          color: Colors.red,
                        ),
                        text: "Xóa",
                        colorsText: Colors.red,
                        onTap: () {
                          delete();
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget itemPost({required CommunityPost communityPost}) {
    String getName() {
      if (communityPost.customer?.name != null)
        return communityPost.customer!.name!;
      if (communityPost.staff?.name != null) return communityPost.staff!.name!;
      if (communityPost.user?.name != null) return communityPost.user!.name!;
      return '';
    }

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Spacer(),
                  if (check != null)
                        if (post.status == 1 || post.status == 2)
                      InkWell(
                        onTap: () {
                          check!();
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.green),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            'Duyệt',
                            style: TextStyle(
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                  SizedBox(
                    width: 10,
                  ),
                  if (hide != null && post.status != 2 )
                    InkWell(
                      onTap: () {
                        hide!();
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          'Ẩn',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Row(
                      children: [
                        if (post.isPin == true)
                          InkWell(
                            onTap: () {
                              onPin(false);
                            },
                            child: Icon(
                              Icons.push_pin,
                              color: Colors.red,
                            ),
                          ),
                        if (post.isPin == false || post.isPin == null)
                          InkWell(
                            onTap: () {
                              onPin(true);
                            },
                            child: Icon(
                              Icons.push_pin,
                              color: Colors.grey.shade400,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                                  communityPost.customer?.avatarImage ?? "",
                              height: 35,
                              width: 35,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  SahaEmptyAvata(),
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(TextSpan(
                                text: getName(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: <InlineSpan>[
                                  if (communityPost.feeling != null)
                                    TextSpan(
                                        text:
                                            '  đang cảm thấy ${feelCommunity[int.parse(communityPost.feeling!)].name}  ',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  if (communityPost.feeling != null)
                                    WidgetSpan(
                                        child: Icon(
                                      feelCommunity[
                                              int.parse(communityPost.feeling!)]
                                          .icon,
                                      size: 16,
                                    )),
                                ])),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                communityPost.updatedAt != null
                                    ? Text(
                                        "${(SahaStringUtils().displayTimeAgoFromTime(communityPost.updatedAt ?? DateTime.now()) == 'Đang hoạt động' ? 'vừa xong' : SahaStringUtils().displayTimeAgoFromTime(communityPost.updatedAt ?? DateTime.now()))}",
                                        style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 12,
                                        ),
                                      )
                                    : Container(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 4,
                                    right: 2,
                                  ),
                                  child: Icon(
                                    Icons.fiber_manual_record_rounded,
                                    size: 5,
                                    color: Colors.black54,
                                  ),
                                ),
                                Icon(
                                  Icons.public_rounded,
                                  size: 15,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    communityPost.backgroundColor != null
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                communityPost.backgroundColor ?? "",
                                fit: BoxFit.fill,
                              ),
                              Text(
                                communityPost.content ?? "",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          )
                        : communityPost.content != null
                            ? Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ReadMoreText(
                                  communityPost.content.toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                  trimLength: 150,
                                  trimCollapsedText: 'Xem thêm',
                                  trimExpandedText: "Ẩn bớt",
                                  lessStyle:
                                      TextStyle(color: Colors.grey.shade700),
                                  moreStyle:
                                      TextStyle(color: Colors.grey.shade700),
                                ),
                              )
                            : Container(),
                  ],
                ),
              ),
              if (communityPost.backgroundColor == null ||
                  communityPost.backgroundColor == '')
                ImagePost(
                  listImageUrl: communityPost.images ?? [],
                ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Icon(
                              FontAwesomeIcons.solidThumbsUp,
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            "${communityPost.totalLike}",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: Divider(
                  height: 1,
                  color: Colors.black26,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    buildButton(
                        icon: Icon(
                          Ionicons.create_outline,
                          color: Colors.blue,
                        ),
                        text: "Sửa",
                        colorsText: Colors.blue,
                        onTap: () {
                          update();
                        }),
                    buildButton(
                        icon: Icon(
                          Ionicons.refresh,
                          color: Theme.of(Get.context!).primaryColor,
                        ),
                        colorsText: Theme.of(Get.context!).primaryColor,
                        text: "Đăng lại",
                        onTap: () {
                          rePost();
                        }),
                    buildButton(
                        icon: Icon(
                          Ionicons.remove_circle_outline,
                          color: Colors.red,
                        ),
                        text: "Xóa",
                        colorsText: Colors.red,
                        onTap: () {
                          delete();
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
