import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/model/decentralization.dart';

class WatchedDecentralizationScreen extends StatelessWidget {
  Decentralization decentralizationInput;

  WatchedDecentralizationScreen({required this.decentralizationInput}) {
    nameEditingController =
        TextEditingController(text: decentralizationInput.name);
    desEditingController =
        TextEditingController(text: decentralizationInput.description);
  }

  TextEditingController nameEditingController = TextEditingController();
  TextEditingController desEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Xem phân quyền"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            IgnorePointer(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tên phân quyền: ",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    Container(
                      width: Get.width,
                      child: TextFormField(
                        controller: nameEditingController,
                        validator: (value) {
                          if (value!.length < 1) {
                            return 'Chưa nhập tên phân quyền';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: "Nhập tên phân quyền",
                        ),
                        style: TextStyle(fontSize: 14),
                        minLines: 1,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IgnorePointer(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mô tả phân quyền: ",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    Container(
                      width: Get.width,
                      child: TextFormField(
                        controller: desEditingController,
                        validator: (value) {
                          if (value!.length < 1) {
                            return 'Chưa nhập mô tả phân quyền';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: "Nhập mô tả phân quyền",
                        ),
                        style: TextStyle(fontSize: 14),
                        minLines: 1,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (decentralizationInput.notificationToStote == true)
              Column(
                children: [
                  Divider(
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Cho phép xem danh sách thông báo"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.chatList == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Xem danh sách chat"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.reportView == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Xem báo cáo"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.reportOrder == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Quản lý đơn hàng"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.orderAllowChangeStatus == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Quản lý trạng thái đơn hàng đơn hàng"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.decentralizationList == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Danh sách phân quyền"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.decentralizationUpdate == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Cập nhật phân quyền"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.decentralizationAdd == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Thêm phân quyền"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.decentralizationRemove == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Xóa phân quyền"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.staffList == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Danh sách nhân viên"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.staffUpdate == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Cập nhật nhân viên"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.staffAdd == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Thêm nhân viên"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.staffRemove == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Xóa nhân viên"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.customerList == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Xem danh sách khách hàng"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.customerConfigPoint == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Cấu hình điểm thưởng"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.customerReviewList == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Danh sách đánh giá"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.customerReviewCensorship == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Kiểm duyệt đánh giá"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.collaboratorConfig == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Cấu hình cộng tác viên"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.collaboratorList == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Xem danh sách cộng tác viên"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.collaboratorPaymentRequestList == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Xem danh sách yêu cầu thanh toán"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.collaboratorPaymentRequestSolve == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Cho phép hủy hoặc thanh toán"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.collaboratorPaymentRequestHistory == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Xem lịch sử yêu cầu thanh toán"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.appThemeEdit == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Truy cập chỉnh sửa app"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.appThemeMainConfig == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Chỉnh sửa cấu hình"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.appThemeButtonContact == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Nút liên hệ"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.appThemeHomeScreen == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Màn hình trang chủ"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.appThemeMainComponent == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Thành phần chính"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.appThemeCategoryProduct == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Màn hình danh mục sản phẩm"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.appThemeProductScreen == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Màn hình sản phẩm"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.appThemeContactScreen == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Màn hình liên hệ"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.productList == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Xem sản phẩm"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.productAdd == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Thêm sản phẩm"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.productUpdate == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Cập nhật sản phẩm"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.productRemoveHide == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Xóa/Ẩn sản phẩm"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.productCategoryList == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Xem danh mục sản phẩm"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.productCategoryAdd == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Thêm danh mục sản phẩm"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.productCategoryUpdate == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Cập nhật danh mục sản phẩm"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.productCategoryRemove == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Xóa danh mục sản phẩm"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.productAttributeList == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Xem danh sách thuộc tính sản phẩm"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.productAttributeAdd == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Thêm thuộc tính sản phẩm"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.productAttributeRemove == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Xóa thuộc tính sản phẩm"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.productEcommerce == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Sản phẩm từ sàn thương mại điện tử"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.productImportFromExcel == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Thêm sản phẩm từ file exel"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.productExportToExcel == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Xuất danh sách sản phẩm ra file exel"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.promotionDiscountList == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Xem danh sách giảm giá sản phẩm"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.promotionDiscountAdd == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Thêm sản phẩm giảm giá"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.promotionDiscountUpdate == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Cập nhật sản phẩm giảm giá"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.promotionDiscountEnd == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Kết thúc sản phẩm giảm giá"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.promotionVoucherList == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Xem danh sách voucher"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.promotionVoucherAdd == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Thêm voucher"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.promotionVoucherUpdate == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Cập nhật voucher"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.promotionVoucherEnd == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Kết thúc voucher"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.promotionComboList == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Xem danh sách combo"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.promotionComboAdd == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Thêm combo"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.promotionComboUpdate == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Cập nhật combo"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.promotionComboEnd == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Kết thúc combo"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.postList == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Danh sách bài viết"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.postAdd == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Thêm bài viết"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.postUpdate == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Cập nhật bài viết"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.postRemoveHide == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Xóa/Ẩn bài viết"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.postCategoryList == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Xem danh mục bài viết"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.postCategoryAdd == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Thêm danh mục bài viết"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.postCategoryUpdate == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Cập nhật danh mục bài viết"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.postCategoryRemove == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Xóa danh mục bài viết"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.deliveryPickAddressList == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Danh sách địa chỉ lấy hàng"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.deliveryPickAddressUpdate == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Chỉnh sửa địa chỉ"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.deliveryProviderUpdate == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Chỉnh sửa bên cung cấp giao vận"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.paymentList == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Xem danh sách bên thanh toán"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.paymentOnOff == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Bật tắt nhà thanh toán"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.notificationScheduleList == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Danh sách lịch thông báo"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.notificationScheduleAdd == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Thêm lịch thông báo"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.notificationScheduleRemovePause == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Xóa/Tạm dừng thông báo"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.notificationScheduleUpdate == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Cập nhật lịch thông báo"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.popupList == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Danh sách popup quảng cáo"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.popupAdd == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Thêm popup"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.popupUpdate == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Cập nhật popup"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.popupRemove == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Xóa popup"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.popupRemove == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Xóa popup"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.webThemeEdit == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Truy cập chỉnh sửa web"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.webThemeOverview == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tổng quan Web"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.webThemeContact == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Liên hệ Web"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.webThemeHelp == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Hỗ trợ Web"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.webThemeFooter == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Dưới trang Web"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (decentralizationInput.webThemeBanner == true)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Banner Web"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
