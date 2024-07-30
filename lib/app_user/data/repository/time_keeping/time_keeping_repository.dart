import 'package:com.ikitech.store/app_user/data/remote/response-request/success/success_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/time_keeping/all_approve_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/time_keeping/all_checkin_location_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/time_keeping/all_device_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/time_keeping/bonus_time_keeping_req.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/time_keeping/calendar_shifts_request.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/time_keeping/calendar_shifts_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/time_keeping/checkin_checkout_request.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/time_keeping/checkin_location_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/time_keeping/device_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/time_keeping/list_shifts_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/time_keeping/put_one_calendar_shifts_request.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/time_keeping/shifts_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/time_keeping/time_keeping_calculate_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/time_keeping/time_keeping_today_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/model/checkin_location.dart';
import 'package:com.ikitech.store/app_user/model/device.dart';
import 'package:com.ikitech.store/app_user/model/shifts.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';

import '../handle_error.dart';

class TimeKeepingRepository {
  Future<TimeKeepingCalculateRes?> getTimeKeepingCalculate({
    DateTime? dateFrom,
    DateTime? dateTo,
  }) async {
    try {
      var res = await SahaServiceManager().service!.getTimeKeepingCalculate(
        UserInfo().getCurrentStoreCode(),
        UserInfo().getCurrentIdBranch(),
        dateFrom == null ? null : dateFrom.toIso8601String(),
        dateTo == null ? null : dateTo.toIso8601String(),
      );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ListShiftsRes?> getListShifts({int? page}) async {
    try {
      var res = await SahaServiceManager().service!.getListShifts(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          page);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ShiftsRes?> addShift({required Shifts shifts}) async {
    try {
      var res = await SahaServiceManager().service!.addShift(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          shifts.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ShiftsRes?> updateShifts(
      {required Shifts shifts, required int shiftsId}) async {
    try {
      var res = await SahaServiceManager().service!.updateShifts(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          shiftsId,
          shifts.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> deleteShifts({required int shiftsId}) async {
    try {
      var res = await SahaServiceManager().service!.deleteShifts(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          shiftsId);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CalendarShiftsRes?> getCalendarShifts({
    DateTime? dateFrom,
    DateTime? dateTo,
  }) async {
    try {
      var res = await SahaServiceManager().service!.getCalendarShifts(
        UserInfo().getCurrentStoreCode(),
        UserInfo().getCurrentIdBranch(),
        dateFrom == null ? null : dateFrom.toIso8601String(),
        dateTo == null ? null : dateTo.toIso8601String(),
      );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> addCalendarShifts(
      {required CalendarShiftsRequest calendarShiftsRequest}) async {
    try {
      var res = await SahaServiceManager().service!.addCalendarShifts(
        UserInfo().getCurrentStoreCode(),
        UserInfo().getCurrentIdBranch(),
        calendarShiftsRequest.toJson(),
      );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> addCalendarShiftsPutOne(
      {required PutOneCalendarShiftsRequest
      putOneCalendarShiftsRequest}) async {
    try {
      var res = await SahaServiceManager().service!.addCalendarShiftsPutOne(
        UserInfo().getCurrentStoreCode(),
        UserInfo().getCurrentIdBranch(),
        putOneCalendarShiftsRequest.toJson(),
      );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CheckInLocationRes?> updateCheckInLocation(
      {required int checkInLocationId,
        required CheckInLocation checkInLocation}) async {
    try {
      var res = await SahaServiceManager().service!.updateCheckInLocation(
        UserInfo().getCurrentStoreCode(),
        UserInfo().getCurrentIdBranch(),
        checkInLocationId,
        checkInLocation.toJson(),
      );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> deleteCheckInLocation(
      {required int checkInLocationId}) async {
    try {
      var res = await SahaServiceManager().service!.deleteCheckInLocation(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          checkInLocationId);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CheckInLocationRes?> addCheckInLocation(
      {required CheckInLocation checkInLocation}) async {
    try {
      var res = await SahaServiceManager().service!.addCheckInLocation(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          checkInLocation.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllCheckInLocationRes?> getCheckInLocation({int? page}) async {
    try {
      var res = await SahaServiceManager().service!.getCheckInLocation(
        UserInfo().getCurrentStoreCode(),
        UserInfo().getCurrentIdBranch(),
      );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<TimeKeepingToDayRes?> getTimeKeepingToday() async {
    try {
      var res = await SahaServiceManager().service!.getTimeKeepingToday(
        UserInfo().getCurrentStoreCode(),
        UserInfo().getCurrentIdBranch(),
      );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<TimeKeepingToDayRes?> checkInCheckOut(
      {required CheckInCheckOutRequest checkInCheckOutRequest}) async {
    try {
      var res = await SahaServiceManager().service!.checkInCheckOut(
        UserInfo().getCurrentStoreCode(),
        UserInfo().getCurrentIdBranch(),
        checkInCheckOutRequest.toJson(),
      );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllDeviceRes?> getAllDevice() async {
    try {
      var res = await SahaServiceManager().service!.getAllDevice(
        UserInfo().getCurrentStoreCode(),
        UserInfo().getCurrentIdBranch(),
      );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<DeviceRes?> addDevice({required Device device}) async {
    try {
      var res = await SahaServiceManager().service!.addDevice(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          device.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<DeviceRes?> updateDevice(
      {required int deviceId, required Device device}) async {
    try {
      var res = await SahaServiceManager().service!.updateDevice(
        UserInfo().getCurrentStoreCode(),
        UserInfo().getCurrentIdBranch(),
        deviceId,
        device.toJson(),
      );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> deleteDevice({required int deviceId}) async {
    try {
      var res = await SahaServiceManager().service!.deleteDevice(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          deviceId);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllDeviceRes?> getAllDeviceAwait() async {
    try {
      var res = await SahaServiceManager().service!.getAllDeviceAwait(
        UserInfo().getCurrentStoreCode(),
        UserInfo().getCurrentIdBranch(),
      );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllDeviceRes?> getAllDeviceApproveStaff({required int staffId}) async {
    try {
      var res = await SahaServiceManager().service!.getAllDeviceApproveStaff(
        UserInfo().getCurrentStoreCode(),
        UserInfo().getCurrentIdBranch(),
        staffId,
      );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> changeStatusDevice(
      {required int deviceId, required int status}) async {
    try {
      var res = await SahaServiceManager().service!.changeStatusDevice(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          deviceId, {
        "status": status,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllApproveDeviceRes?> getAllAwaitCheckInOutsAwait({int? page}) async {
    try {
      var res = await SahaServiceManager().service!.getAllAwaitCheckInOutsAwait(
        UserInfo().getCurrentStoreCode(),
        UserInfo().getCurrentIdBranch(),
        page,
      );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> changeStatusApprove(
      {required int deviceId, required int status}) async {
    try {
      var res = await SahaServiceManager().service!.changeStatusApprove(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          deviceId, {
        "status": status,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> bonusCheckInOut(
      {required BonusTimeKeepingReq bonusTimeKeepingReq}) async {
    try {
      var res = await SahaServiceManager().service!.bonusCheckInOut(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          bonusTimeKeepingReq.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
