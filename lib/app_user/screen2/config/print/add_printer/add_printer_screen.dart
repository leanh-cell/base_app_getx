import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/model/printer.dart';

import 'add_printer_controller.dart';

class AddPrinterScreen extends StatefulWidget {
  Printer? printer;
  int? indexPrint;
  @override
  State<AddPrinterScreen> createState() => _AddPrinterScreenState();

  AddPrinterScreen({this.printer, this.indexPrint});
}

class _AddPrinterScreenState extends State<AddPrinterScreen> {
  late AddPrinterController addPrinterController;

  @override
  void initState() {
    addPrinterController = AddPrinterController(
        printerInput: widget.printer, indexPrinter: widget.indexPrint);
    if (widget.printer != null) {
      addPrinterController.nameTextEditingController.text =
          widget.printer?.name ?? "";
      addPrinterController.ipTextEditingController.text =
          widget.printer?.ipPrinter ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${widget.printer != null ? "Chỉnh sửa máy in" : "Thêm máy in"}"),
        actions: [
          TextButton(
              onPressed: () {
                addPrinterController.addPrinter();
              },
              child: Text(
                "Lưu",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      decoration: InputDecoration(hintText: "Tên máy"),
                      controller: addPrinterController.nameTextEditingController,
                      onChanged: (v) {
                        addPrinterController.printerSave.value.name = v;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Kiểu máy"),
                    DropdownButton<String>(
                      value: addPrinterController.typePrinter,
                      hint: Text("Ethernet"),
                      items: <String>[
                        'Ethernet',
                        'Bluetooth',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (v) {
                        setState(() {
                          addPrinterController.typePrinter = v;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: Get.width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: "Địa chỉ IP của máy in"),
                              controller:
                                  addPrinterController.ipTextEditingController,
                              onChanged: (v) {
                                addPrinterController.printerSave.value.ipPrinter =
                                    v;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              addPrinterController.searchingDevice();
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                              ),
                              child: Center(
                                child: Text(
                                  "TÌM KIẾM",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("In hoá đơn: "),
                    Obx(
                      () => CupertinoSwitch(
                        value:
                            addPrinterController.printerSave.value.print ?? false,
                        onChanged: (bool value) async {
                          addPrinterController.printerSave.value.print =
                              !(addPrinterController.printerSave.value.print ??
                                  false);
                          if (addPrinterController.printerSave.value.print ==
                              false) {
                            addPrinterController.printerSave.value.autoPrint =
                                false;
                          }
                          addPrinterController.printerSave.refresh();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              if (addPrinterController.printerSave.value.print == true)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tự động in hoá đơn: "),
                      Obx(
                        () => CupertinoSwitch(
                          value:
                              addPrinterController.printerSave.value.autoPrint ??
                                  false,
                          onChanged: (bool value) async {
                            addPrinterController.printerSave.value.autoPrint =
                                !(addPrinterController
                                        .printerSave.value.autoPrint ??
                                    false);
                            addPrinterController.printerSave.refresh();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              if (addPrinterController.printerSave.value.print == true)
                Divider(
                  height: 1,
                ),
              InkWell(
                onTap: () {
                  addPrinterController.printBill();
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.print,
                        color: Colors.black54,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("IN KIỂM TRA")
                    ],
                  ),
                ),
              ),
              Divider(
                height: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
