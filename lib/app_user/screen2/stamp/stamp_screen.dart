// import 'package:barcode_widget/barcode_widget.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
// import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
// import 'package:com.ikitech.store/app_user/components/saha_user/popup/popup_keyboard.dart';
// import 'package:com.ikitech.store/app_user/model/stamp.dart';
// import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
// import 'package:com.ikitech.store/app_user/utils/user_info.dart';
// import 'package:sahashop_customer/app_customer/model/product.dart';
// import 'search_stamp/search_stamp_screen.dart';
// import 'stamp_controller.dart';

// class StampScreen extends StatelessWidget {
//   Product? productInput;

//   StampScreen({this.productInput}) {
//     stampController = StampController(productInput: productInput);
//   }

//   late StampController stampController;

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       appBar: AppBar(
//         title: InkWell(
//           onTap: () {
//             Get.to(
//               () => SearchStampScreen(
//                 listStamp: stampController.listStamp.toList(),
//                 onChoose: (List<Stamp> listStamp) {
//                   Get.back();
//                   stampController.listStamp(listStamp);
//                 },
//               ),
//             );
//           },
//           child: Container(
//             padding: EdgeInsets.only(left: 10),
//             decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(5)),
//             child: TextFormField(
//               enabled: false,
//               decoration: InputDecoration(
//                 isDense: true,
//                 contentPadding:
//                     EdgeInsets.only(left: 0, right: 15, top: 15, bottom: 0),
//                 border: InputBorder.none,
//                 hintText: "Nhập tên, barcode",
//                 hintStyle: TextStyle(fontSize: 15),
//                 suffixIcon: IconButton(
//                   onPressed: () {},
//                   icon: Icon(Icons.qr_code),
//                 ),
//               ),
//               onChanged: (v) async {},
//               style: TextStyle(fontSize: 14),
//               minLines: 1,
//               maxLines: 1,
//             ),
//           ),
//         ),
//       ),
//       body: Obx(
//         () => SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               if (stampController.listStamp.isEmpty)
//                 InkWell(
//                   onTap: () {
//                     Get.to(
//                       () => SearchStampScreen(
//                         listStamp: stampController.listStamp.toList(),
//                         onChoose: (List<Stamp> listStamp) {
//                           Get.back();
//                           stampController.listStamp(listStamp);
//                         },
//                       ),
//                     );
//                   },
//                   child: Container(
//                     width: Get.width,
//                     color: Colors.white,
//                     padding: EdgeInsets.all(10),
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Icon(
//                           Icons.inventory_outlined,
//                           size: 100,
//                           color: Colors.grey,
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Text(
//                           "Phiếu kiểm hàng của bạn chưa có\nsản phẩm nào!",
//                           style: TextStyle(color: Colors.black54),
//                           textAlign: TextAlign.center,
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               if (stampController.listStamp.isNotEmpty)
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Text("Sản phẩm (${stampController.listStamp.length})"),
//                 ),
//               ...List.generate(
//                   stampController.listStamp.length,
//                   (index) =>
//                       stampItem(stampController.listStamp[index], index)),
//               SizedBox(
//                 height: 15,
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: Obx(
//         () => Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "    Mẫu tem in",
//               style: TextStyle(
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   flex: 2,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Row(
//                         children: [
//                           Checkbox(
//                               value: stampController.isNameProduct.value,
//                               onChanged: (v) {
//                                 stampController.isNameProduct.value =
//                                     !stampController.isNameProduct.value;
//                               }),
//                           Text("Tên sản phẩm")
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Checkbox(
//                               value: stampController.isCode.value,
//                               onChanged: (v) {
//                                 stampController.isCode.value =
//                                     !stampController.isCode.value;
//                               }),
//                           Text("Mã barcode")
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Checkbox(
//                               value: stampController.isPrice.value,
//                               onChanged: (v) {
//                                 stampController.isPrice.value =
//                                     !stampController.isPrice.value;
//                               }),
//                           Text("Giá bán")
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Checkbox(
//                               value: stampController.isVnd.value,
//                               onChanged: (v) {
//                                 stampController.isVnd.value =
//                                     !stampController.isVnd.value;
//                               }),
//                           Text("Đơn vị tiền")
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Checkbox(
//                               value: stampController.isNameStore.value,
//                               onChanged: (v) {
//                                 stampController.isNameStore.value =
//                                     !stampController.isNameStore.value;
//                               }),
//                           Text("Tên cửa hàng")
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   flex: 3,
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         DottedBorder(
//                           color: Colors.black,
//                           strokeWidth: 0.2,
//                           padding: EdgeInsets.all(20),
//                           child: Column(
//                             children: [
//                               if (stampController.isNameStore.value)
//                                 Text(
//                                   "${UserInfo().getCurrentNameBranch() ?? ""}",
//                                   style: TextStyle(
//                                       fontSize: 9, fontWeight: FontWeight.w500),
//                                 ),
//                               if (stampController.isNameStore.value)
//                                 SizedBox(
//                                   height: 1,
//                                 ),
//                               if (stampController.isNameProduct.value)
//                                 Text(
//                                   "Ikitech is the best software",
//                                   style: TextStyle(fontSize: 9),
//                                 ),
//                               if (stampController.isNameProduct.value)
//                                 SizedBox(
//                                   height: 2,
//                                 ),
//                               BarcodeWidget(
//                                 barcode: Barcode
//                                     .code128(), // Barcode type and settings
//                                 data: 'hieudeptrai',
//                                 drawText: false,
//                                 height: 40,
//                               ),
//                               if (stampController.isCode.value)
//                                 Text(
//                                   "IKINO1",
//                                   style: TextStyle(fontSize: 9),
//                                 ),
//                               if (stampController.isPrice.value)
//                                 Text(
//                                   "${SahaStringUtils().convertToMoney(1100000)} ${stampController.isVnd.value ? "VNĐ" : ""}",
//                                   style: TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 SizedBox(
//                   width: 30,
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [Text("aaaaa"), Divider()],
//                   ),
//                 ),
//               ],
//             ),
//             SahaButtonFullParent(
//               text: "Tổng ${stampController.listStamp.length}",
//               onPressed: () {
//                 stampController.printBill('192.168.1.230');
//               },
//               color: Theme.of(context).primaryColor,
//             ),
//             SizedBox(
//               height: 20,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget stampItem(Stamp stamp, int index) {
//     return Column(
//       children: [
//         InkWell(
//           onTap: () {},
//           child: Container(
//             padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 5),
//             color: Colors.white,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Spacer(),
//                     InkWell(
//                       onTap: () {
//                         SahaDialogApp.showDialogYesNo(
//                             mess:
//                                 "Bạn có chắc muốn xoá sản phẩm này ra khỏi danh sách in không?",
//                             onOK: () {
//                               stampController.deleteStamp(index);
//                             });
//                       },
//                       child: Icon(
//                         Icons.clear,
//                         size: 18,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         "${stamp.nameProduct ?? ""} ${stamp.elementDistributeName != null ? "- PL:" : ""} ${stamp.elementDistributeName ?? ""}${stamp.subElementDistributeName == null ? "" : ","} ${stamp.subElementDistributeName == null ? "" : stamp.subElementDistributeName}",
//                         maxLines: 1,
//                       ),
//                     ),
//                     Spacer(),
//                     IconButton(
//                       onPressed: () {
//                         stampController.decreaseStamp(index);
//                       },
//                       icon: Icon(
//                         Icons.remove,
//                         color: Theme.of(Get.context!).primaryColor,
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {
//                         PopupKeyboard().showDialogInputKeyboard(
//                             numberInput: "${stamp.quantity ?? 0}",
//                             title: "Số lượng tem in",
//                             confirm: (number) {
//                               stampController.updateQuantityStamp(
//                                   index, (number as double).round());
//                             });
//                       },
//                       child: Container(
//                         width: 60,
//                         padding: EdgeInsets.all(5),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             border: Border.all(color: Colors.grey[300]!)),
//                         child: Center(
//                           child: Text(
//                             "${stamp.quantity ?? 0}",
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(fontSize: 16),
//                           ),
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         stampController.increaseStamp(index);
//                       },
//                       icon: Icon(
//                         Icons.add,
//                         color: Theme.of(Get.context!).primaryColor,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Text("Barcode: ${stamp.barcode ?? ""}"),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                     "${SahaStringUtils().convertToMoney(stampController.priceType.value == 0 ? (stamp.price ?? 0) : stampController.priceType.value == 1 ? (stamp.priceImport ?? 0) : (stamp.priceCapital ?? 0))}₫"),
//               ],
//             ),
//           ),
//         ),
//         Divider(
//           height: 1,
//         )
//       ],
//     );
//   }
// }
