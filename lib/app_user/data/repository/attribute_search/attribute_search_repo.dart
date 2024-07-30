import 'package:sahashop_customer/app_customer/model/attribute_search.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/attribute_search/attribute_search_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/attribute_search/list_attribute_search_res.dart';

import '../../../utils/user_info.dart';
import '../../remote/saha_service_manager.dart';
import '../handle_error.dart';

class AttributeSearchRepo {
  Future<AttributeSearch?> createAttributeSearchChild(
      int attributeSearchId, String? name, String? image) async {
    try {
      var res = await SahaServiceManager().service!.createAttributeSearchChild(
        UserInfo().getCurrentStoreCode(),
        attributeSearchId,
        {"name": name, "image_url": image},
      );
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AttributeSearch?> updateAttributeSearchChild(int? attributeSearchId,
      int? attributeSearchChildId, String? name, String? image) async {
    try {
      var res = await SahaServiceManager().service!.updateAttributeSearchChild(
        UserInfo().getCurrentStoreCode(),
        attributeSearchId,
        attributeSearchChildId,
        {"name": name, "image_url": image},
      );
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<bool> deleteAttributeSearchChild(
    int? attributeSearchId,
    int? attributeSearchChildId,
  ) async {
    try {
      var res = await SahaServiceManager().service!.deleteAttributeSearchChild(
          UserInfo().getCurrentStoreCode(),
          attributeSearchId,
          attributeSearchChildId);
      return true;
    } catch (err) {
      handleError(err);
      return false;
    }
  }

  Future<AttributeSearch?> createAttributeSearch(
      String? name, String? imageUrl) async {
    try {
      var res = await SahaServiceManager().service!.createAttributeSearch(
        UserInfo().getCurrentStoreCode(),
        {
          "name": name,
          "image_url": imageUrl,
        },
      );
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AttributeSearch?> updateAttributeSearch(
      int attributeSearchId, String? name, String? imageUrl) async {
    try {
      var res = await SahaServiceManager().service!.updateAttributeSearch(
        UserInfo().getCurrentStoreCode(),
        attributeSearchId,
        {
          "name": name,
          "image_url": imageUrl,
        },
      );
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ListAttributeSearchRes?> getAttributeSearch() async {
    try {
      var res = await SahaServiceManager().service!.getAttributeSearch(
            UserInfo().getCurrentStoreCode(),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<bool?> sortAttributeSearch(List<int> ids, List<int> positions) async {
    try {
      var res = await SahaServiceManager().service!.sortAttributeSearch(
          UserInfo().getCurrentStoreCode(),
          {"ids": ids, "positions": positions});
      return true;
    } catch (err) {
      handleError(err);
    }
  }

  Future<bool> deleteAttributeSearch(int attributeId) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deleteAttributeSearch(UserInfo().getCurrentStoreCode(), attributeId);
      return true;
    } catch (err) {
      handleError(err);
      return false;
    }
  }

  Future<bool> deleteAttributeChild(
    int? attributeId,
    int? attributeChildId,
  ) async {
    try {
      var res = await SahaServiceManager().service!.deleteAttributeChild(
          UserInfo().getCurrentStoreCode(), attributeId, attributeChildId);
      return true;
    } catch (err) {
      handleError(err);
      return false;
    }
  }
}
