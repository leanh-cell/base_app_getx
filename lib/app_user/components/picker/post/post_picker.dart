import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/saha_text_field_search.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_customer/app_customer/model/post.dart';
import 'post_picker_controller.dart';

class PostPickerScreen extends StatefulWidget {
  final Function? callback;
  final List<Post>? listPostInput;
  final bool onlyOne;

  PostPickerScreen({this.callback, this.listPostInput, this.onlyOne = false});

  @override
  _PostPickerScreenState createState() => _PostPickerScreenState();
}

class _PostPickerScreenState extends State<PostPickerScreen> {
  bool isSearch = false;

  PostPickerController postPickerController = PostPickerController();
  RefreshController? refreshController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postPickerController.listPostInput = widget.listPostInput;
    postPickerController.getAllPost(isRefresh: true);
    refreshController = RefreshController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => postPickerController.isSearch.value
              ? SahaTextFieldSearch(
                  onSubmitted: (va) {
                    postPickerController.resetListPost();
                    postPickerController.textSearch = va;
                    print(postPickerController.textSearch);
                    postPickerController.getAllPost(
                        textSearch: postPickerController.textSearch!,
                        isRefresh: true);
                  },
                  onClose: () {
                    postPickerController.textSearch = null;
                    postPickerController.isSearch.value = false;
                  },
                )
              : Text("Tất cả bài viết"),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search_outlined),
              onPressed: () {
                postPickerController.isSearch.value = true;
              })
        ],
      ),
      body: SmartRefresher(
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
              body = Obx(() => postPickerController.isLoadMore.value
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
        controller: refreshController!,
        onRefresh: () async {
          postPickerController.resetListPost();
          await postPickerController.getAllPost(isRefresh: true);
          refreshController!.refreshCompleted();
        },
        onLoading: () async {
          await postPickerController.getAllPost(
              textSearch: postPickerController.textSearch, isRefresh: false);
          refreshController!.loadComplete();
        },
        child: SingleChildScrollView(
          child: Obx(
            () => postPickerController.isLoadingPost.value == true
                ? SahaLoadingWidget()
                : Column(
                    children: [
                      ...List.generate(
                        postPickerController.listPost.length,
                        (index) => InkWell(
                          onTap: () {
                            onChange(postPickerController.listPost[index]);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                            ),
                            child: Row(
                              children: [
                                Checkbox(
                                    value: postPickerController
                                        .listCheckSelectedPost
                                        .contains(postPickerController
                                            .listPost[index]),
                                    onChanged: (v) {
                                      onChange(
                                          postPickerController.listPost[index]);
                                    }),
                                SizedBox(
                                  width: 88,
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF5F6F9),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: postPickerController
                                                        .listPost[index]
                                                        .imageUrl ==
                                                    null
                                                ? ""
                                                : postPickerController
                                                    .listPost[index].imageUrl!,
                                            errorWidget:
                                                (context, url, error) => Icon(
                                                      Icons.image,
                                                      size: 40,
                                                      color: Colors.grey,
                                                    )),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Container(
                                  width: Get.width * 0.5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        postPickerController
                                                .listPost[index].title ??
                                            "Loi san pham",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                        maxLines: 2,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          "${postPickerController.listPost[index].category!.length > 0 ? postPickerController.listPost[index].category![0].title : ""} "),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
          height: 80,
          color: Colors.white,
          padding: EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    postPickerController.listCheckSelectedPost.length.toString(),
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Đã Chọn'),
                ],
              ),
              InkWell(
                onTap: () {
                  widget.callback!(postPickerController.listCheckSelectedPost);
                  Get.back();
                },
                child: Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(3)),
                  child: Center(
                    child: Text('Thêm'),
                  ),
                ),
              )
            ],
          )),
    );
  }

  void onChange(Post post) {
    if (widget.onlyOne) {
      postPickerController.listCheckSelectedPost.clear();
      if (postPickerController.listCheckSelectedPost.contains(post)) {
        postPickerController.listCheckSelectedPost.remove(post);
      } else {
        postPickerController.listCheckSelectedPost.add(post);
      }
    } else {
      if (postPickerController.listCheckSelectedPost.contains(post)) {
        postPickerController.listCheckSelectedPost.remove(post);
      } else {
        postPickerController.listCheckSelectedPost.add(post);
      }
    }
    setState(() {});
  }
}
