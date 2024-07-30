import 'package:com.ikitech.store/app_user/const/api.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/address/add_token_shipment_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/address/address_respone.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/address/all_address_store_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/address/all_shipment_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/address/create_address_store_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/address/delete_address_store_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/address/login_vietnam_post_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/address/login_viettel_post_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/agency/agency_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/agency/agency_type_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/agency/all_agency_register_request_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/attributes/attributes_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/auth/check_exists_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/auth/login_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/chat/all_chat_customer_reponse.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/chat/all_message_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/chat/send_message_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/config_noti/info_notification_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/config_ui/all_banner_ads_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/config_ui/banner_ads_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/ctv/all_collaborator_register_request_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/customer/all_customer_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/e_commerce/all_order_commerce_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/e_commerce/all_product_commerce_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/e_commerce/all_werehouses_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/e_commerce/e_commerce_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/e_commerce/e_commerces_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/e_commerce/order_commerce_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/e_commerce/product_commerce_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/e_commerce/sync_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/education/ada_lesson_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/education/add_chapter_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/education/chapter_lesson_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/education/course_list_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/education/course_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/guess_number_game/all_guess_number_game_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/guess_number_game/guess_number_game_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/import_stock/all_import_stock_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/bonus_product/bonus_product_item.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/combo/create_combo_reponse.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/combo/end_combo_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/combo/my_combo_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/delete_program_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/discount/create_discount_respone.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/discount/end_discount_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/discount/my_program_reponse.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/voucher/all_voucher_code_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/voucher/all_voucher_product_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/voucher/create_voucher_reponse.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/voucher/end_voucher_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/voucher/my_voucher_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/voucher/voucher_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/mini_game/all_mini_game-res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/mini_game/mini_game_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/notification/all_notification_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/order/all_order_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/order/change_order_status_repose.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/order/change_pay_success_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/order/refund_calculate_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/order/state_history_order_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/payment_method/all_payment_method_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/payment_method/payment_method_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/payment_method/update_payment_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/post/all_post_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/report/all_history_inventory_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/report/product_report_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/report/report_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/review_manage/all_review_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/review_manage/review_delete_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/review_manage/update_review_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/sale/all_history_check_in_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/sale/history_check_in_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/sale/sale_check_in_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/suppliers/all_suppliers_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/time_keeping/all_checkin_location_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/time_keeping/checkin_location_res.dart';
import 'package:com.ikitech.store/app_user/model/cart.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/address_customer/all_address_customer_response.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/attribute_search/attribute_search_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/attribute_search/list_attribute_search_res.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/score/history_score_response.dart';

import 'response-request/address/ship_config_res.dart';
import 'response-request/address/shipment_calculate_res.dart';
import 'response-request/agency/all_agency_type_res.dart';
import 'response-request/agency/all_bonus_level_agency_response.dart';
import 'response-request/agency/all_request_payment_agency_response.dart';
import 'response-request/agency/bonus_step_res.dart';
import 'response-request/agency/collaborator_configs_agency_response.dart';
import 'response-request/agency/import_bonus_step_res.dart';
import 'response-request/agency/list_agency_response.dart';
import 'response-request/agency/update_agency_response.dart';
import 'response-request/agency/update_bonus_level_agency_response.dart';
import 'response-request/agency/update_bonus_step_agency_res.dart';
import 'response-request/agency/update_price_agency_res.dart';
import 'response-request/auth/register_response.dart';
import 'response-request/badge/badge_user_response.dart';
import 'response-request/branch/all_branch_response.dart';
import 'response-request/branch/create_branch_response.dart';
import 'response-request/cart/all_cart_res.dart';
import 'response-request/cart/cart_res.dart';
import 'response-request/category/all_category_response.dart';
import 'response-request/category/create_category_response.dart';
import 'response-request/category/delete_category_response.dart';
import 'response-request/community/all_post_cmt_res.dart';
import 'response-request/community/comment_all_res.dart';
import 'response-request/community/post_cmt_res.dart';
import 'response-request/config_noti/all_schedule_noti_response.dart';
import 'response-request/config_noti/schedule_noti_response.dart';
import 'response-request/config_ui/app_theme_response.dart';
import 'response-request/config_ui/button_home_response.dart';
import 'response-request/config_ui/create_app_theme_response.dart';
import 'response-request/config_ui/layout_sort_response.dart';
import 'response-request/ctv/all_bonus_level_response.dart';
import 'response-request/ctv/all_request_payment_response.dart';
import 'response-request/ctv/collaborator_configs_response.dart';
import 'response-request/ctv/history_balance_res.dart';
import 'response-request/ctv/list_ctv_response.dart';
import 'response-request/ctv/update_bonus_level_response.dart';
import 'response-request/ctv/update_ctv_response.dart';
import 'response-request/customer/all_group_customer_res.dart';
import 'response-request/customer/group_customer_res.dart';
import 'response-request/customer/info_cus_res.dart';
import 'response-request/decentralization/add_decentralization_response.dart';
import 'response-request/decentralization/list_decentralization_response.dart';
import 'response-request/device_token/device_token_user_response.dart';
import 'response-request/distribute/distribute_res.dart';
import 'response-request/e_commerce/werehouse_res.dart';
import 'response-request/education/all_quiz_res.dart';
import 'response-request/education/question_res.dart';
import 'response-request/education/quiz_res.dart';
import 'response-request/general_setting/general_settings_res.dart';
import 'response-request/home_data/home_data_response.dart';
import 'response-request/image/upload_image_response.dart';
import 'response-request/import_stock/import_stock_res.dart';
import 'response-request/inventory/all_tally_sheet_res.dart';
import 'response-request/inventory/history_inventory_res.dart';
import 'response-request/inventory/tally_sheet_res.dart';
import 'response-request/marketing_chanel_response/bonus_product/all_bonus_product_res.dart';
import 'response-request/marketing_chanel_response/bonus_product/bonus_product_res.dart';
import 'response-request/marketing_chanel_response/bonus_product/end_bonus_product_res.dart';
import 'response-request/mini_game/all_gift_res.dart';
import 'response-request/mini_game/gift_res.dart';
import 'response-request/order/calculate_fee_order_res.dart';
import 'response-request/order/cancel_order_response.dart';
import 'response-request/order/history_shipper_response.dart';
import 'response-request/order/order_response.dart';
import 'response-request/order/payment_history_res.dart';
import 'response-request/order/state_history_order_customer_response.dart';
import 'response-request/piont/reward_pionts_response.dart';
import 'response-request/popup/list_popup_response.dart';
import 'response-request/popup/update_popup_response.dart';
import 'response-request/post/all_category_post_response.dart';
import 'response-request/post/create_category_post_response.dart';
import 'response-request/post/create_post_response.dart';
import 'response-request/post/delete_category_post_response.dart';
import 'response-request/post/delete_post_response.dart';
import 'response-request/post/pos_res.dart';
import 'response-request/post/update_category_post_response.dart';
import 'response-request/product/all_product_ecommerce_response.dart';
import 'response-request/product/all_product_response.dart';
import 'response-request/product/create_many_product_res.dart';
import 'response-request/product/product_delete_response.dart';
import 'response-request/product/product_response.dart';
import 'response-request/product/product_scan_response.dart';
import 'response-request/product/query_product_response.dart';
import 'response-request/profile/profile_response.dart';
import 'response-request/report/all_customer_debt_report_res.dart';
import 'response-request/report/all_product_IE_stock_res.dart';
import 'response-request/report/all_revenue_expenditure_report_res.dart';
import 'response-request/report/all_supplier_debt_report_res.dart';
import 'response-request/report/product_last_inventory_res.dart';
import 'response-request/report/profit_and_loss_res.dart';
import 'response-request/revenue_expenditure/all_revenue_expenditure_res.dart';
import 'response-request/revenue_expenditure/revenue_expenditure_res.dart';
import 'response-request/sale/config_sale_res.dart';
import 'response-request/sale/list_id_customer_staff_sale_top_res.dart';
import 'response-request/sale/over_view_sale_res.dart';
import 'response-request/sale/top_sale_res.dart';
import 'response-request/staff/add_staff_response.dart';
import 'response-request/staff/all_operation_history_res.dart';
import 'response-request/staff/all_staff_response.dart';
import 'response-request/store/all_store_response.dart';
import 'response-request/store/create_store_response.dart';
import 'response-request/store/type_store_respones.dart';
import 'response-request/success/success_response.dart';
import 'response-request/suppliers/create_supplier_res.dart';
import 'response-request/suppliers/suppliers_res.dart';
import 'response-request/time_keeping/all_approve_res.dart';
import 'response-request/time_keeping/all_device_res.dart';
import 'response-request/time_keeping/calendar_shifts_res.dart';
import 'response-request/time_keeping/device_res.dart';
import 'response-request/time_keeping/list_shifts_res.dart';
import 'response-request/time_keeping/shifts_res.dart';
import 'response-request/time_keeping/time_keeping_calculate_res.dart';
import 'response-request/time_keeping/time_keeping_today_res.dart';
import 'response-request/transfer_stock/all_transfer_stock_res.dart';
import 'response-request/transfer_stock/transfer_stock_res.dart';

part 'service.g.dart';

@RestApi(
  baseUrl: "$DOMAIN_API_CUSTOMER/api/",
)
abstract class SahaService {
  /// Retrofit factory
  factory SahaService(Dio dio, {String? baseUrl}) => _SahaService(dio,
      baseUrl: UserInfo().getIsRelease() == null
          ? "https://main.doapp.vn/api/"
          : "https://dev.doapp.vn/api/");

  @POST("register")
  Future<RegisterResponse> register(@Body() Map<String, dynamic> body);

  @POST("login")
  Future<LoginResponse> login(@Body() Map<String, dynamic> body);

  @POST("login/check_exists")
  Future<ExistsLoginResponse> checkExists(@Body() Map<String, dynamic> body);

  @POST("reset_password")
  Future<SuccessResponse> resetPassword(@Body() Map<String, dynamic> body);

  @POST("change_password")
  Future<SuccessResponse> changePassword(@Body() Map<String, dynamic> body);

  @GET("store")
  Future<AllStoreResponse> getAllStore();

  @POST("store")
  Future<CreateShopResponse> createStore(@Body() Map<String, dynamic> body);

  @PUT("store/{storeCode}")
  Future<CreateShopResponse> updateStore(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @GET("store/{storeCode}")
  Future<CreateShopResponse> getStore(@Path("storeCode") String? storeCode);

  /// app theme

  @POST("app-theme/{storeCode}")
  Future<CreateAppThemeResponse> createAppTheme(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @GET("app-theme/{storeCode}")
  Future<GetAppThemeResponse> getAppTheme(@Path("storeCode") String? storeCode);

  @POST("app-theme/{storeCode}/home_buttons")
  Future<ButtonHomeResponse> updateAppButton(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @POST("app-theme/{storeCode}/layout_sort")
  Future<LayoutSortResponse> updateLayoutSort(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  /// Product

  @POST("store/{storeCode}/products")
  Future<ProductResponse> createProduct(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @POST("store_v2/{storeCode}/{branchId}/products")
  Future<ProductResponse> createProductV2(@Path("storeCode") String? storeCode,
      @Path("branchId") int? branchId, @Body() Map<String, dynamic> body);

  @PUT("store/{storeCode}/products/{idProduct}")
  Future<ProductResponse> updateProduct(@Path("storeCode") String? storeCode,
      @Path() int? idProduct, @Body() Map<String, dynamic> body);

  @PUT("store/{storeCode}/products/{idProduct}/set_up_attribute_search")
  Future<ProductResponse> setUpAttributeSearchProduct(
      @Path("storeCode") String? storeCode,
      @Path() int? idProduct,
      @Body() Map<String, dynamic> body);

  // @GET("store/{storeCode}/products/{idProduct}/get_attribute_search")
  // Future<ProductResponse> getAttributeSearchProduct(
  //     @Path("storeCode") String? storeCode,
  //     @Path("idProduct") int idProduct,
  //     );

  @DELETE("store/{storeCode}/products/{idProduct}")
  Future<ProductDeleteResponse> deleteProduct(
      @Path("storeCode") String? storeCode, @Path() int? idProduct);

  @DELETE("store/{storeCode}/products")
  Future<SuccessResponse> deleteManyProduct(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @GET("store/{storeCode}/products")
  Future<AllProductResponse> getAllProduct(
    @Path("storeCode") String? storeCode,
    @Query("search") String search,
    @Query("category_ids") String idCategory,
    @Query("category_children_ids") String? categoryChildrenIds,
    @Query("descending") bool? descending,
    @Query("status") String? status,
    @Query("filter_by") String? filterBy,
    @Query("filter_option") String? filterOption,
    @Query("filter_by_value") String? filterByValue,
    @Query("details") String? details,
    @Query("sort_by") String? sortBy,
    @Query("page") int page,
    @Query("agency_type_id") int? agencyTypeId,
  );

  @GET("store_v2/{storeCode}/{branchId}/products")
  Future<AllProductResponse> getAllProductV2(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Query("search") String? search,
    @Query("category_ids") String? idCategory,
    @Query("category_children_ids") String? categoryChildrenIds,
    @Query("descending") bool? descending,
    @Query("is_near_out_of_stock") bool? isNearOutOfStock,
    @Query("status") String? status,
    @Query("filter_by") String? filterBy,
    @Query("filter_option") String? filterOption,
    @Query("filter_by_value") String? filterByValue,
    @Query("details") String? details,
    @Query("sort_by") String? sortBy,
    @Query("check_inventory") bool? checkInventory,
    @Query("page") int page,
    @Query("agency_type_id") int? agencyTypeId,
  );

  @GET("store/{storeCode}/products/{idProduct}")
  Future<ProductResponse> getOneProduct(
    @Path("storeCode") String? storeCode,
    @Path("idProduct") int idProduct,
  );

  @GET("store_v2/{storeCode}/{branchId}/products/{idProduct}")
  Future<ProductResponse> getOneProductV2(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("idProduct") int idProduct,
  );

  @POST("customer/{storeCode}/scan_product")
  Future<ProductScanResponse> scanProduct(
    @Path("storeCode") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  @POST("store/{storeCode}/ecommerce/products")
  Future<AllProductEcommerceRes> getEcommerceProduct(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @POST("store/{storeCode}/products/all")
  Future<CreateManyProductsRes> postManyProduct(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @GET("store_v2/{storeCode}/{branchId}/products?=")
  Future<QueryProductResponse> searchProduct(
      @Path("storeCode") String? storeCode,
      @Path("branchId") int? branchId,
      @Query("page") int page,
      @Query("search") String search,
      @Query("category_ids") String idCategory,
      @Query("category_children_ids") String idCategoryChild,
      @Query("descending") bool descending,
      @Query("details") String details,
      @Query("sort_by") String sortBy);

  @GET("type_of_store")
  Future<TypeShopResponse> getAllTypeOfStore();

  @POST("store/{storeCode}/categories")
  @FormUrlEncoded()
  Future<CreateCategoryResponse> createCategory(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @POST("store/{storeCode}/categories/{categoryId}")
  @FormUrlEncoded()
  Future<CreateCategoryResponse> updateCategory(
      @Path("storeCode") String? storeCode,
      @Path("categoryId") int? categoryId,
      @Body() Map<String, dynamic> body);

  @GET("store/{storeCode}/categories")
  Future<AllCategoryResponse> getAllCategory(
      @Path("storeCode") String? storeCode);

  @POST("store/{storeCode}/category/sort")
  Future<SuccessResponse> sortCategories(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @DELETE("store/{storeCode}/categories/{categoryId}")
  Future<CategoryDeleteResponse> deleteCategory(
      @Path("storeCode") String? storeCode,
      @Path("categoryId") int? categoryId);

  @POST("store/{storeCode}/categories/{categoryId}/category_children")
  @FormUrlEncoded()
  Future<CreateCategoryResponse> createCategoryChild(
      @Path("storeCode") String? storeCode,
      @Path("categoryId") int? categoryId,
      @Body() Map<String, dynamic> body);

  @POST(
      "store/{storeCode}/categories/{categoryId}/category_children/{categoryChildId}")
  @FormUrlEncoded()
  Future<CreateCategoryResponse> updateCategoryChild(
      @Path("storeCode") String? storeCode,
      @Path("categoryId") int? categoryId,
      @Path("categoryChildId") int? categoryChildId,
      @Body() Map<String, dynamic> body);

  @DELETE(
      "store/{storeCode}/categories/{categoryId}/category_children/{categoryChildId}")
  Future<CategoryDeleteResponse> deleteCategoryChild(
    @Path("storeCode") String? storeCode,
    @Path("categoryId") int? categoryId,
    @Path("categoryChildId") int? categoryChildId,
  );

  ///

  @POST("images")
  Future<UploadImageResponse> uploadImage(@Body() Map<String, dynamic> body);

  @POST("videos")
  Future<UploadImageResponse> uploadVideo(@Body() Map<String, dynamic> body);

  @POST('store/{storeCode}/discounts')
  Future<CreateDiscountResponse> createDiscount(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @POST("device_token_user")
  Future<UpdateDeviceTokenResponse> updateDeviceTokenUser(
      @Body() Map<String, dynamic> body);

  /// post

  @POST("store/{storeCode}/post_categories")
  @FormUrlEncoded()
  Future<CreateCategoryPostResponse> createCategoryPost(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @GET("store/{storeCode}/post_categories")
  Future<AllCategoryPostResponse> getAllCategoryPost(
      @Path("storeCode") String? storeCode);

  @DELETE("store/{storeCode}/post_categories/{categoryPostId}")
  Future<CategoryPostDeleteResponse> deleteCategoryPost(
    @Path("storeCode") String? storeCode,
    @Path("categoryPostId") int? categoryPostId,
  );

  @POST("store/{storeCode}/post_categories/{categoryPostId}")
  Future<UpdateCategoryPostResponse> updateCategoryPost(
      @Path("storeCode") String? storeCode,
      @Path("categoryPostId") int? categoryPostId,
      @Body() Map<String, dynamic> body);

  @POST("store/{storeCode}/posts")
  @FormUrlEncoded()
  Future<CreatePostResponse> createPost(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @POST("store/{storeCode}/posts/{postId}")
  Future<CreatePostResponse> updatePost(@Path("storeCode") String? storeCode,
      @Path("postId") int? postId, @Body() Map<String, dynamic> body);

  @DELETE("store/{storeCode}/posts/{postId}")
  Future<DeletePostResponse> deletePost(
    @Path("storeCode") String? storeCode,
    @Path("postId") int? postId,
  );

  @GET("store/{storeCode}/posts/{postId}")
  Future<PostRes> getOnePost(
    @Path("storeCode") String? storeCode,
    @Path("postId") int? postId,
  );

  @GET("store/{storeCode}/posts")
  Future<AllPostResponse> getAllPost(@Path("storeCode") String? storeCode,
      @Query("page") int page, @Query("search") String search);

  /// marketing channel

  @DELETE("store/{storeCode}/bonus_product/{bonusProductId}")
  Future<SuccessResponse> deleteBonusProduct(
    @Path("storeCode") String? storeCode,
    @Path("bonusProductId") int? bonusProductId,
  );

  @PUT("store/{storeCode}/bonus_product/{bonusProductId}")
  Future<BonusProductRes> updateBonusProduct(
      @Path("storeCode") String? storeCode,
      @Path("bonusProductId") int? bonusProductId,
      @Body() Map<String, dynamic> body);

  @GET("store/{storeCode}/bonus_product_end")
  Future<EndBonusProductRes> getEndBonusProduct(
    @Path("storeCode") String? storeCode,
    @Query("page") int? currentPage,
  );

  @POST("store/{storeCode}/bonus_product")
  Future<BonusProductRes> createBonusProduct(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @GET("store/{storeCode}/discounts")
  Future<MyProgramResponse> getAllDisCount(
      @Path("storeCode") String? storeCode);

  @GET("store/{storeCode}/bonus_product/{bonusProductId}")
  Future<BonusProductRes> getBonusProduct(
    @Path("storeCode") String? storeCode,
    @Path("bonusProductId") int? bonusProductId,
  );

  @GET("store/{storeCode}/bonus_product")
  Future<AllBonusProductRes> getAllBonusProduct(
      @Path("storeCode") String? storeCode);

  @GET("store/{storeCode}/{branchId}/inventory/import_stocks")
  Future<AllImportStocksRes> getAllImportStock(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Query("search") String? search,
    @Query("status_list") String? status,
    @Query("page") int? currentPage,
    @Query("supplier_id") int? supplierId,
  );

  @GET("store/{storeCode}/vouchers")
  Future<MyVoucherResponse> getAllVoucher(@Path("storeCode") String? storeCode);

  @GET("store/{storeCode}/combos")
  Future<MyComboResponse> getAllCombo(@Path("storeCode") String? storeCode);

  @PUT("store/{storeCode}/discounts/{idDiscount}")
  Future<CreateDiscountResponse> updateDiscount(
      @Path("storeCode") String? storeCode,
      @Path() int? idDiscount,
      @Body() Map<String, dynamic> body);

  @DELETE("store/{storeCode}/discounts/{idDiscount}")
  Future<DeleteProgramResponse> deleteDiscount(
      @Path("storeCode") String? storeCode, @Path() int? idDiscount);

  @DELETE("store/{storeCode}/vouchers/{idVoucher}")
  Future<DeleteProgramResponse> deleteVoucher(
      @Path("storeCode") String? storeCode, @Path() int? idVoucher);

  @DELETE("store/{storeCode}/combos/{idCombo}")
  Future<DeleteProgramResponse> deleteCombo(
      @Path("storeCode") String? storeCode, @Path() int? idCombo);

  @POST("store/{storeCode}/vouchers")
  Future<CreateVoucherResponse> createVoucher(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @PUT("store/{storeCode}/vouchers/{idVoucher}")
  Future<CreateVoucherResponse> updateVoucher(
      @Path("storeCode") String? storeCode,
      @Path() int? idVoucher,
      @Body() Map<String, dynamic> body);

  @GET("store/{storeCode}/vouchers_end")
  Future<EndVoucherResponse> getEndVoucherFromPage(
      @Path("storeCode") String? storeCode, @Query("page") int numberPage);

  @GET("store/{storeCode}/discounts_end")
  Future<EndDiscountResponse> getEndDiscountFromPage(
      @Path("storeCode") String? storeCode, @Query("page") int numberPage);

  @GET("store/{storeCode}/combos_end")
  Future<EndComboResponse> getEndComboFromPage(
      @Path("storeCode") String? storeCode, @Query("page") int numberPage);

  @POST("store/{storeCode}/combos")
  Future<CreateComboResponse> createCombo(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @PUT("store/{storeCode}/combos/{idCombo}")
  Future<CreateComboResponse> updateCombo(@Path("storeCode") String? storeCode,
      @Path() int? idCombo, @Body() Map<String, dynamic> body);

  @GET("place/vn/province")
  Future<AddressResponse> getProvince();

  @GET("place/vn/district/{idProvince}")
  Future<AddressResponse> getDistrict(@Path() int? idProvince);

  @GET("place/vn/wards/{idDistrict}")
  Future<AddressResponse> getWard(@Path() int? idDistrict);

  @POST("store/{storeCode}/address_customer")
  Future<AllIAddressCustomerResponse> getAllAddressCustomer(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @POST("store/{storeCode}/store_address")
  Future<CreateAddressStoreResponse> createAddressStore(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @GET("store/{storeCode}/store_address")
  Future<AllAddressStoreResponse> getAllAddressStore(
      @Path("storeCode") String? storeCode);

  @PUT("store/{storeCode}/store_address/{idAddressStore}")
  Future<CreateAddressStoreResponse> updateAddressStore(
      @Path("storeCode") String? storeCode,
      @Path() int? idAddressStore,
      @Body() Map<String, dynamic> body);

  @DELETE("store/{storeCode}/store_address/{idAddressStore}")
  Future<DeleteAddressStoreResponse> deleteAddressStore(
      @Path("storeCode") String? storeCode, @Path() int? idAddressStore);

  @GET("store/{storeCode}/shipments")
  Future<AllShipmentResponse> getAllShipmentStore(
      @Path("storeCode") String? storeCode);

  @PUT("store/{storeCode}/shipments/{idShipment}")
  Future<AddTokenShipmentResponse> addTokenShipment(
      @Path("storeCode") String? storeCode,
      @Path() int? idShipment,
      @Body() Map<String, dynamic> body);

  @GET("store/{storeCode}/config_ship")
  Future<ConfigShipRes> getConfigShip(@Path("storeCode") String? storeCode);

  @PUT("store/{storeCode}/config_ship")
  Future<ConfigShipRes> updateConfigShip(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @POST("store/{storeCode}/shipments/{idShipment}/calculate")
  Future<ShipmentCalculateRes> calculateShipment(
      @Path("storeCode") String? storeCode,
      @Path() int idShipment,
      @Body() Map<String, dynamic> body);

  /// chat

  @GET("store/{storeCode}/message_customers")
  Future<AllChatCustomerResponse> getAllChatUser(
    @Path("storeCode") String? storeCode,
    @Query("page") int numberPage,
  );

  @GET("store/{storeCode}/message_customers/{idCustomer}")
  Future<AllMessageResponse> getAllMessageUser(
    @Path("storeCode") String? storeCode,
    @Path() int? idCustomer,
    @Query("page") int numberPage,
  );

  @POST("store/{storeCode}/message_customers/{idCustomer}")
  Future<SendMessageResponse> sendMessageToCustomer(
    @Path("storeCode") String? storeCode,
    @Path() int? idCustomer,
    @Body() Map<String, dynamic> body,
  );

  @GET("store/{storeCode}/attribute_fields")
  Future<AttributesResponse> getAllAttributeFields(
    @Path("storeCode") String? storeCode,
  );

  @PUT("store/{storeCode}/attribute_fields")
  Future<AttributesResponse> updateAttributeFields(
    @Path("storeCode") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  @GET("store/{storeCode}/payment_methods")
  Future<AllPaymentMethodRes> getPaymentMethod(
    @Path("storeCode") String? storeCode,
  );

  @PUT("store/{storeCode}/payment_methods/{idPaymentMethod}")
  Future<UpdatePaymentResponse> upDatePaymentMethod(
    @Path("storeCode") String? storeCode,
    @Path() int? idPaymentMethod,
    @Body() Map<String, dynamic> body,
  );

  /// order manage

  @GET("store/{storeCode}/orders")
  Future<AllOrderResponse> getAllOrder(
    @Path("storeCode") String storeCode,
    @Query("page") int numberPage,
    @Query("search") String? search,
    @Query("field_by") String? fieldBy,
    @Query("field_by_value") String? filterByValue,
    @Query("sort_by") String? sortBy,
    @Query("descending") bool? descending,
    @Query("time_from") String? dateFrom,
    @Query("time_to") String? dateTo,
    @Query("agency_ctv_by_customer_id") int? agencyByCustomerId,
    @Query("collaborator_by_customer_id") int? collaboratorByCustomerId,
    @Query("phone_number") String? phoneNumber,
    @Query("order_status_code") String? orderStatusCode,
    @Query("payment_status_code") String? paymentStatusCode,
    @Query("from_pos") bool? fromPos,
    @Query("branch_id") int? branchId,
    @Query("branch_id_list") String? listBranchId,
    @Query("order_from_list") String? listOrderFrom,
    @Query("order_status_code_list") String? listOrderStt,
    @Query("payment_status_code_list") String? listPaymentStt,
    @Query("sale_staff_id") int? staffId,
  );

  @GET("store/{storeCode}/orders/status_records/{idOrder}")
  Future<StateHistoryOrderResponse> getStateHistoryOrder(
    @Path("storeCode") String? storeCode,
    @Path() int? idOrder,
  );

  @GET("customer/{storeCode}/carts/orders/{orderCode}")
  Future<OrderResponse> getOneOrderHistory(
      @Path("storeCode") String? storeCode, @Path() String? orderCode);

  @POST("store/{storeCode}/shipper/history_order_status")
  Future<HistoryShipperResponse> getStateHistoryShipper(
    @Path("storeCode") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  @GET("customer/{storeCode}/carts/orders/status_records/{idOrder}")
  Future<StateHistoryOrderCustomerResponse> getStateHistoryCustomerOrder(
    @Path("storeCode") String? storeCode,
    @Path() int? idOrder,
  );

  @POST("store/{storeCode}/orders/change_order_status")
  Future<ChangeOrderStatusResponse> changeOrderStatus(
    @Path("storeCode") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  @POST("store/{storeCode}/orders/change_payment_status")
  Future<ChangePaySuccessResponse> changePaymentStatus(
    @Path("storeCode") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  @PUT("store/{storeCode}/orders/update/{orderCode}")
  Future<SuccessResponse> updateOrder(
    @Path("storeCode") String? storeCode,
    @Path("orderCode") String? orderCode,
    @Body() Map<String, dynamic> body,
  );

  @POST("customer/{storeCode}/carts/orders/cancel")
  Future<CancelOrderResponse> cancelOrder(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @POST("store/{storeCode}/shipper/send_order")
  Future<SuccessResponse> sendOrderToShipper(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @PUT("store/{storeCode}/orders/update_package/{orderCode}")
  Future<OrderResponse> updatePackage(@Path("storeCode") String? storeCode,
      @Path("orderCode") String orderCode, @Body() Map<String, dynamic> body);

  @GET("store/{storeCode}/orders/{orderCode}")
  Future<OrderResponse> getOneOrder(
    @Path() String storeCode,
    @Path() String orderCode,
  );

  @POST("store/{storeCode}/orders/calculate_fee/{orderCode}")
  Future<CalculateFeeOrderRes> calculateFeeOrder(
    @Path("storeCode") String storeCode,
    @Path("orderCode") String orderCode,
  );

  @GET("store/{storeCode}/orders/history_pay/{orderCode}")
  Future<PaymentHistoryRes> getPaymentHistory(
    @Path() String storeCode,
    @Path() String orderCode,
  );

  @POST("store_v2/{storeCode}/{branchId}/pos/refund")
  Future<SuccessResponse> refund(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Body() Map<String, dynamic> body,
  );

  @POST("store_v2/{storeCode}/{branchId}/pos/refund/calculate")
  Future<RefundCalculateRes> refundCalculate(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Body() Map<String, dynamic> body,
  );

  @POST("store_v2/{storeCode}/{branchId}/orders/pay_order/{orderCode}")
  Future<SuccessResponse> payBill(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("orderCode") String? orderCode,
    @Body() Map<String, dynamic> body,
  );

  @POST("store/{storeCode}/pos/send_order_email")
  Future<SuccessResponse> sendOrderEmail(
    @Path("storeCode") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  /// customer manage

  @POST("store/{storeCode}/customers/{customerId}/sale_type")
  Future<SuccessResponse> saleType(
    @Path("storeCode") String? storeCode,
    @Path("customerId") int customerId,
    @Body() Map<String, dynamic> body,
  );

  @GET("store/{storeCode}/customers")
  Future<AllCustomerResponse> getAllInfoCustomer(
    @Path() String storeCode,
    @Query("page") int numberPage,
    @Query("search") String? search,
    @Query("sort_by") String? sortBy,
    @Query("descending") bool? descending,
    @Query("field_by") String? fieldBy,
    @Query("field_by_value") String? fieldByValue,
    @Query("day_of_birth") int? dayOfBirth,
    @Query("month_of_birth") int? monthOfBirth,
    @Query("year_of_birth") int? yearOfBirth,
    @Query("sale_staff_id") int? saleStaffId,
    @Query("date_from") String? dateFrom,
    @Query("date_to") String? dateTo,
    @Query("customer_type") String? customerType,
    @Query("customer_ids") String? customerIds,
    @Query("json_list_filter") String? jsonListFilter,
  );

  @GET("store/{storeCode}/staff_sale/customers")
  Future<AllCustomerResponse> getAllInfoCustomerSale(
    @Path() String storeCode,
    @Query("page") int numberPage,
    @Query("search") String? search,
    @Query("sort_by") String? sortBy,
    @Query("descending") bool? descending,
    @Query("field_by") String? fieldBy,
    @Query("field_by_value") String? fieldByValue,
    @Query("day_of_birth") int? dayOfBirth,
    @Query("month_of_birth") int? monthOfBirth,
    @Query("year_of_birth") int? yearOfBirth,
    @Query("sale_staff_id") int? saleStaffId,
  );

  @POST("store/{storeCode}/customers")
  Future<InfoCustomerRes> addCustomer(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @POST("store/{storeCode}/staff_sale/customers")
  Future<InfoCustomerRes> addCustomerFromSale(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @GET("store/{storeCode}/customers/{idCustomer}")
  Future<InfoCustomerRes> getInfoCustomer(
    @Path("storeCode") String? storeCode,
    @Path("idCustomer") int? idCustomer,
  );

  @PUT("store/{storeCode}/customers/{idCustomer}")
  Future<InfoCustomerRes> updateCustomer(
    @Path("storeCode") String? storeCode,
    @Path("idCustomer") int? idCustomer,
    @Body() Map<String, dynamic> body,
  );

  @PUT("store/{storeCode}/staff_sale/customers/{idCustomer}")
  Future<InfoCustomerRes> updateCustomerFromSale(
    @Path("storeCode") String? storeCode,
    @Path("idCustomer") int? idCustomer,
    @Body() Map<String, dynamic> body,
  );

  @PUT("store/{storeCode}/customers/{idCustomer}")
  Future<SuccessResponse> deleteCustomer(
    @Path("storeCode") String? storeCode,
    @Path("idCustomer") int? idCustomer,
  );

  @PUT("store/{storeCode}/staff_sale/customers/{idCustomer}")
  Future<SuccessResponse> deleteCustomerFromSale(
    @Path("storeCode") String? storeCode,
    @Path("idCustomer") int? idCustomer,
  );

  @GET("store/{storeCode}/customers/{idCustomer}/history_points")
  Future<HistoryScoreResponse> getHistoryPoints(
    @Path("storeCode") String? storeCode,
    @Path("idCustomer") int? idCustomer,
    @Query("page") int? page,
  );

  /// report

  @GET("store_v2/{storeCode}/{branchId}/report/overview")
  Future<ReportResponse> getReport(
    @Path() String storeCode,
    @Path() int branchId,
    @Query("date_from") String timeFrom,
    @Query("date_to") String timeTo,
    @Query("date_from_compare") String dateFromCompare,
    @Query("date_to_compare") String dateToCompare,
    @Query("collaborator_by_customer_id") int? collaboratorByCustomerId,
    @Query("agency_by_customer_id") int? agencyByCustomerId,
  );

  @GET("store/{storeCode}/report/overview")
  Future<ReportResponse> getReportCtvAgency(
    @Path() String storeCode,
    @Query("date_from") String timeFrom,
    @Query("date_to") String timeTo,
    @Query("date_from_compare") String dateFromCompare,
    @Query("date_to_compare") String dateToCompare,
    @Query("collaborator_by_customer_id") int? collaboratorByCustomerId,
    @Query("agency_by_customer_id") int? agencyByCustomerId,
    @Query("agency_ctv_by_customer_id") int? agencyCtvByCustomerId,
  );

  @GET("store_v2/{storeCode}/{branchId}/report/top_ten_products")
  Future<ProductReportResponse> getProductReport(
    @Path() String storeCode,
    @Path() int branchId,
    @Query("date_from") String timeFrom,
    @Query("date_to") String timeTo,
  );

  @POST("store_v2/{storeCode}/collaborator_products")
  Future<SuccessResponse> collaboratorProducts(
    @Path('storeCode') String storeCode,
    @Body() Map<String, dynamic> body,
  );

  /// review manage

  @GET("store/{storeCode}/reviews")
  Future<AllReviewResponse> getReviewManage(
    @Path() String storeCode,
    @Query("filter_by") String? filterBy,
    @Query("filter_by_value") String? filterByValue,
  );

  @DELETE("store/{storeCode}/reviews/{idReview}")
  Future<ReviewDeleteResponse> deleteReview(
      @Path("storeCode") String? storeCode, @Path() int? idReview);

  @PUT("store/{storeCode}/reviews/{idReview}")
  Future<UpdateReviewResponse> updateReview(
    @Path("storeCode") String? storeCode,
    @Path() int? idReview,
    @Body() Map<String, dynamic> body,
  );

  /// badge user

  @GET("store_v2/{storeCode}/{branchId}/badges")
  Future<BadgeUserResponse> getBadgeUser(
    @Path('storeCode') String storeCode,
    @Path('branchId') int branchId,
  );

  ///banner
  @GET("store/home_app")
  Future<HomeHomeDataUserUserResponse> getHomeDataUser();

  /// Profile User

  @GET("profile")
  Future<AddStaffResponse> getProfile();

  @PUT("profile")
  Future<ProfileResponse> updateProfile(
    @Body() Map<String, dynamic> body,
  );

  /// config notification

  @GET("store/{storeCode}/notifications/config")
  Future<InfoNotificationResponse> getConfigNotification(
    @Path("storeCode") String? storeCode,
  );

  @POST("store/{storeCode}/notifications/config")
  Future<SuccessResponse> configNotification(
    @Path("storeCode") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  @POST("store/{storeCode}/notifications/push")
  Future<SuccessResponse> sendNotification(
    @Path("storeCode") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  /// Schedule notification

  @GET("store/{storeCode}/notifications/schedule")
  Future<AllScheduleNotiResponse> getAllScheduleNoti(
    @Path("storeCode") String? storeCode,
  );

  @POST("store/{storeCode}/notifications/schedule")
  Future<ScheduleNotiResponse> setScheduleNoti(
    @Path("storeCode") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  @PUT("store/{storeCode}/notifications/schedule/{idSchedule}")
  Future<ScheduleNotiResponse> updateScheduleNoti(
    @Path("storeCode") String? storeCode,
    @Path("idSchedule") int? idSchedule,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("store/{storeCode}/notifications/schedule/{idSchedule}")
  Future<SuccessResponse> deleteScheduleNoti(
      @Path("storeCode") String? storeCode,
      @Path("idSchedule") int? idSchedule);

  /// CTV

  @POST("store/{storeCode}/collaborators/{customerId}/add_sub_balance")
  Future<HistoryBalanceRes> addSubHistoryBalance(
    @Path("storeCode") String? storeCode,
    @Path("customerId") int customerId,
    @Body() Map<String, dynamic> body,
  );

  @GET("store/{storeCode}/collaborators/{customerId}/history_balance")
  Future<HistoryBalanceRes> getHistoryBalance(
    @Path("storeCode") String? storeCode,
    @Path("customerId") int customerId,
    @Query("page") int? page,
  );

  @GET("store/{storeCode}/collaborator_configs/bonus_steps")
  Future<AllBonusLevelResponse> getAllLevelBonus(
    @Path("storeCode") String? storeCode,
  );

  @POST("store/{storeCode}/collaborator_configs/bonus_steps")
  Future<SuccessResponse> addLevelBonus(
    @Path("storeCode") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  @PUT("store/{storeCode}/collaborator_configs/bonus_steps/{idLevel}")
  Future<UpdateBonusLevelResponse> updateLevelBonus(
    @Path("storeCode") String? storeCode,
    @Path("idLevel") int idLevel,
    @Body() Map<String, dynamic> body,
  );

  @PUT("store/{storeCode}/collaborators/{idCtv}")
  Future<UpdateCtvResponse> updateCtv(
    @Path("storeCode") String? storeCode,
    @Path("idCtv") int idCtv,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("store/{storeCode}/collaborator_configs/bonus_steps/{idLevel}")
  Future<SuccessResponse> deleteLevelBonus(
    @Path("storeCode") String? storeCode,
    @Path("idLevel") int idLevel,
  );

  @POST("store/{storeCode}/collaborator_configs")
  Future<CollaboratorConfigsResponse> configsCollabBonus(
    @Path("storeCode") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  @GET("store/{storeCode}/collaborator_configs")
  Future<CollaboratorConfigsResponse> getConfigsCollabBonus(
    @Path("storeCode") String? storeCode,
  );

  @GET("store/{storeCode}/collaborators")
  Future<ListCtvResponse> getListCtv(
    @Path("storeCode") String? storeCode,
    @Query("search") String? search,
    @Query("page") int? page,
    @Query("sort_by") String? sortBy,
    @Query("descending") bool? descending,
  );

  @GET("store/{storeCode}/collaborators/report")
  Future<ListCtvResponse> getTopCtv(
    @Path("storeCode") String? storeCode,
    @Query("search") String? search,
    @Query("page") int? page,
    @Query("sort_by") String? sortBy,
    @Query("descending") bool? descending,
    @Query("date_from") String? timeFrom,
    @Query("date_to") String? timeTo,
  );

  @GET("store/{storeCode}/collaborators/request_payment/current")
  Future<AllRequestPaymentResponse> getListRequestPayment(
    @Path("storeCode") String? storeCode,
  );

  @GET("store/{storeCode}/collaborators/request_payment/history")
  Future<AllRequestPaymentResponse> getHistoryPayment(
    @Path("storeCode") String? storeCode,
    @Query("sort_by") String? sortBy,
    @Query("filter_by") String? filterBy,
    @Query("filter_by_value") String? filterByValue,
  );

  @POST("store/{storeCode}/collaborators/request_payment/change_status")
  Future<SuccessResponse> changeStatusPayment(
    @Path("storeCode") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  @POST("store/{storeCode}/collaborators/request_payment/settlement")
  Future<SuccessResponse> settlementPayment(
    @Path("storeCode") String? storeCode,
  );

  /// Agency

  @POST("store/{storeCode}/agencies/{customerId}/add_sub_balance")
  Future<HistoryBalanceRes> addSubHistoryBalanceAgency(
    @Path("storeCode") String? storeCode,
    @Path("customerId") int customerId,
    @Body() Map<String, dynamic> body,
  );

  @GET("store/{storeCode}/agencies/{customerId}/history_balance")
  Future<HistoryBalanceRes> getHistoryBalanceAgency(
    @Path("storeCode") String? storeCode,
    @Path("customerId") int customerId,
    @Query("page") int? page,
  );

  @GET("store/{storeCode}/agency_type")
  Future<AllAgencyTypeRes> getAllAgencyType(
    @Path("storeCode") String? storeCode,
  );

  @POST("store/{storeCode}/agency_type")
  Future<AgencyTypeRes> addAgencyType(
    @Path("storeCode") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("store/{storeCode}/agency_type/{idAgency}")
  Future<SuccessResponse> deleteAgencyType(
    @Path("storeCode") String? storeCode,
    @Path("idAgency") int idAgency,
  );

  @PUT("store/{storeCode}/agency_type/{idAgency}")
  Future<AgencyTypeRes> updateAgencyType(
    @Path("storeCode") String? storeCode,
    @Path("idAgency") int idAgency,
    @Body() Map<String, dynamic> body,
  );

  @GET("store/{storeCode}/agency_register_requests")
  Future<AllAgencyRegisterRequestsRes> getAllAgencyRegisterRequest(
    @Path("storeCode") String? storeCode,
    @Query("page") int? page,
    @Query("status") int? status,
  );

  @PUT("store/{storeCode}/agency_register_requests/{idRequest}/status")
  Future<SuccessResponse> updateAgencyRegisterStatus(
    @Path("storeCode") String? storeCode,
    @Path("idRequest") int idRequest,
    @Body() Map<String, dynamic> body,
  );

  @GET("store/{storeCode}/agency_configs/bonus_steps")
  Future<AllBonusLevelAgencyResponse> getAllLevelBonusAgency(
    @Path("storeCode") String? storeCode,
  );

  @POST("store/{storeCode}/agency_configs/bonus_steps")
  Future<SuccessResponse> addLevelBonusAgency(
    @Path("storeCode") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  @PUT("store/{storeCode}/agency_configs/bonus_steps/{idLevel}")
  Future<UpdateBonusLevelAgencyResponse> updateLevelBonusAgency(
    @Path("storeCode") String? storeCode,
    @Path("idLevel") int idLevel,
    @Body() Map<String, dynamic> body,
  );

  @PUT("store/{storeCode}/agencies/{idCtv}")
  Future<UpdateAgencyResponse> updateAgency(
    @Path("storeCode") String? storeCode,
    @Path("idCtv") int idCtv,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("store/{storeCode}/agency_configs/bonus_steps/{idLevel}")
  Future<SuccessResponse> deleteLevelBonusAgency(
    @Path("storeCode") String? storeCode,
    @Path("idLevel") int idLevel,
  );

  @POST("store/{storeCode}/agency_configs")
  Future<AgencyConfigResponse> configsCollabBonusAgency(
    @Path("storeCode") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  @PUT("store/{storeCode}/config_type_bonus_period_import")
  Future<SuccessResponse> configTypeBonusPeriodImport(
    @Path("storeCode") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  @GET("store/{storeCode}/agency_configs")
  Future<AgencyConfigResponse> getConfigsCollabBonusAgency(
    @Path("storeCode") String? storeCode,
  );

  @GET("store/{storeCode}/agencies")
  Future<ListAgencyResponse> getListAgency(
    @Path("storeCode") String? storeCode,
    @Query("search") String? search,
    @Query("page") int? page,
    @Query("sort_by") String? sortBy,
    @Query("descending") bool? descending,
    @Query("agency_type_id") int? agencyTypeId,
  );

  @GET("store/{storeCode}/sale_visit_agencies/agencies")
  Future<ListAgencyResponse> getListAgencyForSale(
    @Path("storeCode") String? storeCode,
    @Query("search") String? search,
    @Query("page") int? page,
  );
  @GET("store/{storeCode}/sale_visit_agencies/agencies/{agency_id}")
  Future<AgencyRes> getAgencyForSale(
    @Path("storeCode") String? storeCode,
    @Path("agency_id") int agencyId,
  );

  @GET("store/{storeCode}/agencies/report")
  Future<ListAgencyResponse> getTopAgency(
    @Path("storeCode") String? storeCode,
    @Query("search") String? search,
    @Query("page") int? page,
    @Query("sort_by") String? sortBy,
    @Query("descending") bool? descending,
    @Query("date_from") String? timeFrom,
    @Query("date_to") String? timeTo,
    @Query("report_type") String? reportType,
  );

  @GET("store/{storeCode}/agencies/report_share")
  Future<ListAgencyResponse> getTopAgencyCtv(
    @Path("storeCode") String? storeCode,
    @Query("search") String? search,
    @Query("page") int? page,
    @Query("sort_by") String? sortBy,
    @Query("descending") bool? descending,
    @Query("date_from") String? timeFrom,
    @Query("date_to") String? timeTo,
    @Query("report_type") String? reportType,
  );

  @GET("store/{storeCode}/agencies/request_payment/current")
  Future<AllRequestPaymentAgencyResponse> getListRequestPaymentAgency(
    @Path("storeCode") String? storeCode,
  );

  @GET("store/{storeCode}/agencies/request_payment/history")
  Future<AllRequestPaymentAgencyResponse> getHistoryPaymentAgency(
    @Path("storeCode") String? storeCode,
    @Query("sort_by") String? sortBy,
    @Query("filter_by") String? filterBy,
    @Query("filter_by_value") String? filterByValue,
  );

  @POST("store/{storeCode}/agencies/request_payment/change_status")
  Future<SuccessResponse> changeStatusPaymentAgency(
    @Path("storeCode") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  @POST("store/{storeCode}/agencies/request_payment/settlement")
  Future<SuccessResponse> settlementPaymentAgency(
    @Path("storeCode") String? storeCode,
  );

  @PUT("store/{storeCode}/products/{idProduct}/agency_price")
  Future<UpdatePriceAgencyRes> updateProductPriceAgency(
    @Path("storeCode") String? storeCode,
    @Path("idProduct") int idProduct,
    @Body() Map<String, dynamic> body,
  );

  @GET("store/{storeCode}/products/{idProduct}/agency_price")
  Future<UpdatePriceAgencyRes> getProductPriceAgency(
    @Path("storeCode") String? storeCode,
    @Path("idProduct") int idProduct,
    @Query("agency_type_id") int agencyTypeId,
  );

  @GET("store/{storeCode}/bonus_agency_config")
  Future<BonusStepRes> getBonusAgencyConfig(
    @Path("storeCode") String? storeCode,
  );

  @PUT("store/{storeCode}/bonus_agency_config")
  Future<BonusStepRes> updateBonusAgencyConfig(
    @Path("storeCode") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  @POST("store/{storeCode}/bonus_agency_config/bonus_steps")
  Future<SuccessResponse> addBonusStepAgency(
    @Path("storeCode") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  @PUT("store/{storeCode}/bonus_agency_config/bonus_steps/{idStep}")
  Future<UpdateBonusStepAgencyRes> updateBonusStepAgency(
    @Path("storeCode") String? storeCode,
    @Path("idStep") int? idStep,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("store/{storeCode}/bonus_agency_config/bonus_steps/{idStep}")
  Future<SuccessResponse> deleteBonusStepAgency(
    @Path("storeCode") String? storeCode,
    @Path("idStep") int? idSchedule,
  );

  @GET("store/{storeCode}/agency_configs/import_bonus_steps")
  Future<ImportBonusStepsRes> getImportBonusAgencyConfig(
    @Path("storeCode") String? storeCode,
  );

  @POST("store/{storeCode}/agency_configs/import_bonus_steps")
  Future<SuccessResponse> addImportBonusStepAgency(
    @Path("storeCode") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  @PUT("store/{storeCode}/agency_configs/import_bonus_steps/{idStep}")
  Future<SuccessResponse> updateImportBonusStepAgency(
    @Path("storeCode") String? storeCode,
    @Path("idStep") int? idStep,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("store/{storeCode}/agency_configs/import_bonus_steps/{idStep}")
  Future<SuccessResponse> deleteImportBonusStepAgency(
    @Path("storeCode") String? storeCode,
    @Path("idStep") int? idSchedule,
  );

  @POST("store/{storeCode}/agency_type/{agencyTypeId}/edit_percent_agency")
  Future<AgencyTypeRes> editPercentAgency(
    @Path("storeCode") String? storeCode,
    @Path("agencyTypeId") int agencyTypeId,
    @Body() Map<String, dynamic> body,
  );

  @POST("store/{storeCode}/agency_type/{agencyTypeId}/override_price")
  Future<AgencyTypeRes> editOverridePriceAgency(
    @Path("storeCode") String? storeCode,
    @Path("agencyTypeId") int agencyTypeId,
    @Body() Map<String, dynamic> body,
  );

  /// Popup

  @DELETE("store/{storeCode}/popups/{idPopup}")
  Future<SuccessResponse> deletePopup(
    @Path("storeCode") String? storeCode,
    @Path("idPopup") int idPopup,
  );

  @POST("store/{storeCode}/popups")
  Future<SuccessResponse> addPopup(
    @Path("storeCode") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  @PUT("store/{storeCode}/popups/{idPopup}")
  Future<UpdatePopupResponse> updatePopup(
    @Path("storeCode") String? storeCode,
    @Path("idPopup") int idPopup,
    @Body() Map<String, dynamic> body,
  );

  @GET("store/{storeCode}/popups")
  Future<ListPopupResponse> getListPopup(
    @Path("storeCode") String? storeCode,
  );

  /// Reward Point

  @POST("store/{storeCode}/reward_points")
  Future<RewardPointsResponse> configRewardPoint(
    @Path("storeCode") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  @GET("store/{storeCode}/reward_points")
  Future<RewardPointsResponse> getRewardPoint(
    @Path("storeCode") String? storeCode,
  );

  @GET("store/{storeCode}/reward_points/reset")
  Future<RewardPointsResponse> resetRewardPoint(
    @Path("storeCode") String? storeCode,
  );

  /// Notification
  @GET("store_v2/{storeCode}/{branchId}/notifications_history")
  Future<AllNotificationResponse> historyNotification(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Query("page") int? page,
  );

  @GET("store_v2/{storeCode}/{branchId}/notifications_history/read_all")
  Future<SuccessResponse> readAllNotification(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
  );

  /// Decentralization
  @GET("store/{storeCode}/decentralizations")
  Future<ListDecentralizationResponse> getListDecentralization(
    @Path("storeCode") String? storeCode,
  );

  @POST("store/{storeCode}/decentralizations")
  Future<AddDecentralizationResponse> addDecentralization(
    @Path("storeCode") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("store/{storeCode}/decentralizations/{idDecentralization}")
  Future<SuccessResponse> deleteDecentralization(
      @Path("storeCode") String? storeCode,
      @Path("idDecentralization") int? idDecentralization);

  @PUT("store/{storeCode}/decentralizations/{idDecentralization}")
  Future<AddDecentralizationResponse> updateDecentralization(
    @Path("storeCode") String? storeCode,
    @Path("idDecentralization") int idDecentralization,
    @Body() Map<String, dynamic> body,
  );

  ///Staff
  @GET("store/{storeCode}/staffs")
  Future<AllStaffResponse> getListStaff(
    @Path("storeCode") String? storeCode,
    @Query("branch_id") int? page,
    @Query("is_sale") bool? isSale,
  );

  @POST("store/{storeCode}/staffs/{staffId}/update_sale")
  Future<AddStaffResponse> updateSaleStt(
    @Path("storeCode") String? storeCode,
    @Path("staffId") int staffId,
    @Body() Map<String, dynamic> body,
  );

  @POST("store/{storeCode}/staffs")
  Future<AddStaffResponse> addStaff(
    @Path("storeCode") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("store/{storeCode}/staffs/{idStaff}")
  Future<SuccessResponse> deleteStaff(
      @Path("storeCode") String? storeCode, @Path("idStaff") int? idStaff);

  @PUT("store/{storeCode}/staffs/{idStaff}")
  Future<AddStaffResponse> updateStaff(
    @Path("storeCode") String? storeCode,
    @Path("idStaff") int idStaff,
    @Body() Map<String, dynamic> body,
  );

  /// Pos Cart

  @GET("store/{storeCode}/pos/carts")
  Future<Cart> getItemCart(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @POST("store/{storeCode}/pos/carts")
  Future<Cart> addVoucherCart(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @POST("store/{storeCode}/pos/carts/orders")
  Future<OrderResponse> createOrder(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @GET("store/{store_code}/carts/{branchId}/list/{cartId}/clear_carts")
  Future<SuccessResponse> clearCart(
    @Path("store_code") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("cartId") int? cartId,
  );

  /// Send otp

  @POST("send_otp")
  Future<SuccessResponse> sendOtp(@Body() Map<String, dynamic> body);

  @POST("customer/{storeCode}/send_email_otp")
  Future<SuccessResponse> sendEmailOtpCus(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @POST("send_email_otp")
  Future<SuccessResponse> sendOtpEmail(@Body() Map<String, dynamic> body);

  /// branch

  @GET("store/{storeCode}/branches")
  Future<AllBranchResponse> getAllBranch(
    @Path("storeCode") String? storeCode,
    @Query("get_all") bool? getAll,
  );

  @POST("store/{storeCode}/branches")
  Future<CreateBranchResponse> createBranch(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @DELETE("store/{storeCode}/branches/{idBranch}")
  Future<SuccessResponse> deleteBranch(
      @Path("storeCode") String? storeCode, @Path() int? idBranch);

  @PUT("store/{storeCode}/branches/{idBranch}")
  Future<CreateBranchResponse> updateBranch(
      @Path("storeCode") String? storeCode,
      @Path() int? idBranch,
      @Body() Map<String, dynamic> body);

  /// inventory

  @POST("store/{storeCode}/{branchId}/inventory/history")
  Future<HistoryInventoryRes> historyInventory(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Body() Map<String, dynamic> body,
    @Query("page") int? currentPage,
  );

  @PUT("store/{storeCode}/{branchId}/inventory/update_balance")
  Future<SuccessResponse> updateInventoryProduct(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Body() Map<String, dynamic> body,
  );

  @GET("store/{storeCode}/{branchId}/inventory/tally_sheets")
  Future<AllTallySheetRes> getAllTallySheet(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Query("search") String? search,
    @Query("status") int? status,
    @Query("page") int? currentPage,
  );

  @GET("store/{storeCode}/{branchId}/inventory/tally_sheets/{idTallySheet}")
  Future<TallySheetRes> getTallySheet(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("idTallySheet") int? idTallySheet,
  );

  @PUT("store/{storeCode}/{branchId}/inventory/tally_sheets/{idTallySheet}")
  Future<SuccessResponse> updateTallySheet(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("idTallySheet") int? idTallySheet,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("store/{storeCode}/{branchId}/inventory/tally_sheets/{idTallySheet}")
  Future<SuccessResponse> deleteTallySheet(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("idTallySheet") int? idTallySheet,
  );

  @POST("store/{storeCode}/{branchId}/inventory/tally_sheets")
  Future<SuccessResponse> createTallySheet(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Body() Map<String, dynamic> body,
  );

  @POST(
      "store/{storeCode}/{branchId}/inventory/tally_sheets/{tallySheetId}/balance")
  Future<SuccessResponse> balanceTallySheet(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("tallySheetId") int? tallySheetId,
  );

  /// suppliers

  @GET("store/{storeCode}/suppliers")
  Future<AllSuppliersRes> getAllSuppliers(
    @Path("storeCode") String? storeCode,
    @Query("search") String? search,
    @Query("page") int? currentPage,
  );

  @GET("store/{storeCode}/suppliers/{idSupplier}")
  Future<SupplierRes> getSupplier(
    @Path("storeCode") String? storeCode,
    @Path("idSupplier") int? idSupplier,
  );

  @POST("store/{storeCode}/suppliers")
  Future<CreateSuppliersRes> createSuppliers(
    @Path("storeCode") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  @PUT("store/{storeCode}/suppliers/{supplierId}")
  Future<CreateSuppliersRes> updateSuppliers(
    @Path("storeCode") String? storeCode,
    @Path("supplierId") int? supplierId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("store/{storeCode}/suppliers/{supplierId}")
  Future<SuccessResponse> deleteSuppliers(
    @Path("storeCode") String? storeCode,
    @Path("supplierId") int? supplierId,
  );

  /// Import Stock

  @GET("store/{storeCode}/{branchId}/inventory/import_stocks/{importStockId}")
  Future<ImportStocksRes> getImportStock(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("importStockId") int? importStockId,
  );

  @PUT("store/{storeCode}/{branchId}/inventory/import_stocks/{importStockId}")
  Future<ImportStocksRes> updateImportStock(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("importStockId") int? importStockId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE(
      "store/{storeCode}/{branchId}/inventory/import_stocks/{importStockId}")
  Future<SuccessResponse> deleteImportStock(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("importStockId") int? importStockId,
  );

  @POST("store/{storeCode}/{branchId}/inventory/import_stocks")
  Future<ImportStocksRes> createImportStock(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Body() Map<String, dynamic> body,
  );

  @POST(
      "store/{storeCode}/{branchId}/inventory/import_stocks/{importStockId}/refund")
  Future<SuccessResponse> refundImportStock(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("importStockId") int? importStockId,
    @Body() Map<String, dynamic> body,
  );

  @PUT(
      "store/{storeCode}/{branchId}/inventory/import_stocks/{importStockId}/status")
  Future<SuccessResponse> updateStatusImportStock(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("importStockId") int? importStockId,
    @Body() Map<String, dynamic> body,
  );

  @PUT(
      "store/{storeCode}/{branchId}/inventory/import_stocks/{importStockId}/payment")
  Future<SuccessResponse> payImportStock(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("importStockId") int? importStockId,
    @Body() Map<String, dynamic> body,
  );

  /// revenue expenditure

  @GET("store/{storeCode}/{branchId}/revenue_expenditures")
  Future<AllRevenueExpenditureRes> getAllRevenueExpenditure(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Query("page") int? currentPage,
    @Query("recipient_group") int? recipientGroup,
    @Query("recipient_references_id") int? recipientReferencesId,
  );

  @GET(
      "store/{storeCode}/{branchId}/revenue_expenditures/{idRevenueExpenditure}")
  Future<RevenueExpenditureRes> getRevenueExpenditure(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("idRevenueExpenditure") int? idRevenueExpenditure,
  );

  @POST("store/{storeCode}/{branchId}/revenue_expenditures")
  Future<RevenueExpenditureRes> createRevenueExpenditure(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Body() Map<String, dynamic> body,
  );

  /// report

  @GET("store/{storeCode}/report/stock/{branchId}/product_last_inventory")
  Future<ProductLastInventoryRes> getProductLastInventory(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Query("date") String? date,
    @Query("page") int? currentPage,
  );

  @GET("store/{storeCode}/report/stock/{branchId}/inventory_histories")
  Future<AllHistoryInventoryRes> getAllHistoryInventory(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Query("date_from") String? dateFrom,
    @Query("date_to") String? dateTo,
    @Query("page") int? currentPage,
  );

  @GET("store/{storeCode}/report/stock/{branchId}/product_import_export_stock")
  Future<AllProductIEStockRes> getProductIEStock(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Query("date_from") String? dateFrom,
    @Query("date_to") String? dateTo,
    @Query("page") int? currentPage,
  );

  @GET("store/{storeCode}/report/finance/{branchId}/revenue_expenditure")
  Future<AllRevenueExpenditureReportRes> getAllRevenueExpenditureReport(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Query("date_from") String? dateFrom,
    @Query("date_to") String? dateTo,
    @Query("page") int? currentPage,
    @Query("is_revenue") bool? isRevenue,
  );

  @GET("store/{storeCode}/report/finance/{branchId}/supplier_debt")
  Future<AllSupplierDebtReportRes> getAllSupplierDebtReport(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Query("date") String? date,
    @Query("page") int? currentPage,
  );

  @GET("store/{storeCode}/report/finance/{branchId}/customer_debt")
  Future<AllCustomerDebtReportRes> getAllCustomerDebtReport(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Query("date") String? date,
    @Query("page") int? currentPage,
  );

  @GET("store/{storeCode}/report/finance/{branchId}/profit_and_loss")
  Future<ProfitAndLossRes> getProfitAndLoss(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Query("date_from") String? dateFrom,
    @Query("date_to") String? dateTo,
  );

  /// cart V2

  @GET("store/{storeCode}/carts/{branchId}/list")
  Future<AllCartRes> getAllCart(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Query("has_cart_default") bool? hasCartDefault,
  );

  @GET("store/{storeCode}/carts/{branchId}/list/{cartId}")
  Future<CartRes> getCart(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("cartId") int? cartId,
  );

  @POST("store/{storeCode}/carts/{branchId}/list")
  Future<AllCartRes> createCart(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Body() Map<String, dynamic> body,
  );

  @POST("store/{storeCode}/orders/create_cart_edit_order/{orderCode}/init")
  Future<CartRes> createCartOrder(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("orderCode") String orderCode,
  );

  @POST("store/{storeCode}/carts/{branchId}/list/0/create_cart_save")
  Future<AllCartRes> createCartSave(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Body() Map<String, dynamic> body,
  );

  @PUT("store/{storeCode}/carts/{branchId}/list/{cartId}")
  Future<CartRes> updateInfoCart(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("cartId") int? cartId,
    @Body() Map<String, dynamic> body,
  );

  @PUT("store/{storeCode}/carts/{branchId}/list/{cartId}/change_name")
  Future<CartRes> changeNameCart(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("cartId") int? cartId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("store/{storeCode}/carts/{branchId}/list/{cartId}")
  Future<SuccessResponse> deleteCart(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("cartId") int? cartId,
  );

  @POST("store/{storeCode}/carts/{branchId}/list/{cartId}/items")
  Future<CartRes> addProductToCart(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("cartId") int? cartId,
    @Body() Map<String, dynamic> body,
  );

  @PUT("store/{storeCode}/carts/{branchId}/list/{cartId}/items")
  Future<CartRes> updateItemCart(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("cartId") int? cartId,
    @Body() Map<String, dynamic> body,
  );

  @PUT(
      "store/{storeCode}/carts/{branchId}/list/{cartId}/items/{cartItemId}/note")
  Future<CartRes> noteItemCart(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("cartId") int? cartId,
    @Path("cartItemId") int? cartItemId,
    @Body() Map<String, dynamic> body,
  );

  @POST("store/{storeCode}/carts/{branchId}/list/{cartId}/order")
  Future<OrderResponse> orderCart(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("cartId") int? cartId,
    @Body() Map<String, dynamic> body,
  );

  @POST("store/{storeCode}/carts/{branchId}/list/{cartId}/use_voucher")
  Future<CartRes> useVoucher(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("cartId") int? cartId,
    @Body() Map<String, dynamic> body,
  );

  /// general setting

  @GET("store/{storeCode}/general_settings")
  Future<GeneralSettingsRes> getGeneralSettings(
    @Path("storeCode") String? storeCode,
  );

  @POST("store/{storeCode}/general_settings")
  Future<GeneralSettingsRes> editGeneralSettings(
    @Path("storeCode") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  /// distribute

  @GET("store/{storeCode}/products/{productId}/distribute")
  Future<DistributeRes> getDistribute(
    @Path("storeCode") String? storeCode,
    @Path("productId") int? productId,
  );

  @PUT("store_v2/{storeCode}/{brandId}/products/{productId}/distribute")
  Future<DistributeRes> updateDistribute(
    @Path("storeCode") String? storeCode,
    @Path("brandId") int? brandId,
    @Path("productId") int? productId,
    @Body() Map<String, dynamic> body,
  );

  @POST("store/{storeCode}/products/{productId}/distribute/element_distribute")
  Future<DistributeRes> addElmDistribute(
    @Path("storeCode") String? storeCode,
    @Path("productId") int? productId,
    @Body() Map<String, dynamic> body,
  );

  @POST(
      "store/{storeCode}/products/{productId}/distribute/sub_element_distribute")
  Future<DistributeRes> addSubDistribute(
    @Path("storeCode") String? storeCode,
    @Path("productId") int? productId,
    @Body() Map<String, dynamic> body,
  );

  @PUT("store/{storeCode}/products/{productId}/distribute/element_distribute")
  Future<DistributeRes> updateElmDistribute(
    @Path("storeCode") String? storeCode,
    @Path("productId") int? productId,
    @Body() Map<String, dynamic> body,
  );

  @PUT(
      "store/{storeCode}/products/{productId}/distribute/sub_element_distribute")
  Future<DistributeRes> updateSubDistribute(
    @Path("storeCode") String? storeCode,
    @Path("productId") int? productId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE(
      "store/{storeCode}/products/{productId}/distribute/element_distribute")
  Future<DistributeRes> deleteElmDistribute(
    @Path("storeCode") String? storeCode,
    @Path("productId") int? productId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE(
      "store/{storeCode}/products/{productId}/distribute/sub_element_distribute")
  Future<DistributeRes> deleteSubDistribute(
    @Path("storeCode") String? storeCode,
    @Path("productId") int? productId,
    @Body() Map<String, dynamic> body,
  );

  /// time keeping

  @GET("store_v2/{storeCode}/{branchId}/shifts")
  Future<ListShiftsRes> getListShifts(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Query("page") int? page,
  );

  @GET("store_v2/{storeCode}/{branchId}/shifts/{shiftsId}")
  Future<ShiftsRes> getShifts(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("shiftsId") int? shiftsId,
  );

  @PUT("store_v2/{storeCode}/{branchId}/shifts/{shiftsId}")
  Future<ShiftsRes> updateShifts(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("shiftsId") int? shiftsId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("store_v2/{storeCode}/{branchId}/shifts/{shiftsId}")
  Future<SuccessResponse> deleteShifts(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("shiftsId") int? shiftsId,
  );

  @POST("store_v2/{storeCode}/{branchId}/shifts")
  Future<ShiftsRes> addShift(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Body() Map<String, dynamic> body,
  );

  @GET("store_v2/{storeCode}/{branchId}/calendar_shifts")
  Future<CalendarShiftsRes> getCalendarShifts(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Query("date_from") String? dateFrom,
    @Query("date_to") String? dateTo,
  );

  @POST("store_v2/{storeCode}/{branchId}/calendar_shifts/put_a_lot")
  Future<SuccessResponse> addCalendarShifts(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Body() Map<String, dynamic> body,
  );

  @POST("store_v2/{storeCode}/{branchId}/calendar_shifts/put_one")
  Future<SuccessResponse> addCalendarShiftsPutOne(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Body() Map<String, dynamic> body,
  );

  @GET("store_v2/{storeCode}/{branchId}/timekeeping/calculate")
  Future<TimeKeepingCalculateRes> getTimeKeepingCalculate(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Query("date_from") String? dateFrom,
    @Query("date_to") String? dateTo,
  );

  /// check in location

  @GET("store_v2/{storeCode}/{branchId}/checkin_location")
  Future<AllCheckInLocationRes> getCheckInLocation(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
  );

  @POST("store_v2/{storeCode}/{branchId}/checkin_location")
  Future<CheckInLocationRes> addCheckInLocation(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Body() Map<String, dynamic> body,
  );

  @PUT("store_v2/{storeCode}/{branchId}/checkin_location/{checkInLocationId}")
  Future<CheckInLocationRes> updateCheckInLocation(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("checkInLocationId") int? checkInLocationId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE(
      "store_v2/{storeCode}/{branchId}/checkin_location/{checkInLocationId}")
  Future<SuccessResponse> deleteCheckInLocation(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("checkInLocationId") int? checkInLocationId,
  );

  /// checkin checkout

  @GET("store_v2/{storeCode}/{branchId}/timekeeping/to_day")
  Future<TimeKeepingToDayRes> getTimeKeepingToday(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
  );

  @POST("store_v2/{storeCode}/{branchId}/timekeeping/checkin_checkout")
  Future<TimeKeepingToDayRes> checkInCheckOut(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Body() Map<String, dynamic> body,
  );

  /// device

  @GET("store_v2/{storeCode}/{branchId}/mobile_checkin")
  Future<AllDeviceRes> getAllDevice(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
  );

  @POST("store_v2/{storeCode}/{branchId}/mobile_checkin")
  Future<DeviceRes> addDevice(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Body() Map<String, dynamic> body,
  );

  @PUT("store_v2/{storeCode}/{branchId}/mobile_checkin/{deviceId}")
  Future<DeviceRes> updateDevice(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("deviceId") int? deviceId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("store_v2/{storeCode}/{branchId}/mobile_checkin/{deviceId}")
  Future<SuccessResponse> deleteDevice(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("deviceId") int? deviceId,
  );

  @GET("store_v2/{storeCode}/{branchId}/mobile_checkin/staff/{staffId}")
  Future<AllDeviceRes> getAllDeviceApproveStaff(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("staffId") int? staffId,
  );

  @GET("store_v2/{storeCode}/{branchId}/await_mobile_checkins")
  Future<AllDeviceRes> getAllDeviceAwait(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
  );

  @POST(
      "store_v2/{storeCode}/{branchId}/await_mobile_checkins/{deviceId}/change_status")
  Future<SuccessResponse> changeStatusDevice(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("deviceId") int? deviceId,
    @Body() Map<String, dynamic> body,
  );

  @GET("store_v2/{storeCode}/{branchId}/await_checkin_checkouts")
  Future<AllApproveDeviceRes> getAllAwaitCheckInOutsAwait(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Query("page") int? page,
  );

  @POST(
      "store_v2/{storeCode}/{branchId}/await_checkin_checkouts/{approveId}/change_status")
  Future<SuccessResponse> changeStatusApprove(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("approveId") int? approveId,
    @Body() Map<String, dynamic> body,
  );

  @POST("store_v2/{storeCode}/{branchId}/bonus_less_checkin_checkout")
  Future<SuccessResponse> bonusCheckInOut(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Body() Map<String, dynamic> body,
  );

  /// Transfer Stock

  @GET("store/{storeCode}/{branchId}/inventory/transfer_stocks/receiver")
  Future<AllTransferStocksRes> getAllTransferStocksRCV(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Query("search") String? search,
    @Query("page") int? page,
  );

  @GET("store/{storeCode}/{branchId}/inventory/transfer_stocks/sender")
  Future<AllTransferStocksRes> getAllTransferStocksSender(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Query("search") String? search,
    @Query("page") int? page,
  );

  @GET(
      "store/{storeCode}/{branchId}/inventory/transfer_stocks/{transferStockId}")
  Future<TransferStocksRes> getTransferStock(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("transferStockId") int? transferStockId,
  );

  @POST("store/{storeCode}/{branchId}/inventory/transfer_stocks")
  Future<TransferStocksRes> createTransferStock(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Body() Map<String, dynamic> body,
  );

  @PUT(
      "store/{storeCode}/{branchId}/inventory/transfer_stocks/{transferStockId}")
  Future<TransferStocksRes> updateTransferStock(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("transferStockId") int? transferStockId,
    @Body() Map<String, dynamic> body,
  );

  @PUT(
      "store/{storeCode}/{branchId}/inventory/transfer_stocks/{transferStockId}/status")
  Future<TransferStocksRes> changeStatusTransferStock(
    @Path("storeCode") String? storeCode,
    @Path("branchId") int? branchId,
    @Path("transferStockId") int? transferStockId,
    @Body() Map<String, dynamic> body,
  );

  /// Community

  @GET("store/{storeCode}/community_posts")
  Future<AllPostCmtRes> getPostCmt(
      @Path("storeCode") String? storeCode,
      @Query("page") int numberPage,
      @Query("search") String? search,
      @Query("user_id") int? userId,
      @Query("is_pin") bool? isPin,
      @Query("status") int? status);

  @POST("store/{storeCode}/community_posts")
  Future<PostCmtRes> createPostCmt(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @POST("store/{storeCode}/community_post_ghim")
  Future<PostCmtRes> pinPostCmt(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @POST("store/{storeCode}/ghim_top")
  Future<PostCmtRes> pinPostCmtTop(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @PUT("store/{storeCode}/community_posts/{postId}")
  Future<PostCmtRes> updatePostCmt(@Path("storeCode") String? storeCode,
      @Path("postId") int? postId, @Body() Map<String, dynamic> body);

  @DELETE("store/{storeCode}/community_posts/{postId}")
  Future<SuccessResponse> deletePostCmt(
    @Path("storeCode") String? storeCode,
    @Path("postId") int postId,
  );

  @GET("store/{storeCode}/community_posts/{postId}")
  Future<PostCmtRes> getOnePostCmt(
    @Path("storeCode") String? storeCode,
    @Path("postId") int potsId,
  );

  @PUT("store/{storeCode}/community_posts/{postId}/reup")
  Future<SuccessResponse> reUpPostCmt(
    @Path("storeCode") String? storeCode,
    @Path("postId") int potsId,
  );

  /// comment

  @GET("store/{storeCode}/community_comments")
  Future<CommentAllRes> getComment(
    @Path("storeCode") String? storeCode,
    @Query("page") int numberPage,
    @Query("community_post_id") int communityPostId,
    @Query("status") int? status,
  );

  @POST("store/{storeCode}/community_comments")
  Future<PostCmtRes> createComment(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @PUT("store/{storeCode}/community_comments/{commentId}")
  Future<PostCmtRes> updateComment(@Path("storeCode") String? storeCode,
      @Path("commentId") int commentId, @Body() Map<String, dynamic> body);

  @DELETE("store/{storeCode}/community_comments/{commentId}")
  Future<SuccessResponse> deleteComment(
      @Path("storeCode") String? storeCode, @Path("commentId") int commentId);

  /// banner ads

  @GET("store/{storeCode}/banner_ads_app")
  Future<AllBannerAdsRes> getAllBannerAds(
    @Path("storeCode") String? storeCode,
  );

  @POST("store/{storeCode}/banner_ads_app")
  Future<BannerAdsRes> createBannerAds(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @PUT("store/{storeCode}/banner_ads_app/{bannerAdsId}")
  Future<BannerAdsRes> updateBannerAds(@Path("storeCode") String? storeCode,
      @Path("bannerAdsId") int bannerAdsId, @Body() Map<String, dynamic> body);

  @DELETE("store/{storeCode}/banner_ads_app/{bannerAdsId}")
  Future<SuccessResponse> deleteBannerAds(@Path("storeCode") String? storeCode,
      @Path("bannerAdsId") int bannerAdsId);

  ///Education
  @GET("store/{store_code}/train_courses")
  Future<CourseListRes> getCourseList(
    @Path("store_code") String? storeCode,
    @Query("page") int currentPage,
  );

  @DELETE("store/{storeCode}/train_courses/{courseId}")
  Future<SuccessResponse> deleteTrainCourses(
      @Path("storeCode") String? storeCode, @Path("courseId") int courseId);

  @POST("store/{store_code}/train_courses")
  Future<CourseListRes> addCourses(
      @Path("store_code") String? storeCode, @Body() Map<String, dynamic> body);

  @PUT("store/{store_code}/train_courses/{id_course}")
  Future<CourseRes> updateCourse(
    @Path("store_code") String? storeCode,
    @Path("id_course") int? idCourse,
    @Body() Map<String, dynamic> body,
  );

  @GET("store/{store_code}/train_chapter_lessons/{id_course}")
  Future<ChapterLessonRes> getChapterLesson(
    @Path("store_code") String? storeCode,
    @Path("id_course") int? idCourse,
  );

  @POST("store/{store_code}/train_chapters")
  Future<AddChapterRes> addChapter(
      @Path("store_code") String? storeCode, @Body() Map<String, dynamic> body);

  @DELETE("store/{store_code}/train_chapters/{id_chapter}")
  Future<SuccessResponse> deleteChapter(
    @Path("store_code") String? storeCode,
    @Path("id_chapter") int idChapter,
  );

  @PUT("store/{store_code}/train_chapters/{id_chapter}")
  Future<AddChapterRes> updateChapter(
    @Path("store_code") String? storeCode,
    @Path("id_chapter") int idChapter,
    @Body() Map<String, dynamic> body,
  );

  @POST("store/{store_code}/train_lessons")
  Future<AddLessonRes> addLesson(
      @Path("store_code") String? storeCode, @Body() Map<String, dynamic> body);

  @GET("store/{store_code}/train_courses/{courseId}/quiz")
  Future<AllQuizRes> getAllQuiz(
    @Path("store_code") String? storeCode,
    @Path("courseId") int? courseId,
  );

  @GET("store/{store_code}/train_courses/{courseId}/quiz/{quizId}")
  Future<SuccessResponse> deleteQuiz(
    @Path("store_code") String? storeCode,
    @Path("courseId") int? courseId,
    @Path("quizId") int? quizId,
  );

  @POST("store/{store_code}/train_courses/{courseId}/quiz")
  Future<QuizRes> createQuiz(
    @Path("store_code") String? storeCode,
    @Path("courseId") int? courseId,
    @Body() Map<String, dynamic> body,
  );

  @PUT("store/{store_code}/train_courses/{courseId}/quiz/{quizId}")
  Future<QuizRes> updateQuiz(
    @Path("store_code") String? storeCode,
    @Path("courseId") int? courseId,
    @Path("quizId") int? quizId,
    @Body() Map<String, dynamic> body,
  );

  @GET("store/{store_code}/train_courses/{courseId}/quiz/{quizId}")
  Future<QuizRes> getQuiz(
    @Path("store_code") String? storeCode,
    @Path("courseId") int? courseId,
    @Path("quizId") int? quizId,
  );

  @POST("store/{store_code}/train_courses/{courseId}/quiz/{quizId}/questions")
  Future<QuestionRes> createQuestion(
    @Path("store_code") String? storeCode,
    @Path("courseId") int? courseId,
    @Path("quizId") int? quizId,
    @Body() Map<String, dynamic> body,
  );

  @PUT(
      "store/{store_code}/train_courses/{courseId}/quiz/{quizId}/questions/{questionId}")
  Future<QuestionRes> updateQuestion(
    @Path("store_code") String? storeCode,
    @Path("courseId") int? courseId,
    @Path("quizId") int? quizId,
    @Path("questionId") int? questionId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE(
      "store/{store_code}/train_courses/{courseId}/quiz/{quizId}/questions/{questionId}")
  Future<SuccessResponse> deleteQuestion(
    @Path("store_code") String? storeCode,
    @Path("courseId") int? courseId,
    @Path("quizId") int? quizId,
    @Path("questionId") int? questionId,
  );

  @DELETE("store/{store_code}/train_lessons/{lesson_id}")
  Future<SuccessResponse> deleteLesson(
    @Path("store_code") String? storeCode,
    @Path("lesson_id") int lessonId,
  );

  @PUT("store/{store_code}/train_lessons/{lesson_id}")
  Future<AddLessonRes> updateLesson(
    @Path("store_code") String? storeCode,
    @Path("lesson_id") int lessonId,
    @Body() Map<String, dynamic> body,
  );

  /// group customer

  @GET("store/{store_code}/group_customers")
  Future<AllGroupCustomerRes> getAllGroupCustomer(
    @Path("store_code") String? storeCode,
    @Query("page") int? page,
    @Query("limit") int? limit,
  );

  @GET("store/{store_code}/group_customers/{groupId}")
  Future<GroupCustomerRes> getGroupCustomer(
    @Path("store_code") String? storeCode,
    @Path("groupId") int? groupId,
  );

   @GET("store/{store_code}/group_customers/{groupId}/customers")
  Future<AllCustomerResponse> getAllCustomer(
    @Path("store_code") String? storeCode,
    @Query("page") int page,
  );


  @POST("store/{store_code}/group_customers")
  Future<GroupCustomerRes> addGroupCustomer(
    @Path("store_code") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  @PUT("store/{store_code}/group_customers/{groupId}")
  Future<GroupCustomerRes> updateGroupCustomer(
    @Path("store_code") String? storeCode,
    @Path("groupId") int? groupId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("store/{store_code}/group_customers/{groupId}")
  Future<SuccessResponse> deleteGroupCustomer(
    @Path("store_code") String? storeCode,
    @Path("groupId") int? groupId,
  );

  /// operation history
  @GET("store/{store_code}/staff_sale_configs/overview_one_sale")
  Future<OverViewSaleRes> getOverviewOneSale(
    @Path("store_code") String storeCode,
    @Query("staff_id") int? staffId,
  );

  @GET("store/{store_code}/staff_sale/overview")
  Future<OverViewSaleRes> getOverviewSale(
    @Path("store_code") String storeCode,
    @Query("staff_id") int? staffId,
  );

  @GET("store/{store_code}/operation_histories")
  Future<AllOperationHistoryRes> getAllOperationHistory(
    @Path("store_code") String? storeCode,
    @Query("page") int currentPage,
    @Query("function_type") String? functionType,
    @Query("action_type") String? actionType,
    @Query("staff_id") int? staffId,
    @Query("branch_id") int? branchId,
  );

  //// mini game
  @GET("store/{store_code}/spin_wheels")
  Future<AllMiniGameRes> getAllMiniGame(
    @Path("store_code") String? storeCode,
    @Query("page") int currentPage,
    @Query("status") int? status,
  );

  @GET("store/{store_code}/spin_wheels/{id}")
  Future<MiniGameRes> getMiniGame(
    @Path("store_code") String? storeCode,
    @Path("id") int? id,
  );

  @POST("store/{store_code}/spin_wheels")
  Future<MiniGameRes> addMiniGame(
    @Path("store_code") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  @PUT("store/{store_code}/spin_wheels/{id}")
  Future<MiniGameRes> updateMiniGame(
    @Path("store_code") String? storeCode,
    @Path("id") int id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("store/{store_code}/spin_wheels/{id}")
  Future<SuccessResponse> deleteMiniGame(
    @Path("store_code") String? storeCode,
    @Path("id") int id,
  );
  //gift
  @GET("store/{store_code}/spin_wheels/{id}/gift_spin_wheels")
  Future<AllGiftRes> getAllGift(
    @Path("store_code") String? storeCode,
    @Path("id") int? id,
    @Query("page") int currentPage,
  );

  @GET("store/{store_code}/spin_wheels/{spin_id}/gift_spin_wheels/{id}")
  Future<GiftRes> getGift(
    @Path("store_code") String? storeCode,
    @Path("spin_id") int? spinId,
    @Path("id") int? id,
  );

  @POST("store/{store_code}/spin_wheels/{spin_id}/gift_spin_wheels")
  Future<GiftRes> addGift(
    @Path("store_code") String? storeCode,
    @Path("spin_id") int? spinId,
    @Body() Map<String, dynamic> body,
  );

  @PUT("store/{store_code}/spin_wheels/{spin_id}/gift_spin_wheels/{id}")
  Future<GiftRes> updateGift(
    @Path("store_code") String? storeCode,
    @Path("spin_id") int? spinId,
    @Path("id") int id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("store/{store_code}/spin_wheels/{spin_id}/gift_spin_wheels/{id}")
  Future<SuccessResponse> deleteGift(
    @Path("store_code") String? storeCode,
    @Path("spin_id") int? spinId,
    @Path("id") int id,
  );

  ////Guess number game
  @GET("store/{store_code}/guess_numbers")
  Future<AllGuessNumberGameRes> getAllGuessNumberGame(
    @Path("store_code") String? storeCode,
    @Query("page") int currentPage,
    @Query("status") int? status,
  );

  @GET("store/{store_code}/guess_numbers/{id}")
  Future<GuessNumberGameRes> getGuessNumberGame(
    @Path("store_code") String? storeCode,
    @Path("id") int? id,
  );

  @POST("store/{store_code}/guess_numbers")
  Future<GuessNumberGameRes> addGuessNumberGame(
    @Path("store_code") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  @PUT("store/{store_code}/guess_numbers/{id}")
  Future<GuessNumberGameRes> updateGuessNumberGame(
    @Path("store_code") String? storeCode,
    @Path("id") int id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("store/{store_code}/guess_numbers/{id}")
  Future<SuccessResponse> deleteGuessNumberGame(
    @Path("store_code") String? storeCode,
    @Path("id") int id,
  );

  /// sale

  @GET("store/{store_code}/staff_sale_configs/get_ids_customer_staff_sale_top")
  Future<ListIdCustomerStaffSaleTopRes> getIdCustomerStaffSaleTop(
    @Path("store_code") String? storeCode,
    @Query("date_from") String? dateFrom,
    @Query("date_to") String? dateTo,
    @Query("customer_type") int? customerType,
    @Query("staff_id") String? staffId,
    @Query("province_ids") String? provinceIds,
  );

  @GET("store/{store_code}/staff_sale_configs/staff_sale_top")
  Future<TopSaleRes> getTopSale(
    @Path("store_code") String? storeCode,
    @Query("page") int currentPage,
    @Query("date_from") String? dateFrom,
    @Query("date_to") String? dateTo,
    @Query("customer_type") int? customerType,
    @Query("staff_ids") String? staffIds,
    @Query("province_ids") String? provinceIds,
  );

  @GET("store/{store_code}/staff_sale_configs/overview_one_sale")
  Future<OverViewSaleRes> getOverViewSale(
    @Path("store_code") String? storeCode,
  );

  @GET("store/{store_code}/staff_sale_configs")
  Future<ConfigSaleRes> getConfigSale(
    @Path("store_code") String? storeCode,
  );

  @POST("store/{store_code}/staff_sale_configs")
  Future<ConfigSaleRes> setConfigSale(
    @Path("store_code") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  @GET("store/{storeCode}/staff_sale_configs/bonus_steps")
  Future<AllBonusLevelResponse> getBonusStepSale(
    @Path("storeCode") String? storeCode,
  );

  @POST("store/{storeCode}/staff_sale_configs/bonus_steps")
  Future<SuccessResponse> addLevelBonusSale(
    @Path("storeCode") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  @PUT("store/{storeCode}/staff_sale_configs/bonus_steps/{idLevel}")
  Future<UpdateBonusLevelResponse> updateLevelBonusSale(
    @Path("storeCode") String? storeCode,
    @Path("idLevel") int idLevel,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("store/{storeCode}/staff_sale_configs/bonus_steps/{idLevel}")
  Future<SuccessResponse> deleteLevelBonusSale(
    @Path("storeCode") String? storeCode,
    @Path("idLevel") int idLevel,
  );

  @POST("store/{storeCode}/staff_sale_configs/add_customers_to_sale")
  Future<SuccessResponse> addCustomerToSale(
    @Path("storeCode") String? storeCode,
    @Body() Map<String, dynamic> body,
  );

  /// Attribute Search

  @GET("store/{storeCode}/attribute_searches")
  Future<ListAttributeSearchRes> getAttributeSearch(
    @Path("storeCode") String? storeCode,
  );

  @POST("store/{storeCode}/attribute_search/sort")
  Future<SuccessResponse> sortAttributeSearch(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @DELETE("store/{storeCode}/attribute_searches/{attributeId}")
  Future<SuccessResponse> deleteAttributeSearch(
      @Path("storeCode") String? storeCode,
      @Path("attributeId") int? attributeId);

  @DELETE(
      "store/{storeCode}/attribute_searches/{attributeId}/product_attribute_search_children/{attributeChildId}")
  Future<SuccessResponse> deleteAttributeChild(
    @Path("storeCode") String? storeCode,
    @Path("attributeId") int? attributeId,
    @Path("attributeChildId") int? attributeChildId,
  );

  @POST("store/{storeCode}/attribute_searches")
  Future<AttributeSearchRes> createAttributeSearch(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @POST("store/{storeCode}/attribute_searches/{attributeSearchId}")
  Future<AttributeSearchRes> updateAttributeSearch(
      @Path("storeCode") String? storeCode,
      @Path("attributeSearchId") int? attributeSearchId,
      @Body() Map<String, dynamic> body);

  @POST(
      "store/{storeCode}/attribute_searches/{attributeSearchId}/product_attribute_search_children")
  Future<AttributeSearchRes> createAttributeSearchChild(
      @Path("storeCode") String? storeCode,
      @Path("attributeSearchId") int? attributeSearchId,
      @Body() Map<String, dynamic> body);

  @POST(
      "store/{storeCode}/attribute_searches/{attributeSearchId}/product_attribute_search_children/{attributeSearchChildId}")
  Future<AttributeSearchRes> updateAttributeSearchChild(
      @Path("storeCode") String? storeCode,
      @Path("attributeSearchId") int? attributeSearchId,
      @Path("attributeSearchChildId") int? attributeSearchChildId,
      @Body() Map<String, dynamic> body);

  @DELETE(
      "store/{storeCode}/attribute_searches/{attributeSearchId}/product_atribute_search_children/{attributeSearchChildId}")
  Future<SuccessResponse> deleteAttributeSearchChild(
    @Path("storeCode") String? storeCode,
    @Path("attributeSearchId") int? attributeSearchId,
    @Path("attributeSearchChildId") int? attributeSearchChildId,
  );
  /////////E Commerce

  @GET("store/{storeCode}/ecommerce/connect/list")
  Future<AllECommerceRes> getAllEcommerce(
    @Path("storeCode") String? storeCode,
    @Query("platform_name") String? platformName,
  );
  @GET("store/{storeCode}/ecommerce/db/products")
  Future<AllProductCommerceRes> getAllProductCommerce(
    @Path("storeCode") String? storeCode,
    @Query("page") int page,
    @Query("branch_id") int? branchId,
    @Query("sku_pair_type") int? skuPairType,
    @Query("shop_ids") String shopId,
  );

  @POST("store/{storeCode}/ecommerce/products/sync")
  Future<SyncRes> syncProduct(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @GET("store/{storeCode}/ecommerce/db/products/{id}")
  Future<ProductCommerceRes> getProducCommerce(
    @Path("storeCode") String? storeCode,
    @Path("id") int idProduct,
    @Query("shop_ids") String shopId,
  );

  @PUT("store/{storeCode}/ecommerce/db/products/{id}")
  Future<ProductCommerceRes> updateProductCommerce(
    @Path("storeCode") String? storeCode,
    @Path("id") int idProduct,
    @Body() Map<String, dynamic> body,
  );
  @POST("store/{storeCode}/ecommerce/orders/sync")
  Future<SyncRes> syncOrder(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);

  @GET("store/{storeCode}/ecommerce/db/orders")
  Future<AllOrderCommerceRes> getAllOrderCommerce(
    @Path("storeCode") String? storeCode,
    @Query("page") int page,
    @Query("shop_ids") String shopIds,
    @Query("order_statuses") String? orderStatus,
    @Query("created_from_date") String? startDate,
    @Query("created_to_date") String? endDate,
  );

  @GET("store/{storeCode}/ecommerce/db/orders/{orderCode}")
  Future<OrderCommerceRes> getOrderCommerce(
    @Path("storeCode") String? storeCode,
    @Path("orderCode") String? orderCode,
  );

  @PUT("store/{storeCode}/ecommerce/connect/list/{id}")
  Future<ECommerceRes> updateCommerce(
    @Path("storeCode") String? storeCode,
    @Path("id") String shopId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("store/{storeCode}/ecommerce/connect/list/{id}")
  Future<SuccessResponse> deleteCommerce(
    @Path("storeCode") String? storeCode,
    @Path("id") String? shopId,
  );

  @GET("store/{storeCode}/ecommerce/warehouses")
  Future<AllWarehousesRes> getAllWarehouses(
    @Path("storeCode") String? storeCode,
    @Query("shop_id") String shopId,
  );

  @PUT("store/{storeCode}/ecommerce/warehouses/{warehouseId}")
  Future<WarehousesRes> updateWarehouses(
    @Path("storeCode") String? storeCode,
    @Path("warehouseId") int warehouseId,
    @Body() Map<String, dynamic> body,
  );

  @GET("store/{storeCode}/collaborator_register_requests")
  Future<AllCollaboratorRegisterRequestRes> getAllCollaboratorRegisterRequest(
    @Path("storeCode") String? storeCode,
    @Query("page") int page,
    @Query("status") int? status,
  );

  @PUT("store/{storeCode}/collaborator_register_requests/{requestId}/status")
  Future<SuccessResponse> updateStatusCollaboratorRequest(
    @Path("storeCode") String? storeCode,
    @Path("requestId") int requestId,
    @Body() Map<String, dynamic> body,
  );

  @GET("store/{storeCode}/sale_visit_agencies")
  Future<AllHistoryCheckInRes> getAllHistoryCheckIn(
    @Path("storeCode") String? storeCode,
    @Query("page") int page,
    @Query("agency_id") int? agencyId,
  );

  @GET("store/{storeCode}/sale_visit_agencies/{id}")
  Future<HistoryCheckInRes> getHistoryCheckIn(
    @Path("storeCode") String? storeCode,
    @Path("id") int idHistory,
  );

  @POST("store/{storeCode}/sale_visit_agencies")
  Future<SaleCheckInRes> checkInAgency(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);
  @PUT("store/{storeCode}/sale_visit_agencies/{id_checkin}")
  Future<SaleCheckInRes> checkOutAgency(@Path("storeCode") String? storeCode,
      @Path("id_checkin") int? idCheckin, @Body() Map<String, dynamic> body);

  @GET("store/{storeCode}/bonus_product/{bonusProductId}/bonus_product_item")
  Future<BonusProductRes> getBonusProductItem(
    @Path("storeCode") String? storeCode,
    @Path("bonusProductId") int bonusProductId,
    @Query("group_product") int groupProduct,
  );

  @POST("store/{storeCode}/bonus_product/{bonusProductId}/bonus_product_item")
  Future<BonusProductRes> addBonusProductItem(
      @Path("storeCode") String? storeCode,
      @Path("bonusProductId") int bonusProductId,
      @Body() Map<String, dynamic> body);
  @PUT("store/{storeCode}/bonus_product/{bonusProductId}/bonus_product_item")
  Future<BonusProductRes> updateBonusProductItem(
      @Path("storeCode") String? storeCode,
      @Path("bonusProductId") int bonusProductId,
      @Body() Map<String, dynamic> body);

  @DELETE("store/{storeCode}/bonus_product/{bonusProductId}/bonus_product_item")
  Future<SuccessResponse> deleteBonusProductItem(
      @Path("storeCode") String? storeCode,
      @Path("bonusProductId") int bonusProductId,
      @Body() Map<String, dynamic> body);

  @GET("store/{storeCode}/vouchers/{vopucherId}/codes")
  Future<AllVoucherCodeRes> getAllVoucherCode(
    @Path("storeCode") String? storeCode,
    @Path("vopucherId") int? voucherId,
    @Query("page") int page,
    @Query("status") int? status,
    @Query("search") String? search,
  );

  @PUT("store/{storeCode}/vouchers/{vopucherId}/codes")
  Future<SuccessResponse> endVoucherCode(@Path("storeCode") String? storeCode,
      @Path("vopucherId") int voucherId, @Body() Map<String, dynamic> body);
  @GET("store/{storeCode}/vouchers/{id}")
  Future<VoucherRes> getVoucher(
    @Path("storeCode") String? storeCode,
    @Path("id") int idHistory,
  );
  @GET("store/{storeCode}/vouchers/{id}/products")
  Future<AllProductVoucherRes> getAllProductVoucher(
    @Query("page") int page,
    @Path("storeCode") String? storeCode,
    @Path("id") int idHistory,
  );

  @POST("store/{storeCode}/shipment_get_token/vietnam_post")
  Future<LoginVietNamPostRes> loginVietnamPost(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);
  @POST("store/{storeCode}/shipment_get_token/viettel")
  Future<LoginViettelPostRes> loginViettelPost(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);
  @POST("store/{storeCode}/shipment_get_token/nhat_tin")
  Future<LoginViettelPostRes> loginNhatTin(
      @Path("storeCode") String? storeCode, @Body() Map<String, dynamic> body);
}
