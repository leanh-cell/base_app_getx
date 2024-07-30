import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';

class ListBluetoothPrinterScreen extends StatefulWidget {
  ListBluetoothPrinterScreen({Key? key, required this.onChoose, this.device})
      : super(key: key);
  final Function onChoose;
  BluetoothDevice? device;
  @override
  State<ListBluetoothPrinterScreen> createState() =>
      _ListBluetoothPrinterScreenState();
}

class _ListBluetoothPrinterScreenState
    extends State<ListBluetoothPrinterScreen> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => initBluetooth());
  }

  Future<void> initBluetooth() async {
    bluetoothPrint.startScan(timeout: Duration(seconds: 30));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách máy in"),
        actions: [
          IconButton(onPressed: (){
             bluetoothPrint.startScan(timeout: Duration(seconds: 30));
          }, icon: Icon(Icons.refresh))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<List<BluetoothDevice>>(
              stream: bluetoothPrint.scanResults,
              initialData: [],
              builder: (c, snapshot) {
                return Column(
                    children: snapshot.data!.map((d) {
                  print("==> ${d.connected}");
                  return ListTile(
                    title: Text(d.name ?? ''),
                    subtitle: Text(d.address ?? ''),
                    onTap: () async {
                      setState(() {
                        widget.device = d;
                      });
                    },
                    trailing: widget.device != null &&
                            widget.device!.address == d.address
                        ? Icon(
                            Icons.check,
                            color: Colors.green,
                          )
                        : null,
                  );
                }).toList());
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 65,
        child: Column(
          children: [
            SahaButtonFullParent(
              text: "Xác nhận",
              onPressed: () async {
                if (widget.device == null) {
                  SahaAlert.showError(message: "Bạn chưa chọn máy in nào");
                  return;
                }

                
                widget.onChoose(widget.device);
                Get.back();
              },
            )
          ],
        ),
      ),
    );
  }
}
