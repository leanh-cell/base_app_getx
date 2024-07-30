import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty/saha_empty_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/password_text_field.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/text_field_with_border.dart';
import 'package:com.ikitech.store/app_user/model/shipment.dart';
import 'package:com.ikitech.store/app_user/screen2/config_store_address/login_shipping_company/login_shipping_company_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginShippingCompanyScreen extends StatelessWidget {
  LoginShippingCompanyScreen({Key? key, required this.shipment})
      : super(key: key) {
    controller = LoginShippingCompanyController(shipment: shipment);
  }
  final Shipment shipment;
  late final LoginShippingCompanyController controller;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đăng nhập"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: shipment.id == 2
                ? viettelPost()
                : shipment.id == 3
                    ? vietnamPost() : shipment.id == 4 ? nhatTin()
                    : const SizedBox()),
      ),
      bottomNavigationBar: SizedBox(
        height: 65,
        child: Column(
          children: [
            SahaButtonFullParent(
              text: "Đăng nhập",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (shipment.id == 2) {
                    controller.loginViettelPost();
                  }
                  if (shipment.id == 3) {
                    controller.loginVietnamPost();
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget viettelPost() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.network(
            shipment.imageUrl ?? "",
            width: Get.width,
            height: 200,
            errorBuilder: (context, error, stackTrace) {
              return SahaEmptyImage();
            },
          ),
          Text(
            "Bạn cần đăng ký Viettel Post tại đây https://viettelpost.vn và cung cấp tài khoản của bạn ở đây để thực hiện kết nối và lấy token",
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 16,
          ),
          TextFieldWithBorder(
            labelText: "Số điện thoại",
            hintText: "Nhập số điện thoại",
            controller: controller.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Hãy nhập số điện thoại';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          PasswordTextField(
            labelText: "Mật khẩu",
            hintText: "Nhập mật khẩu",
            controller: controller.password,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Hãy nhập mật khẩu';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget vietnamPost() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.network(
            shipment.imageUrl ?? "",
            width: Get.width,
            height: 200,
            errorBuilder: (context, error, stackTrace) {
              return SahaEmptyImage();
            },
          ),
          Text(
            "Bạn cần đăng ký VietNam Post tại đây https://my.vnpost.vn/  và cung cấp tài khoản của bạn ở đây để thực hiện kết nối và lấy token",
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 16,
          ),
          TextFieldWithBorder(
            labelText: "Số điện thoại",
            hintText: "Nhập số điện thoại",
            controller: controller.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Hãy nhập số điện thoại';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          PasswordTextField(
            labelText: "Mật khẩu",
            hintText: "Nhập mật khẩu",
            controller: controller.password,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Hãy nhập mật khẩu';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          TextFieldWithBorder(
            labelText: "Mã khách hàng",
            hintText: "Nhập mã khách hàng",
            controller: controller.customerCode,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Hãy nhập mã khách hàng';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          TextFieldWithBorder(
            labelText: "Mã hợp đồng",
            hintText: "Nhập mã hợp đồng",
            controller: controller.contractCode,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Hãy nhập mã hợp đồng';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget nhatTin() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.network(
            shipment.imageUrl ?? "",
            width: Get.width,
            height: 200,
            errorBuilder: (context, error, stackTrace) {
              return SahaEmptyImage();
            },
          ),
          Text(
            "Bạn cần đăng ký Nhất Tín tại đây https://ntlogistics.vn/  và cung cấp tài khoản của bạn ở đây để thực hiện kết nối và lấy token",
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 16,
          ),
          TextFieldWithBorder(
            labelText: "Số điện thoại",
            hintText: "Nhập số điện thoại",
            controller: controller.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Hãy nhập số điện thoại';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          PasswordTextField(
            labelText: "Mật khẩu",
            hintText: "Nhập mật khẩu",
            controller: controller.password,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Hãy nhập mật khẩu';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          TextFieldWithBorder(
            labelText: "Mã đối tác",
            hintText: "Nhập mã đối tác",
            controller: controller.partnerId,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Hãy nhập mã đối tác';
              }
              return null;
            },
          ),
        
        ],
      ),
    );
  }
}
