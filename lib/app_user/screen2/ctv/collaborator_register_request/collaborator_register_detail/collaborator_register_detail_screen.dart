import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty/saha_empty_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../data/remote/response-request/ctv/all_collaborator_register_request_res.dart';

class CollaboratorRegisterDetailScreen extends StatelessWidget {
  const CollaboratorRegisterDetailScreen(
      {Key? key, required this.collaboratorRegisterRequest})
      : super(key: key);
  final CollaboratorRegisterRequest collaboratorRegisterRequest;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Chi tiết yêu cầu"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            itemInfo(
                title: "Tên profile",
                subTitle:
                    collaboratorRegisterRequest.collaborator?.customer?.name ??
                        ''),
            const SizedBox(
              height: 8,
            ),
            itemInfo(
                title: "Tên tài khoản",
                subTitle:
                    collaboratorRegisterRequest.collaborator?.accountName ??
                        ''),
            const SizedBox(
              height: 8,
            ),
            itemInfo(
                title: "Số điện thoại",
                subTitle: collaboratorRegisterRequest
                        .collaborator?.customer?.phoneNumber ??
                    ''),
            const SizedBox(
              height: 8,
            ),
            itemInfo(
                title: "Trạng thái",
                subTitle: collaboratorRegisterRequest.status == 0
                    ? "Chờ duyệt"
                    : collaboratorRegisterRequest.status == 1
                        ? "Đã huỷ"
                        : collaboratorRegisterRequest.status == 2
                            ? "Đã duyệt"
                            : "Yêu cầu duyệt lại"),
            const SizedBox(
              height: 8,
            ),
            itemInfo(
                title: "Thời gian yêu cầu",
                subTitle:
                    "${DateFormat("HH:mm").format(collaboratorRegisterRequest.collaborator?.createdAt ?? DateTime.now())} - ${DateFormat("dd-MM-yyyy").format(collaboratorRegisterRequest.collaborator?.createdAt ?? DateTime.now())}"),
            const SizedBox(
              height: 8,
            ),
            itemInfo(
                title: "Số tài khoản",
                subTitle:
                    collaboratorRegisterRequest.collaborator?.accountNumber ??
                        ''),
            const SizedBox(
              height: 8,
            ),
            itemInfo(
                title: "Tên chủ tài khoản",
                subTitle:
                    collaboratorRegisterRequest.collaborator?.accountName ??
                        ''),
            const SizedBox(
              height: 8,
            ),
            itemInfo(
                title: "Tên CMND",
                subTitle: collaboratorRegisterRequest
                        .collaborator?.firstAndLastName ??
                    ''),
            const SizedBox(
              height: 8,
            ),
            itemInfo(
                title: "Số CMND",
                subTitle: collaboratorRegisterRequest.collaborator?.cmnd ?? ''),
            const SizedBox(
              height: 8,
            ),
            itemInfo(
                title: "Ngày đăng ký CTV",
                subTitle: DateFormat("dd-MM-yyyy").format(
                    collaboratorRegisterRequest.collaborator?.createdAt ??
                        DateTime.now())),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.white,
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                Column(
                  children: [
                    Text("CMND/CCCD mặt trước"),
                    CachedNetworkImage(
                      width: 100,
                      height: 100,
                      imageUrl:  collaboratorRegisterRequest.collaborator?.frontCard ?? '',
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => SahaEmptyImage(),
                    ),
                  ],
                ),
                 Column(
                  children: [
                    Text("CMND/CCCD mặt sau"),
                    CachedNetworkImage(
                      width: 100,
                      height: 100,
                      imageUrl:  collaboratorRegisterRequest.collaborator?.backCard ?? '',
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => SahaEmptyImage(),
                    ),
                  ],
                ),
              ]),
            )
          ],
        ),
      ),
      
    );
  }

  Widget itemInfo({required String title, required String subTitle}) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          const SizedBox(
            height: 8,
          ),
          Text(subTitle)
        ],
      ),
    );
  }
}
