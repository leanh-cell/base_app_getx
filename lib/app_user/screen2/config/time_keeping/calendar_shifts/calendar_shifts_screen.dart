// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_expandable_table/flutter_expandable_table.dart';
// import 'package:get/get.dart';
// import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
// import 'package:com.ikitech.store/app_user/components/saha_user/popup/popup_input.dart';
// import 'package:com.ikitech.store/app_user/data/remote/response-request/time_keeping/calendar_shifts_res.dart';
// import 'package:com.ikitech.store/app_user/data/remote/response-request/time_keeping/put_one_calendar_shifts_request.dart';
// import 'package:com.ikitech.store/app_user/model/staff.dart';
// import 'package:com.ikitech.store/app_user/screen2/config/time_keeping/widget/calendar_time_keeping.dart';
// import 'package:com.ikitech.store/app_user/utils/date_utils.dart';

// import 'add_calendar_shifts/add_calendar_shifts_screen.dart';
// import 'calendar_shifts_controller.dart';

// class CalendarShiftsScreen extends StatelessWidget {
//   CalendarShiftsController cldController = CalendarShiftsController();

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Sắp xếp lịch làm việc"),
//       ),
//       body: Column(
//         children: [
//           CalendarTimeKeeping(
//             isAllPickDate: true,
//             onChange: (DateTime dateFrom, DateTime dateTo) {
//               cldController.dateFrom.value = dateFrom;
//               cldController.dateTo.value = dateTo;
//               cldController.getCalendarShifts();
//             },
//           ),
//           Expanded(
//             child: Obx(() => cldController.listCalendarShifts.isEmpty
//                 ? Center(
//                     child: Text(
//                     "Không có lịch nào được tạo",
//                     style: TextStyle(
//                       color: Theme.of(context).primaryColor,
//                     ),
//                   ))
//                 : _buildSimpleTable()),
//           ),
//         ],
//       ),
//       bottomNavigationBar: Container(
//           height: 65,
//           color: Colors.white,
//           child: Column(
//             children: [
//               SahaButtonFullParent(
//                   text: "Xếp ca",
//                   onPressed: () {
//                     Get.to(() => AddCalendarShiftsScreen())!.then((value) => {
//                           if (value == "reload")
//                             {cldController.getCalendarShifts()}
//                         });
//                   }),
//             ],
//           )),
//     );
//   }

//   ExpandableTable _buildSimpleTable() {
//     Widget staffInTime(
//         List<StaffInTime>? staffInTime, int rowIndex, int columnIndex) {
//       return InkWell(
//         onTap: () {
//           PopupInput().showDialogCalendarShifts(
//               shifts: cldController.listCalendarShifts[columnIndex].shifts!,
//               staffInTime: staffInTime![rowIndex],
//               confirm: (v) async {
//                 await cldController
//                     .addCalendarShiftsPutOne(PutOneCalendarShiftsRequest(
//                   date: v["date"],
//                   shiftId: v["shift_id"],
//                   listStaffId: (v["list_staff"] as List<Staff>)
//                       .map((e) => e.id!)
//                       .toList(),
//                 ));
//                 cldController.getCalendarShifts();
//               });
//         },
//         child: Container(
//           child: staffInTime != null && staffInTime.isNotEmpty
//               ? Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                       ...List.generate(
//                           staffInTime[rowIndex].staffWork!.length > 3
//                               ? 3
//                               : staffInTime[rowIndex].staffWork!.length,
//                           (index) => Text(
//                                 "${staffInTime[rowIndex].staffWork![index].name}",
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                               )),
//                       if (staffInTime[rowIndex].staffWork!.length > 3)
//                         Padding(
//                           padding: const EdgeInsets.only(top: 4.0),
//                           child: Row(
//                             children: [
//                               Spacer(),
//                               Text(
//                                 "...+${staffInTime[rowIndex].staffWork!.length - 3} Nhân viên",
//                                 style: TextStyle(color: Colors.grey, fontSize: 11),
//                               ),
//                             ],
//                           ),
//                         )
//                     ])
//               : Text(""),
//         ),
//       );
//     }

//     ExpandableTableHeader header = ExpandableTableHeader(
//       firstCell: Container(
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey[200]!, width: 0.5),
//           color: Colors.white,
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 'Lịch',
//                 style: TextStyle(fontSize: 11),
//               ),
//             ],
//           ),
//         ),
//       ),
//       children: List.generate(cldController.listCalendarShifts.length, (index) {
//         var shifts = cldController.listCalendarShifts[index].shifts;
//         return Container(
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey[200]!, width: 0.5),
//             color: Colors.white,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               if (shifts != null)
//                 Text(
//                   '${shifts.name ?? ""}',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               SizedBox(
//                 height: 5,
//               ),
//               if (shifts != null)
//                 Text(
//                   "${(shifts.startWorkHour ?? 0) < 10 ? "0${shifts.startWorkHour}" : shifts.startWorkHour}:${(shifts.startWorkMinute ?? 0) < 10 ? "0${shifts.startWorkMinute}" : shifts.startWorkMinute} - ${(shifts.endWorkHour ?? 0) < 10 ? "0${shifts.endWorkHour}" : shifts.endWorkHour}:${(shifts.endWorkMinute ?? 0) < 10 ? "0${shifts.endWorkMinute}" : shifts.endWorkMinute}",
//                   style: TextStyle(fontSize: 12, color: Colors.grey),
//                 ),
//             ],
//           ),
//         );
//       }),
//     );

//     List<ExpandableTableRow> rows = List.generate(
//       cldController.listDate.length,
//       (rowIndex) => ExpandableTableRow(
//         height: 80,
//         firstCell: Container(
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey[200]!, width: 0.5),
//             color: Colors.white,
//           ),
//           padding: EdgeInsets.all(5),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   '${SahaDateUtils().convertDateToWeekDate2(cldController.listDate[rowIndex])}',
//                   style: TextStyle(color: Colors.grey[600]),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Text(
//                   '${cldController.listDate[rowIndex].day}',
//                 ),
//               ],
//             ),
//           ),
//         ),
//         children: List<Widget>.generate(
//           cldController.listCalendarShifts.length,
//           (columnIndex) => Container(
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey[200]!, width: 0.5),
//               color: Colors.white,
//             ),
//             padding: EdgeInsets.all(5),
//             child: staffInTime(
//                 cldController.listCalendarShifts[columnIndex].staffInTime,
//                 rowIndex,
//                 columnIndex),
//           ),
//         ),
//       ),
//     );

//     return ExpandableTable(
//       rows: rows,
//       header: header,
//       firstColumnWidth: 50,
//       headerHeight: 50,
//       cellWidth: cldController.listCalendarShifts.length == 1
//           ? (Get.width - 51)
//           : cldController.listCalendarShifts.length == 2
//               ? (Get.width - 51) / 2
//               : cldController.listCalendarShifts.length >= 3
//                   ? (Get.width - 51) / 3
//                   : 0,

//     );
//   }
// }
