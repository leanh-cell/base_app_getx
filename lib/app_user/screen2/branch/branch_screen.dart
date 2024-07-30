import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/model/branch.dart';
import '../../../saha_data_controller.dart';
import 'branch_controller.dart';
import 'new_address_store_screen/new_branch_screen.dart';

class BranchScreen extends StatelessWidget {
  BranchController branchController = BranchController();
  SahaDataController sahaDataController = Get.find();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi nhánh"),
      ),
      body: Obx(
        () => ListView(
          children:
              branchController.listBranch.map((e) => itemStore(e)).toList(),
        ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        color: Colors.white,
        child: Column(
          children: [
            SahaButtonFullParent(
              text: "Tạo chi nhánh",
              onPressed: () {
                Get.to(() => NewStoreStoreScreen())!.then((value) {
                  if (value == "success") {
                    branchController.getAllBranch();
                  }
                });
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget itemStore(Branch branch) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          ListTile(
            leading: Icon(
              Icons.store,
              size: 50,
              color: Theme.of(Get.context!).primaryColor,
            ),
            title: Text(branch.name ?? ""),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "${branch.addressDetail ?? ""}${branch.addressDetail == null ? "" : ","} ${branch.wardsName ?? ""}${branch.wardsName == null ? "" : ","} ${branch.districtName ?? ""}${branch.districtName == null ? "" : ","} ${branch.provinceName ?? ""}"),
                if (branch.isDefaultOrderOnline == true)
                  SizedBox(
                    height: 10,
                  ),
                if (branch.isDefaultOrderOnline == true)
                  Text(
                    "Chi nhánh mặc định nhận hàng online",
                    style: TextStyle(color: Colors.red),
                  )
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: buildItemOption(
                    title: "Xem",
                    onTap: () {
                      Get.to(() => NewStoreStoreScreen(
                                branchInput: branch,
                                isWatch: true,
                              ))!
                          .then((value) {
                        branchController.getAllBranch();
                      });
                    }),
              ),
              Expanded(
                child: buildItemOption(
                    title: "Sửa",
                    onTap: () {
                      Get.to(() => NewStoreStoreScreen(
                                branchInput: branch,
                              ))!
                          .then((value) {
                        branchController.getAllBranch();
                      });
                    }),
              ),
              Expanded(
                child: buildItemOption(
                    title: "Xoá",
                    onTap: () {
                      SahaDialogApp.showDialogYesNo(
                          mess: "Bạn có chắc muốn xoá chi nhánh này chứ ?",
                          onOK: () {
                            if (branchController.listBranch.length > 1) {
                              branchController.deleteBranch(branch.id ?? 0);
                            } else {
                              SahaAlert.showError(
                                  message: "Chi nhánh không thể trống");
                            }
                          });
                    }),
              ),
            ],
          ),
          Divider(
            height: 1,
          ),
        ],
      ),
    );
  }

  Widget buildItemOption({required String title, Function? onTap}) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.only(right: 8, left: 8, bottom: 5, top: 5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(3))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [Text(title)],
            )
          ],
        ),
      ),
    );
  }
}
