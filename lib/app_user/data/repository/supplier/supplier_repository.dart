import 'package:com.ikitech.store/app_user/data/remote/response-request/success/success_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/suppliers/all_suppliers_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/suppliers/create_supplier_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/suppliers/suppliers_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/model/supplier.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';

import '../handle_error.dart';

class SupplierRepository {
  Future<CreateSuppliersRes?> createSuppliers(Supplier supplier) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .createSuppliers(UserInfo().getCurrentStoreCode(), supplier.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CreateSuppliersRes?> updateSuppliers(
      Supplier supplier, int supplierId) async {
    try {
      var res = await SahaServiceManager().service!.updateSuppliers(
          UserInfo().getCurrentStoreCode(), supplierId, supplier.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllSuppliersRes?> getAllSuppliers({String? search, int? page}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllSuppliers(UserInfo().getCurrentStoreCode(), search, page);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SupplierRes?> getSupplier({int? idSupplier}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getSupplier(UserInfo().getCurrentStoreCode(), idSupplier);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> deleteSuppliers(int supplierId) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deleteSuppliers(UserInfo().getCurrentStoreCode(), supplierId);
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
