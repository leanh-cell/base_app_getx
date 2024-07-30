import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_shimmer.dart';
import 'package:com.ikitech.store/app_user/model/info_address.dart';
import 'package:com.ikitech.store/app_user/screen2/config_store_address/config_address_screen/config_address_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/config_store_address/new_address_store_screen/new_address_screen.dart';
import '../../../../saha_data_controller.dart';
import 'all_address_store_controller.dart';

class AllAddressStoreScreen extends StatelessWidget {
  bool isChoose = true;
  AllAddressStoreController allAddressStoreController =
      new AllAddressStoreController();
  SahaDataController sahaDataController = Get.find();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Chọn địa chỉ nhận hàng"),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => SahaSimmer(
            isLoading: allAddressStoreController.isLoadingAddress.value,
            child: Column(
              children: [
                ...List.generate(
                    allAddressStoreController.listAddressStore.length,
                    (index) => addressSave(context,
                        allAddressStoreController.listAddressStore[index])),
                InkWell(
                  onTap: () {
                    Get.to(() => NewAddressStoreScreen())!.then((value) {
                      if (value["add"] == true) {
                        allAddressStoreController.refreshData();
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Thêm địa chỉ mới"),
                        Icon(Icons.add),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 8,
                  color: Colors.grey[200],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 35,
        color: Colors.white,
      ),
    );
  }

  Widget addressSave(BuildContext context, InfoAddress infoAddress) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            // payController.infoAddress.value = infoAddress;
            //Get.back();
            Get.to(() => ConfigAddressStoreScreen(
              infoAddress: infoAddress,
            ))!
                .then((value) => {allAddressStoreController.refreshData()});
          },
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${infoAddress.name ?? "Chưa có tên"}",
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "${infoAddress.phone ?? "Không có số điện thoại"}",
                      style: TextStyle(color: Colors.grey[700], fontSize: 13),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "${infoAddress.addressDetail ?? "Chưa có địa chỉ chi tiết"}",
                      style: TextStyle(color: Colors.grey[700], fontSize: 13),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "${infoAddress.districtName ?? "Chưa có Quận/huyện"}",
                      style: TextStyle(color: Colors.grey[700], fontSize: 13),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "${infoAddress.wardsName ?? "Chưa có Phường/Xã"}",
                      style: TextStyle(color: Colors.grey[700], fontSize: 13),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "${infoAddress.provinceName ?? "Chưa có Tỉnh/Thành Phố"}",
                      style: TextStyle(color: Colors.grey[700], fontSize: 13),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    infoAddress.isDefaultReturn == true
                        ? Text(
                      "[Địa chỉ trả hàng]",
                      style: TextStyle(
                        color: isChoose
                            ? Theme.of(context).primaryColor
                            : Colors.grey[500],
                      ),
                    )
                        : Container(),
                    infoAddress.isDefaultPickup == true
                        ? Text(
                      "[Địa chỉ lấy hàng]",
                      style: TextStyle(
                        color: isChoose
                            ? Theme.of(context).primaryColor
                            : Colors.grey[500],
                      ),
                    )
                        : Container(),
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
          height: 8,
          color: Colors.grey[200],
        ),
      ],
    );
  }
}
