import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';

import 'package:com.ikitech.store/app_user/screen2/config/print_bluetooth/print_bluetooth_controller.dart';
import 'package:com.ikitech.store/saha_data_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';



class PrintBluetoothScreen extends StatefulWidget {
  PrintBluetoothScreen({Key? key, this.order}) : super(key: key) {
    controller = PrintBluetoothController(order: order);
  }
  final Order? order;
  late PrintBluetoothController controller;
  @override
  State<PrintBluetoothScreen> createState() => _PrintBluetoothScreenState();
}

class _PrintBluetoothScreenState extends State<PrintBluetoothScreen> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  SahaDataController sahaDataController = Get.find();
  @override
  void initState() {
    bluetoothPrint.startScan(timeout: Duration(seconds: 10));
    //sahaDataController.initStreamBluetooth();
    bluetoothPrint.state.listen((state) async {
      print('cur device status: $state');

      switch (state) {
        case BluetoothPrint.CONNECTED:
          sahaDataController.isConnected.value = true;
          print("Connect Success my love");
          
          ;

          break;
        case BluetoothPrint.DISCONNECTED:
          sahaDataController.isConnected.value = false;
          //await sahaDataController.bluetoothPrint.disconnect();
          print("Connect Fail my love");
          SahaAlert.showError(message: "Đã ngắt kết nối bluetooth");
          ;
          break;
        default:
          break;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kết nối máy in"),
        actions: [
          IconButton(
              onPressed: () {
                bluetoothPrint.startScan(timeout: Duration(seconds: 10));
              },
              icon: Icon(Icons.refresh))
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
                        if(sahaDataController.device != null && sahaDataController.isConnected == true && sahaDataController.device?.address != d.address){
                          sahaDataController.bluetoothPrint.disconnect();
                        }
                        sahaDataController.device = d;
                        sahaDataController.bluetoothPrint.connect(d);
                      },
                      trailing: Obx(() => sahaDataController.isConnected.value == false &&
                                  sahaDataController.device != null &&
                                  sahaDataController.device?.address ==
                                      d.address 
                                  
                              ? Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                )
                              : sahaDataController.isConnected.value ==
                                          true &&
                                      sahaDataController.device != null &&
                                      sahaDataController.device?.address ==
                                          d.address 
                                      
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    )
                                  : const SizedBox()));
                }).toList());
              },
            ),
          ],
        ),
      ),
 
    );
  }
}
