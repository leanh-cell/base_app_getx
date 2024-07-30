import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty_widget/empty_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_customer/app_customer/model/post.dart';
import '../../../../saha_data_controller.dart';
import 'add_post/add_post_screen.dart';
import 'posts_controller.dart';

class PostScreen extends StatelessWidget {
  PostController postController = new PostController();
  SahaDataController sahaDataController = Get.find();
  TextEditingController searchEditingController = TextEditingController();
  RefreshController refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SahaAppBar(
          titleText: "Tất cả bài viết",
        ),
        body: Obx(
          () => postController.loadingInit.value
              ? SahaLoadingFullScreen()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, left: 8, right: 15, bottom: 8),
                              child: Icon(Icons.search),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: searchEditingController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(
                                      left: 0, right: 15, top: 15, bottom: 0),
                                  border: InputBorder.none,
                                  hintText: "Tìm kiếm",
                                  hintStyle: TextStyle(fontSize: 15),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      postController.textSearch = "";
                                      postController.getAllPost(
                                          isRefresh: true);
                                      searchEditingController.clear();
                                    },
                                    icon: Icon(Icons.clear),
                                  ),
                                ),
                                onChanged: (v) async {
                                  postController.textSearch = v;
                                  postController.getAllPost(isRefresh: true);
                                },
                                style: TextStyle(fontSize: 14),
                                minLines: 1,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                      ),
                      Expanded(
                        child: SmartRefresher(
                          enablePullDown: true,
                          enablePullUp: true,
                          header: MaterialClassicHeader(),
                          footer: CustomFooter(
                            builder: (
                              BuildContext context,
                              LoadStatus? mode,
                            ) {
                              Widget body = Container();
                              if (mode == LoadStatus.idle) {
                                body = Obx(() => postController.isLoading.value
                                    ? CupertinoActivityIndicator()
                                    : Container());
                              } else if (mode == LoadStatus.loading) {
                                body = CupertinoActivityIndicator();
                              }
                              return Container(
                                height: 100,
                                child: Center(child: body),
                              );
                            },
                          ),
                          controller: refreshController,
                          onRefresh: () async {
                            await postController.getAllPost(isRefresh: true);
                            refreshController.refreshCompleted();
                          },
                          onLoading: () async {
                            await postController.getAllPost();
                            refreshController.loadComplete();
                          },
                          child: Obx(() {
                            var list = postController.listPost.toList();
                            if (list.length == 0) {
                              return SahaEmptyWidget(
                                tile: "Không có danh mục nào",
                              );
                            }

                            return SingleChildScrollView(
                              child: Column(
                                children: list
                                    .map((e) => ItemPostWidget(
                                          post: e,
                                          isFix: true,
                                          postController: postController,
                                        ))
                                    .toList(),
                              ),
                            );

                            return ListView.separated(
                                separatorBuilder: (context, index) => Divider(),
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: list.length,
                                shrinkWrap: false,
                                itemBuilder: (context, index) {
                                  return ItemPostWidget(
                                    post: list[index],
                                    isFix: true,
                                    postController: postController,
                                  );
                                });
                          }),
                        ),
                      ),
                      SahaButtonFullParent(
                        onPressed: () {
                          Get.to(AddPostScreen())!.then((value) {
                            if (value == "added") {
                              postController.getAllPost();
                            }
                          });
                        },
                        text: "Thêm bài viết mới",
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
        ));
  }
}

class ItemPostWidget extends StatelessWidget {
  final Function? onTap;
  final bool? isFix;
  final PostController? postController;
  final Post? post;

  ItemPostWidget(
      {Key? key, this.post, this.onTap, this.isFix, this.postController})
      : super(key: key);

  SahaDataController sahaDataController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            onTap: () {
              if (isFix!) {
                Get.to(AddPostScreen(post: post))!.then((value) {
                  postController!.getAllPost();
                });
              }
            },
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                height: 60,
                width: 60,
                fit: BoxFit.cover,
                imageUrl: post!.imageUrl ?? "",
                placeholder: (context, url) => new SahaLoadingWidget(
                  size: 20,
                ),
                errorWidget: (context, url, error) => SahaEmptyImage(),
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post!.title ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 5,
                ),
                if (post!.summary != null)
                  Text(
                    post!.summary ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  post!.published == true ? "Đang hiển thị" : "Đang lưu tạm",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: post!.published == true ? Colors.blue : Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            trailing: IconButton(
                icon: Icon(Icons.delete_rounded),
                onPressed: () {
                  SahaDialogApp.showDialogYesNo(
                      mess: "Bạn muốn xóa danh mục này?",
                      onOK: () {
                        postController!.deletePost(post!.id!);
                        postController!.getAllPost();
                      });
                }),
          ),
        ),
      ),
    );
  }
}
