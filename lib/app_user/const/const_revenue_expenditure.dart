const RECIPIENT_GROUP_CUSTOMER = 0; //Nhóm khách hàng
const RECIPIENT_GROUP_SUPPLIER = 1; //Nhóm nhà cung cấp
const RECIPIENT_GROUP_STAFF = 2; //Nhóm nhân viên
const RECIPIENT_GROUP_OTHER = 3; //Đối tượng khác

/// thu
const TYPE_PAYMENT_ORDERS = 0; //Thanh toán cho đơn hàng
const TYPE_OTHER_INCOME = 1; //Thu nhập khác
const TYPE_BONUS = 2; //Tiền thưởng
const TYPE_INDEMNIFICATION = 3; //Khởi tạo kho
const TYPE_RENTAL_PROPERTY = 4; //cho thuê tài sản
const TYPE_SALE_AND_LIQUIDATION_OF_ASSETS = 5; //Nhượng bán thanh lý tài sản
const TYPE_DEBT_COLLECTION_CUSTOMERS = 6; //Thu nợ khách hàng

/// chi
const TYPE_OTHER_COSTS = 10; // Chi phí khác
const TYPE_PRODUCTION_COST = 11; // Chi phí sản phẩm
const TYPE_COST_OF_RAW_MATERIALS = 12; //chi phí nguyên vật liệu
const TYPE_COST_OF_LIVING = 13; // Chi  phí sinh hoạt
const TYPE_LABOR_COSTS = 14; // Chi phí nhân công
const TYPE_SELLING_EXPENSES = 15; // chi phí bán hàng
const TYPE_STORE_MANAGEMENT_COSTS = 16; // Chi phí quản lý cửa hàng

/// payment method
const PAYMENT_TYPE_CASH = 0; //Tiền mặt
const PAYMENT_TYPE_SWIPE = 1; // Quẹt
const PAYMENT_TYPE_COD = 2; //COD
const PAYMENT_TYPE_TRANSFER = 3; //Chuyển khoản

/// type history inventory
const TYPE_EDIT_STOCK = 0; //Cân bằng sửa kho
const TYPE_TALLY_SHEET_STOCK = 1; //Cân bằng kiểm kho
const TYPE_IMPORT_STOCK = 2; //Nhập kho
const TYPE_INIT_STOCK = 3; //Khởi tạo kho

/// status import stock
const STATUS_IMPORT_STOCK_ORDER = 0; //Đặt hàng
const STATUS_IMPORT_STOCK_BROWSING = 1; //Duyệt
const STATUS_IMPORT_STOCK_WAREHOUSE = 2; //Nhập kho
const STATUS_IMPORT_STOCK_COMPLETED = 3; //Hoàn thành
const STATUS_IMPORT_STOCK_CANCELED = 4; //Đã hủy
const STATUS_IMPORT_STOCK_PAUSE = 5; //Kết thúc
const STATUS_IMPORT_STOCK_REFUND = 6; //Trả hàng
