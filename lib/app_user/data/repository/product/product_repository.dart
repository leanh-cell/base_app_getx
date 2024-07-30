import 'package:com.ikitech.store/app_user/data/remote/response-request/product/all_product_ecommerce_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/product/all_product_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/product/create_many_product_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/product/product_request.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/product/product_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/product/product_scan_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/success/success_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

import '../handle_error.dart';

class ProductRepository {
  Future<Product?> setUpAttributeSearchProduct(
      int productId, List<int> attributeSearchChild) async {
    try {
      var res = await SahaServiceManager().service!.setUpAttributeSearchProduct(
          UserInfo().getCurrentStoreCode(), productId, {
        "list_attribute_search_childs": attributeSearchChild == null
            ? []
            : List<dynamic>.from(attributeSearchChild.map((x) => x)),
      });
      return res.data;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<bool?> delete(int idProduct) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deleteProduct(UserInfo().getCurrentStoreCode(), idProduct);
      return res.data!.idDeleted == idProduct;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<bool?> deleteMany(List<int> listIds) async {
    try {
      var res = await SahaServiceManager().service!.deleteManyProduct(
          UserInfo().getCurrentStoreCode(), {'list_id': listIds});
      return true;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<Product?> create(ProductRequest productRequest) async {
    try {
      var res = await SahaServiceManager().service!.createProduct(
          UserInfo().getCurrentStoreCode(), productRequest.toJson());
      return res.data;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<Product?> createV2(ProductRequest productRequest) async {
    try {
      var res = await SahaServiceManager().service!.createProductV2(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          productRequest.toJson());
      return res.data;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<Product?> update(int idProduct, ProductRequest productRequest) async {
    try {
      var res = await SahaServiceManager().service!.updateProduct(
          UserInfo().getCurrentStoreCode(), idProduct, productRequest.toJson());
      return res.data;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AllProductEcommerceRes?> getEcommerceProduct(
      {String? shopID, String? provider, int? page}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getEcommerceProduct(UserInfo().getCurrentStoreCode(), {
        "page": page,
        "choose_suppliers": provider,
        "shop_id": shopID,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<List<Product>?> searchProduct(
      {String search = "",
      int page = 1,
      String idCategory = "",
      String idCategoryChild = "",
      bool descending = false,
      String details = "",
      String sortBy = ""}) async {
    try {
      var res = await SahaServiceManager().service!.searchProduct(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          page,
          search,
          idCategory,
          idCategoryChild,
          descending,
          details,
          sortBy);
      return res.data!.data;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<CreateManyProductsRes?> postManyProduct(
      {List<ProductRequest>? listProductRequest,
      bool? allowSkipSameName}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .postManyProduct(UserInfo().getCurrentStoreCode(), {
        "allow_skip_same_name": allowSkipSameName ?? true,
        "list": listProductRequest!.map((e) => e.toJson()).toList(),
      });
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<DataPageProduct?> getAllProduct({
    String? search,
    String? idCategory,
    bool? descending,
    String? status,
    String? filterBy,
    String? filterOption,
    String? filterByValue,
    String? details,
    String? sortBy,
    String? categoryChildrenIds,
    int? page,
    int? agencyTypeId,
  }) async {
    try {
      var res = await SahaServiceManager().service!.getAllProduct(
            UserInfo().getCurrentStoreCode(),
            search ?? "",
            idCategory ?? "",
            categoryChildrenIds,
            descending ,
            status ,
            filterBy ,
            filterOption ,
            filterByValue ,
            details ,
            sortBy ,
            page ?? 1,
            agencyTypeId,
          );

 

      return res.data;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<DataPageProduct?> getAllProductV2({
    String? search,
    String? idCategory,
    String? categoryChildrenIds,
    int? branchId,
    bool? descending,
    bool? isNearOutOfStock,
    String? status,
    String? filterBy,
    String? filterOption,
    String? filterByValue,
    String? details,
    String? sortBy,
    bool? checkInventory,
    int? page,
    int? agencyTypeId,
  }) async {
    try {
      var res = await SahaServiceManager().service!.getAllProductV2(
            UserInfo().getCurrentStoreCode(),
            branchId ?? UserInfo().getCurrentIdBranch(),
            search,
            idCategory,
            categoryChildrenIds,
            descending ?? false,
            isNearOutOfStock,
            status,
            filterBy,
            filterOption,
            filterByValue,
            details,
            sortBy,
            checkInventory,
            page ?? 1,
            agencyTypeId,
          );

      print(res.data!.data);

      return res.data;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ProductResponse?> getOneProduct(int idProduct) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getOneProduct(UserInfo().getCurrentStoreCode(), idProduct);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ProductResponse?> getOneProductV2(int idProduct) async {
    try {
      var res = await SahaServiceManager().service!.getOneProductV2(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          idProduct);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> collaboratorProducts(
      {required int percentCollaborator}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .collaboratorProducts(UserInfo().getCurrentStoreCode()!, {
        'percent_collaborator': percentCollaborator,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ProductScanResponse?> scanProductHome(String barcode) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .scanProduct(UserInfo().getCurrentStoreCode(), {"barcode": barcode});
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AllProductResponse?> scanProduct(String barcode) async {
    try {
      var res = await SahaServiceManager().service!.getAllProductV2(
            UserInfo().getCurrentStoreCode(),
            UserInfo().getCurrentIdBranch(),
            barcode,
            null,
            null,
            false,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            1,
            null,
          );

      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }
}
