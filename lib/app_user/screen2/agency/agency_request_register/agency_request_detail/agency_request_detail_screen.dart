import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../components/saha_user/empty/saha_empty_image.dart';
import '../../../../data/remote/response-request/agency/all_agency_register_request_res.dart';

class AgencyRegisterDetailScreen extends StatelessWidget {
  const AgencyRegisterDetailScreen(
      {Key? key, required this.agencyRegisterRequest})
      : super(key: key);
  final AgencyRegisterRequest agencyRegisterRequest;
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
                    agencyRegisterRequest.agency?.customer?.name ??
                        ''),
            const SizedBox(
              height: 8,
            ),
            itemInfo(
                title: "Tên tài khoản",
                subTitle:
                    agencyRegisterRequest.agency?.accountName ??
                        ''),
            const SizedBox(
              height: 8,
            ),
            itemInfo(
                title: "Số điện thoại",
                subTitle: agencyRegisterRequest
                        .agency?.customer?.phoneNumber ??
                    ''),
            const SizedBox(
              height: 8,
            ),
            itemInfo(
                title: "Trạng thái",
                subTitle: agencyRegisterRequest.status == 0
                    ? "Chờ duyệt"
                    : agencyRegisterRequest.status == 1
                        ? "Đã huỷ"
                        : agencyRegisterRequest.status == 2
                            ? "Đã duyệt"
                            : "Yêu cầu duyệt lại"),
            const SizedBox(
              height: 8,
            ),
            itemInfo(
                title: "Thời gian yêu cầu",
                subTitle:
                    "${DateFormat("HH:mm").format(agencyRegisterRequest.agency?.createdAt ?? DateTime.now())} - ${DateFormat("dd-MM-yyyy").format(agencyRegisterRequest.agency?.createdAt ?? DateTime.now())}"),
            const SizedBox(
              height: 8,
            ),
            itemInfo(
                title: "Số tài khoản",
                subTitle:
                    agencyRegisterRequest.agency?.accountNumber ??
                        ''),
            const SizedBox(
              height: 8,
            ),
            itemInfo(
                title: "Tên chủ tài khoản",
                subTitle:
                    agencyRegisterRequest.agency?.accountName ??
                        ''),
            const SizedBox(
              height: 8,
            ),
            itemInfo(
                title: "Tên CMND",
                subTitle: agencyRegisterRequest
                        .agency?.firstAndLastName ??
                    ''),
            const SizedBox(
              height: 8,
            ),
            itemInfo(
                title: "Số CMND",
                subTitle: agencyRegisterRequest.agency?.cmnd ?? ''),
            const SizedBox(
              height: 8,
            ),
            itemInfo(
                title: "Ngày đăng ký CTV",
                subTitle: DateFormat("dd-MM-yyyy").format(
                    agencyRegisterRequest.agency?.createdAt ??
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
                      imageUrl:  agencyRegisterRequest.agency?.frontCard ?? '',
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
                      imageUrl:  agencyRegisterRequest.agency?.backCard ?? '',
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