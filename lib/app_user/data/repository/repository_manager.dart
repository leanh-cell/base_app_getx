import 'package:com.ikitech.store/app_user/data/repository/education/education_reposition.dart';
import 'package:com.ikitech.store/app_user/data/repository/mini_game/mini_game_repository.dart';

import 'address/address_repository.dart';
import 'agency/agency_repository.dart';
import 'attribute_search/attribute_search_repo.dart';
import 'attributes/attributes_repository.dart';
import 'badge/badge_repository.dart';
import 'branch/branch_repository.dart';
import 'cart/cart_repository.dart';
import 'category/category_repository.dart';
import 'chat/chat_repository.dart';
import 'community/community_repository.dart';
import 'config_noti/config_notification_repository.dart';
import 'config_ui/config_ui_repository.dart';
import 'ctv/ctv_repository.dart';
import 'customer/customer_repository.dart';
import 'decentralization/decentralization_repository.dart';
import 'device_token/device_token_repository.dart';
import 'distribute/distribute_repository.dart';
import 'e_commerce/e_commerce_repo.dart';
import 'general_setting/general_setting_repository.dart';
import 'home_data/home_data_reponsitory.dart';
import 'image/image_repository.dart';
import 'import_stock/import_stock_repository.dart';
import 'inventory/inventory_repository.dart';
import 'login/login_repository.dart';
import 'marketing_chanel/marketing_chanel_repository.dart';
import 'notification/notification_repository.dart';
import 'order/order_repository.dart';
import 'otp/otp_repository.dart';
import 'payment_method/payment_repository.dart';
import 'point/piont_repository.dart';
import 'popup/popup_repository.dart';
import 'post/post_repository.dart';
import 'product/product_repository.dart';
import 'register/register_repository.dart';
import 'report/report_repository.dart';
import 'revenue_expenditure/revenue_expenditure_repository.dart';
import 'review/review_repository.dart';
import 'sale/sale_repo.dart';
import 'staff/staff_repository.dart';
import 'store/store_repository.dart';
import 'supplier/supplier_repository.dart';
import 'time_keeping/time_keeping_repository.dart';
import 'transfer_stock/transfer_stock_repository.dart';
import 'type_of_shop/type_of_shop_repository.dart';
import 'user/user_repository.dart';

class RepositoryManager {
  static ProductRepository get productRepository => ProductRepository();

  static RegisterRepository get registerRepository => RegisterRepository();

  static StoreRepository get storeRepository => StoreRepository();

  static LoginRepository get loginRepository => LoginRepository();

  static TypeOfShopRepository get typeOfShopRepository =>
      TypeOfShopRepository();

  static CategoryRepository get categoryRepository => CategoryRepository();

  static ImageRepository get imageRepository => ImageRepository();

  static DeviceTokenRepository get deviceTokenRepository =>
      DeviceTokenRepository();

  static MarketingChanelRepository get marketingChanel =>
      MarketingChanelRepository();

  static ConfigUIRepository get configUiRepository => ConfigUIRepository();

  static PostRepository get postRepository => PostRepository();

  static AddressRepository get addressRepository => AddressRepository();

  static ChatRepository get chatRepository => ChatRepository();

  static PaymentRepository get paymentRepository => PaymentRepository();

  static OrderRepository get orderRepository => OrderRepository();

  static CustomerRepository get customerRepository => CustomerRepository();

  static ReportRepository get reportRepository => ReportRepository();

  static AttributesRepository get attributesRepository =>
      AttributesRepository();

  static ReviewRepository get reviewRepository => ReviewRepository();

  static BadgeRepository get badgeRepository => BadgeRepository();

  static HomeDataRepository get homeDataRepository => HomeDataRepository();

  static ProfileRepository get profileRepository => ProfileRepository();

  static ConfigNotificationRepository get configNotificationRepository =>
      ConfigNotificationRepository();

  static CtvRepository get ctvRepository => CtvRepository();

  static PopupRepository get popupRepository => PopupRepository();

  static PointRepository get pointRepository => PointRepository();

  static NotificationRepository get notificationRepository =>
      NotificationRepository();

  static DecentralizationRepository get decentralizationRepository =>
      DecentralizationRepository();

  static StaffRepository get staffRepository => StaffRepository();

  static AgencyRepository get agencyRepository => AgencyRepository();

  static CartRepository get cartRepository => CartRepository();

  static OtpRepository get otpRepository => OtpRepository();

  static BranchRepository get branchRepository => BranchRepository();

  static InventoryRepository get inventoryRepository => InventoryRepository();

  static SupplierRepository get supplierRepository => SupplierRepository();

  static ImportStockRepository get importStockRepository =>
      ImportStockRepository();

  static RevenueExpenditureRepository get revenueExpenditureRepository =>
      RevenueExpenditureRepository();

  static GeneralSettingRepository get generalSettingRepository =>
      GeneralSettingRepository();

  static DistributeRepository get distributeRepository =>
      DistributeRepository();

  static TimeKeepingRepository get timeKeepingRepository =>
      TimeKeepingRepository();

  static TransferStockRepository get transferStockRepository =>
      TransferStockRepository();

  static CommunityRepository get communityRepository => CommunityRepository();

  static EducationReposition get educationReposition => EducationReposition();
  static MiniGameRepository get miniGameRepository => MiniGameRepository();
  static SaleRepo get saleRepo => SaleRepo();
  static AttributeSearchRepo get attributeSearchRepo => AttributeSearchRepo();
  static EcommerceRepo get eCommerceRepo => EcommerceRepo();
}
