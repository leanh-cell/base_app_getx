import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import '../../../model/agency_type.dart';
import 'list_agency_type_controller.dart';
import 'product_agency/product_agency_screen.dart';

class ListAgencyTypeScreen extends StatefulWidget {
  @override
  _ListAgencyTypeScreenState createState() => _ListAgencyTypeScreenState();
}

class _ListAgencyTypeScreenState extends State<ListAgencyTypeScreen> {
  ListAgencyController listAgencyController = ListAgencyController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách cấp đại lý"),
        actions: [
          IconButton(
              onPressed: () {
                SahaDialogApp.showDialogInputText(
                    title: "Thêm cấp đại lý",
                    des: "VD: Đại lý 1,...",
                    textButton: "Thêm",
                    onDone: (name) {
                      listAgencyController.addAgencyType(name);
                      Get.back();
                    });
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: listAgencyController.listAgencyType.length,
          itemBuilder: (context, index) {
            var agencyType = listAgencyController.listAgencyType[index];
            return itemAgencyType(
              agencyType: agencyType,
              indexEdit: index,
            );
          },
        ),
      ),
    );
  }

  Widget itemAgencyType({required AgencyType agencyType, required indexEdit}) {
    TextEditingController nameEditingController =
        TextEditingController(text: agencyType.name);
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              listAgencyController.editIndex.value != indexEdit
                  ? Expanded(child: Text(agencyType.name ?? ""))
                  : Expanded(
                      child: TextFormField(
                        autofocus: true,
                        controller: nameEditingController,
                        validator: (value) {
                          if (value!.length < 1) {
                            return 'Chưa nhập tên chương trình';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: "Nhập tên chương trình khuyến mãi tại đây",
                        ),
                        style: TextStyle(fontSize: 14),
                        minLines: 1,
                        maxLines: 1,
                      ),
                    ),
              if (listAgencyController.editIndex.value == indexEdit)
                IconButton(
                    onPressed: () {
                      listAgencyController.updateAgencyType(
                          agencyType.id ?? 0, nameEditingController.text);
                    },
                    icon: Icon(
                      Icons.done,
                      color: listAgencyController.editIndex.value == indexEdit
                          ? Colors.green
                          : Colors.grey,
                    )),
              IconButton(
                  onPressed: () {
                    if (listAgencyController.editIndex.value == indexEdit) {
                      listAgencyController.editIndex.value = 9999;
                    } else {
                      listAgencyController.editIndex.value = indexEdit;
                    }
                  },
                  icon: Icon(
                    Icons.edit,
                    color: listAgencyController.editIndex.value == indexEdit
                        ? Colors.blueAccent
                        : Colors.grey,
                  )),
              IconButton(
                  onPressed: () {
                    SahaDialogApp.showDialogYesNo(
                        mess: "Bạn chắc chắn muốn xoá cấp đại lý này chứ ?",
                        onOK: () {
                          listAgencyController
                              .deleteAgencyType(agencyType.id ?? 0);
                        });
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
            ],
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => ProductAgencyScreen(
                    agencyTypeRequest: agencyType,
                      ));
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      "Cấu hình sản phẩm",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
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
}
