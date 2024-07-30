class Decentralization {
  int? id;
  int? storeId;
  String? name;
  String? description;
  bool? productList;
  bool? productAdd;
  bool? productUpdate;
  bool? productCopy;
  bool? productRemoveHide;
  bool? productCategoryList;
  bool? productCategoryAdd;
  bool? productCategoryUpdate;
  bool? productCategoryRemove;
  bool? productAttributeList;
  bool? productAttributeAdd;
  bool? productAttributeUpdate;
  bool? productAttributeRemove;
  bool? productEcommerce;
  bool? productCommission;
  bool? productImportFromExcel;
  bool? productExportToExcel;
  bool? customerList;
  bool? customerConfigPoint;
  bool? customerReviewList;
  bool? customerReviewCensorship;
  bool? promotionDiscountList;
  bool? promotionDiscountAdd;
  bool? promotionDiscountUpdate;
  bool? promotionDiscountEnd;
  bool? promotionVoucherList;
  bool? promotionVoucherAdd;
  bool? promotionVoucherUpdate;
  bool? promotionVoucherEnd;
  bool? promotionComboList;
  bool? promotionComboAdd;
  bool? promotionComboUpdate;
  bool? promotionComboEnd;
  bool? promotionBonusProductList;
  bool? promotionBonusProductAdd;
  bool? promotionBonusProductUpdate;
  bool? promotionBonusProductEnd;
  bool? postList;
  bool? postAdd;
  bool? postUpdate;
  bool? postRemoveHide;
  bool? postCategoryList;
  bool? postCategoryAdd;
  bool? postCategoryUpdate;
  bool? postCategoryRemove;
  bool? appThemeEdit;
  bool? appThemeMainConfig;
  bool? appThemeButtonContact;
  bool? appThemeHomeScreen;
  bool? appThemeMainComponent;
  bool? appThemeCategoryProduct;
  bool? appThemeProductScreen;
  bool? appThemeContactScreen;
  bool? configSetting;
  bool? invoiceTemplate;
  bool? webThemeEdit;
  bool? webThemeOverview;
  bool? webThemeContact;
  bool? webThemeHelp;
  bool? webThemeFooter;
  bool? webThemeBanner;
  bool? webThemeSeo;
  bool? deliveryPickAddressList;
  bool? deliveryPickAddressUpdate;
  bool? deliveryProviderUpdate;
  bool? paymentList;
  bool? paymentOnOff;
  bool? notificationScheduleList;
  bool? notificationScheduleAdd;
  bool? notificationScheduleRemovePause;
  bool? notificationScheduleUpdate;
  bool? popupList;
  bool? popupAdd;
  bool? popupUpdate;
  bool? popupRemove;
  bool? promotion;
  bool? orderList;
  bool? orderImportFromExcel;
  bool? orderExportToExcel;
  bool? orderAllowChangeStatus;
  bool? collaboratorConfig;
  bool? collaboratorList;
  bool? collaboratorRegister;
  bool? collaboratorTopSale;
  bool? collaboratorPaymentRequestList;
  bool? collaboratorPaymentRequestSolve;
  bool? collaboratorPaymentRequestHistory;
  bool? collaboratorAddSubBalance;
  bool? agencyPaymentRequestHistory;
  bool? notificationToStote;
  bool? agencyConfig;
  bool? agencyPaymentRequestList;
  bool? agencyPaymentRequestSolve;
  bool? agencyAddSubBalance;
  bool? chatList;
  bool? chatAllow;
  bool? reportView;
  bool? reportOverview;
  bool? reportProduct;
  bool? reportOrder;
  bool? reportFinance;
  bool? reportInventory;
  bool? decentralizationList;
  bool? decentralizationUpdate;
  bool? decentralizationAdd;
  bool? decentralizationRemove;
  bool? staffList;
  bool? staffUpdate;
  bool? staffAdd;
  bool? staffRemove;
  bool? staffDelegating;
  bool? agencyList;
  bool? agencyRegister;
  bool? agencyTopImport;
  bool? agencyTopCommission;
  bool? agencyBonusProgram;
  bool? storeInfo;
  bool? inventoryList;
  bool? inventoryImport;
  bool? inventoryTallySheet;
  bool? revenueExpenditure;
  bool? accountantTimeSheet;
  bool? addRevenue;
  bool? addExpenditure;
  bool? settingPrint;
  bool? branchList;
  bool? createOrderPos;
  bool? supplier;
  bool? barcodePrint;
  bool? timekeeping;
  bool? transferStock;
  bool? onsale;
  bool? train;
  bool? overview;
  bool? vipEdit;
  bool? onsaleList;
  bool? onsaleEdit;
  bool? onsaleAdd;
  bool? onsaleRemove;
  bool? onsaleAssignment;
  bool? gamification;
  bool? saleList;
  bool? saleConfig;
  bool? saleTop;
  bool? ecommerceList;
  bool? ecommerceProducts;
  bool? ecommerceConnect;
  bool? ecommerceOrders;
  bool? ecommerceInventory;
  bool? configSms;
  bool? bannerAds;
  bool? groupCustomer;
  bool? historyOperation;
  bool? customerRoleEdit;
  bool? changePricePos;
  bool? agencyChangeLevel;
  bool? communicationList;
  bool? communicationUpdate;
  bool? communicationDelete;
  bool? communicationAdd;
  bool? communicationApprove;
  bool? trainAdd;
  bool? trainUpdate;
  bool? trainExamList;
  bool? trainExamAdd;
  bool? trainExamUpdate;
  bool? trainExamDelete;
  bool? changeDiscountPos;

  DateTime? createdAt;
  DateTime? updatedAt;

  Decentralization({
    this.id,
    this.storeId,
    this.name,
    this.description,
    this.productList,
    this.productAdd,
    this.productUpdate,
    this.productCopy,
    this.productRemoveHide,
    this.productCategoryList,
    this.productCategoryAdd,
    this.productCategoryUpdate,
    this.productCategoryRemove,
    this.productAttributeList,
    this.productAttributeAdd,
    this.productAttributeUpdate,
    this.productAttributeRemove,
    this.productEcommerce,
    this.productCommission,
    this.productImportFromExcel,
    this.productExportToExcel,
    this.customerList,
    this.customerConfigPoint,
    this.customerReviewList,
    this.customerReviewCensorship,
    this.promotionDiscountList,
    this.promotionDiscountAdd,
    this.promotionDiscountUpdate,
    this.promotionDiscountEnd,
    this.promotionVoucherList,
    this.promotionVoucherAdd,
    this.promotionVoucherUpdate,
    this.promotionVoucherEnd,
    this.promotionComboList,
    this.promotionComboAdd,
    this.promotionComboUpdate,
    this.promotionComboEnd,
    this.promotionBonusProductList,
    this.promotionBonusProductAdd,
    this.promotionBonusProductUpdate,
    this.promotionBonusProductEnd,
    this.postList,
    this.postAdd,
    this.postUpdate,
    this.postRemoveHide,
    this.postCategoryList,
    this.postCategoryAdd,
    this.postCategoryUpdate,
    this.postCategoryRemove,
    this.appThemeEdit,
    this.appThemeMainConfig,
    this.appThemeButtonContact,
    this.appThemeHomeScreen,
    this.appThemeMainComponent,
    this.appThemeCategoryProduct,
    this.appThemeProductScreen,
    this.appThemeContactScreen,
    this.configSetting,
    this.invoiceTemplate,
    this.webThemeEdit,
    this.webThemeOverview,
    this.webThemeContact,
    this.webThemeHelp,
    this.webThemeFooter,
    this.webThemeBanner,
    this.webThemeSeo,
    this.deliveryPickAddressList,
    this.deliveryPickAddressUpdate,
    this.deliveryProviderUpdate,
    this.paymentList,
    this.paymentOnOff,
    this.notificationScheduleList,
    this.notificationScheduleAdd,
    this.notificationScheduleRemovePause,
    this.notificationScheduleUpdate,
    this.popupList,
    this.popupAdd,
    this.popupUpdate,
    this.popupRemove,
    this.promotion,
    this.orderList,
    this.orderImportFromExcel,
    this.orderExportToExcel,
    this.orderAllowChangeStatus,
    this.collaboratorConfig,
    this.collaboratorList,
    this.collaboratorRegister,
    this.collaboratorTopSale,
    this.collaboratorPaymentRequestList,
    this.collaboratorPaymentRequestSolve,
    this.collaboratorPaymentRequestHistory,
    this.collaboratorAddSubBalance,
    this.agencyPaymentRequestHistory,
    this.notificationToStote,
    this.agencyConfig,
    this.agencyPaymentRequestList,
    this.agencyPaymentRequestSolve,
    this.agencyAddSubBalance,
    this.chatList,
    this.chatAllow,
    this.reportView,
    this.reportOverview,
    this.reportProduct,
    this.reportOrder,
    this.reportFinance,
    this.reportInventory,
    this.decentralizationList,
    this.decentralizationUpdate,
    this.decentralizationAdd,
    this.decentralizationRemove,
    this.staffList,
    this.staffUpdate,
    this.staffAdd,
    this.staffRemove,
    this.staffDelegating,
    this.agencyList,
    this.agencyRegister,
    this.agencyTopImport,
    this.agencyTopCommission,
    this.agencyBonusProgram,
    this.storeInfo,
    this.inventoryList,
    this.inventoryImport,
    this.inventoryTallySheet,
    this.revenueExpenditure,
    this.accountantTimeSheet,
    this.addRevenue,
    this.addExpenditure,
    this.settingPrint,
    this.branchList,
    this.createOrderPos,
    this.supplier,
    this.barcodePrint,
    this.timekeeping,
    this.transferStock,
    this.onsale,
    this.train,
    this.overview,
    this.vipEdit,
    this.onsaleList,
    this.onsaleEdit,
    this.onsaleAdd,
    this.onsaleRemove,
    this.onsaleAssignment,
    this.gamification,
    this.saleList,
    this.saleConfig,
    this.saleTop,
    this.ecommerceList,
    this.ecommerceProducts,
    this.ecommerceConnect,
    this.ecommerceOrders,
    this.ecommerceInventory,
    this.configSms,
    this.bannerAds,
    this.groupCustomer,
    this.historyOperation,
    this.customerRoleEdit,
    this.changePricePos,
    this.agencyChangeLevel,
    this.communicationAdd,
    this.communicationApprove,
    this.communicationDelete,
    this.communicationList,
    this.communicationUpdate,
    this.trainAdd,
    this.trainExamAdd,
    this.trainExamDelete,
    this.trainExamList,
    this.trainExamUpdate,
    this.trainUpdate,
    this.changeDiscountPos,
    this.createdAt,
    this.updatedAt,
  });

  factory Decentralization.fromJson(Map<String, dynamic> json) =>
      Decentralization(
        id: json["id"],
        storeId: json["store_id"],
        name: json["name"],
        description: json["description"],
        productList: json["product_list"],
        productAdd: json["product_add"],
        productUpdate: json["product_update"],
        productCopy: json["product_copy"],
        productRemoveHide: json["product_remove_hide"],
        productCategoryList: json["product_category_list"],
        productCategoryAdd: json["product_category_add"],
        productCategoryUpdate: json["product_category_update"],
        productCategoryRemove: json["product_category_remove"],
        productAttributeList: json["product_attribute_list"],
        productAttributeAdd: json["product_attribute_add"],
        productAttributeUpdate: json["product_attribute_update"],
        productAttributeRemove: json["product_attribute_remove"],
        productEcommerce: json["product_ecommerce"],
        productCommission: json["product_commission"],
        productImportFromExcel: json["product_import_from_excel"],
        productExportToExcel: json["product_export_to_excel"],
        customerList: json["customer_list"],
        customerConfigPoint: json["customer_config_point"],
        customerReviewList: json["customer_review_list"],
        customerReviewCensorship: json["customer_review_censorship"],
        promotionDiscountList: json["promotion_discount_list"],
        promotionDiscountAdd: json["promotion_discount_add"],
        promotionDiscountUpdate: json["promotion_discount_update"],
        promotionDiscountEnd: json["promotion_discount_end"],
        promotionVoucherList: json["promotion_voucher_list"],
        promotionVoucherAdd: json["promotion_voucher_add"],
        promotionVoucherUpdate: json["promotion_voucher_update"],
        promotionVoucherEnd: json["promotion_voucher_end"],
        promotionComboList: json["promotion_combo_list"],
        promotionComboAdd: json["promotion_combo_add"],
        promotionComboUpdate: json["promotion_combo_update"],
        promotionComboEnd: json["promotion_combo_end"],
        promotionBonusProductList: json["promotion_bonus_product_list"],
        promotionBonusProductAdd: json["promotion_bonus_product_add"],
        promotionBonusProductUpdate: json["promotion_bonus_product_update"],
        promotionBonusProductEnd: json["promotion_bonus_product_end"],
        postList: json["post_list"],
        postAdd: json["post_add"],
        postUpdate: json["post_update"],
        postRemoveHide: json["post_remove_hide"],
        postCategoryList: json["post_category_list"],
        postCategoryAdd: json["post_category_add"],
        postCategoryUpdate: json["post_category_update"],
        postCategoryRemove: json["post_category_remove"],
        appThemeEdit: json["app_theme_edit"],
        appThemeMainConfig: json["app_theme_main_config"],
        appThemeButtonContact: json["app_theme_button_contact"],
        appThemeHomeScreen: json["app_theme_home_screen"],
        appThemeMainComponent: json["app_theme_main_component"],
        appThemeCategoryProduct: json["app_theme_category_product"],
        appThemeProductScreen: json["app_theme_product_screen"],
        appThemeContactScreen: json["app_theme_contact_screen"],
        configSetting: json["config_setting"],
        invoiceTemplate: json["invoice_template"],
        webThemeEdit: json["web_theme_edit"],
        webThemeOverview: json["web_theme_overview"],
        webThemeContact: json["web_theme_contact"],
        webThemeHelp: json["web_theme_help"],
        webThemeFooter: json["web_theme_footer"],
        webThemeBanner: json["web_theme_banner"],
        webThemeSeo: json["web_theme_seo"],
        deliveryPickAddressList: json["delivery_pick_address_list"],
        deliveryPickAddressUpdate: json["delivery_pick_address_update"],
        deliveryProviderUpdate: json["delivery_provider_update"],
        paymentList: json["payment_list"],
        paymentOnOff: json["payment_on_off"],
        notificationScheduleList: json["notification_schedule_list"],
        notificationScheduleAdd: json["notification_schedule_add"],
        notificationScheduleRemovePause:
            json["notification_schedule_remove_pause"],
        notificationScheduleUpdate: json["notification_schedule_update"],
        popupList: json["popup_list"],
        popupAdd: json["popup_add"],
        popupUpdate: json["popup_update"],
        popupRemove: json["popup_remove"],
        promotion: json["promotion"],
        orderList: json["order_list"],
        orderImportFromExcel: json["order_import_from_excel"],
        orderExportToExcel: json["order_export_to_excel"],
        orderAllowChangeStatus: json["order_allow_change_status"],
        collaboratorConfig: json["collaborator_config"],
        collaboratorList: json["collaborator_list"],
        collaboratorRegister: json["collaborator_register"],
        collaboratorTopSale: json["collaborator_top_sale"],
        collaboratorPaymentRequestList:
            json["collaborator_payment_request_list"],
        collaboratorPaymentRequestSolve:
            json["collaborator_payment_request_solve"],
        collaboratorPaymentRequestHistory:
            json["collaborator_payment_request_history"],
        collaboratorAddSubBalance: json["collaborator_add_sub_balance"],
        agencyPaymentRequestHistory: json["agency_payment_request_history"],
        notificationToStote: json["notification_to_stote"],
        agencyConfig: json["agency_config"],
        agencyPaymentRequestList: json["agency_payment_request_list"],
        agencyPaymentRequestSolve: json["agency_payment_request_solve"],
        agencyAddSubBalance: json["agency_add_sub_balance"],
        chatList: json["chat_list"],
        chatAllow: json["chat_allow"],
        reportView: json["report_view"],
        reportOverview: json["report_overview"],
        reportProduct: json["report_product"],
        reportOrder: json["report_order"],
        reportFinance: json["report_finance"],
        reportInventory: json["report_inventory"],
        decentralizationList: json["decentralization_list"],
        decentralizationUpdate: json["decentralization_update"],
        decentralizationAdd: json["decentralization_add"],
        decentralizationRemove: json["decentralization_remove"],
        staffList: json["staff_list"],
        staffUpdate: json["staff_update"],
        staffAdd: json["staff_add"],
        staffRemove: json["staff_remove"],
        staffDelegating: json["staff_delegating"],
        agencyList: json["agency_list"],
        agencyRegister: json["agency_register"],
        agencyTopImport: json["agency_top_import"],
        agencyTopCommission: json["agency_top_commission"],
        agencyBonusProgram: json["agency_bonus_program"],
        storeInfo: json["store_info"],
        inventoryList: json["inventory_list"],
        inventoryImport: json["inventory_import"],
        inventoryTallySheet: json["inventory_tally_sheet"],
        revenueExpenditure: json["revenue_expenditure"],
        accountantTimeSheet: json["accountant_time_sheet"],
        addRevenue: json["add_revenue"],
        addExpenditure: json["add_expenditure"],
        settingPrint: json["setting_print"],
        branchList: json["branch_list"],
        createOrderPos: json["create_order_pos"],
        supplier: json["supplier"],
        barcodePrint: json["barcode_print"],
        timekeeping: json["timekeeping"],
        transferStock: json["transfer_stock"],
        onsale: json["onsale"],
        train: json["train"],
        overview: json["overview"],
        vipEdit: json["vip_edit"],
        onsaleList: json["onsale_list"],
        onsaleEdit: json["onsale_edit"],
        onsaleAdd: json["onsale_add"],
        onsaleRemove: json["onsale_remove"],
        onsaleAssignment: json["onsale_assignment"],
        gamification: json["gamification"],
        saleList: json["sale_list"],
        saleConfig: json["sale_config"],
        saleTop: json["sale_top"],
        ecommerceList: json["ecommerce_list"],
        ecommerceProducts: json["ecommerce_products"],
        ecommerceConnect: json["ecommerce_connect"],
        ecommerceOrders: json["ecommerce_orders"],
        ecommerceInventory: json["ecommerce_inventory"],
        configSms: json["config_sms"],
        bannerAds: json["banner_ads"],
        groupCustomer: json["group_customer"],
        historyOperation: json["history_operation"],
        customerRoleEdit: json["customer_role_edit"],
        changePricePos: json["change_price_pos"],
        agencyChangeLevel: json["agency_change_level"],
        communicationList: json["communication_list"],
        communicationUpdate: json["communication_update"],
        communicationAdd: json["communication_add"],
        communicationDelete: json["communication_delete"],
        communicationApprove: json["communication_approve"],
        trainAdd: json["train_add"],
        trainUpdate: json["train_update"],
        trainExamList: json["train_exam_list"],
        trainExamAdd: json["train_exam_add"],
        trainExamUpdate: json["train_exam_update"],
        trainExamDelete: json["train_exam_delete"],
        changeDiscountPos:json["change_discount_pos"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "name": name,
        "description": description,
        "product_list": productList,
        "product_add": productAdd,
        "product_update": productUpdate,
        "product_copy": productCopy,
        "product_remove_hide": productRemoveHide,
        "product_category_list": productCategoryList,
        "product_category_add": productCategoryAdd,
        "product_category_update": productCategoryUpdate,
        "product_category_remove": productCategoryRemove,
        "product_attribute_list": productAttributeList,
        "product_attribute_add": productAttributeAdd,
        "product_attribute_update": productAttributeUpdate,
        "product_attribute_remove": productAttributeRemove,
        "product_ecommerce": productEcommerce,
        "product_commission": productCommission,
        "product_import_from_excel": productImportFromExcel,
        "product_export_to_excel": productExportToExcel,
        "customer_list": customerList,
        "customer_config_point": customerConfigPoint,
        "customer_review_list": customerReviewList,
        "customer_review_censorship": customerReviewCensorship,
        "promotion_discount_list": promotionDiscountList,
        "promotion_discount_add": promotionDiscountAdd,
        "promotion_discount_update": promotionDiscountUpdate,
        "promotion_discount_end": promotionDiscountEnd,
        "promotion_voucher_list": promotionVoucherList,
        "promotion_voucher_add": promotionVoucherAdd,
        "promotion_voucher_update": promotionVoucherUpdate,
        "promotion_voucher_end": promotionVoucherEnd,
        "promotion_combo_list": promotionComboList,
        "promotion_combo_add": promotionComboAdd,
        "promotion_combo_update": promotionComboUpdate,
        "promotion_combo_end": promotionComboEnd,
        "promotion_bonus_product_list": promotionBonusProductList,
        "promotion_bonus_product_add": promotionBonusProductAdd,
        "promotion_bonus_product_update": promotionBonusProductUpdate,
        "promotion_bonus_product_end": promotionBonusProductEnd,
        "post_list": postList,
        "post_add": postAdd,
        "post_update": postUpdate,
        "post_remove_hide": postRemoveHide,
        "post_category_list": postCategoryList,
        "post_category_add": postCategoryAdd,
        "post_category_update": postCategoryUpdate,
        "post_category_remove": postCategoryRemove,
        "app_theme_edit": appThemeEdit,
        "app_theme_main_config": appThemeMainConfig,
        "app_theme_button_contact": appThemeButtonContact,
        "app_theme_home_screen": appThemeHomeScreen,
        "app_theme_main_component": appThemeMainComponent,
        "app_theme_category_product": appThemeCategoryProduct,
        "app_theme_product_screen": appThemeProductScreen,
        "app_theme_contact_screen": appThemeContactScreen,
        "config_setting": configSetting,
        "invoice_template": invoiceTemplate,
        "web_theme_edit": webThemeEdit,
        "web_theme_overview": webThemeOverview,
        "web_theme_contact": webThemeContact,
        "web_theme_help": webThemeHelp,
        "web_theme_footer": webThemeFooter,
        "web_theme_banner": webThemeBanner,
        "web_theme_seo": webThemeSeo,
        "delivery_pick_address_list": deliveryPickAddressList,
        "delivery_pick_address_update": deliveryPickAddressUpdate,
        "delivery_provider_update": deliveryProviderUpdate,
        "payment_list": paymentList,
        "payment_on_off": paymentOnOff,
        "notification_schedule_list": notificationScheduleList,
        "notification_schedule_add": notificationScheduleAdd,
        "notification_schedule_remove_pause": notificationScheduleRemovePause,
        "notification_schedule_update": notificationScheduleUpdate,
        "popup_list": popupList,
        "popup_add": popupAdd,
        "popup_update": popupUpdate,
        "popup_remove": popupRemove,
        "promotion": promotion,
        "order_list": orderList,
        "order_import_from_excel": orderImportFromExcel,
        "order_export_to_excel": orderExportToExcel,
        "order_allow_change_status": orderAllowChangeStatus,
        "collaborator_config": collaboratorConfig,
        "collaborator_list": collaboratorList,
        "collaborator_register": collaboratorRegister,
        "collaborator_top_sale": collaboratorTopSale,
        "collaborator_payment_request_list": collaboratorPaymentRequestList,
        "collaborator_payment_request_solve": collaboratorPaymentRequestSolve,
        "collaborator_payment_request_history":
            collaboratorPaymentRequestHistory,
        "collaborator_add_sub_balance": collaboratorAddSubBalance,
        "agency_payment_request_history": agencyPaymentRequestHistory,
        "notification_to_stote": notificationToStote,
        "agency_config": agencyConfig,
        "agency_payment_request_list": agencyPaymentRequestList,
        "agency_payment_request_solve": agencyPaymentRequestSolve,
        "agency_add_sub_balance": agencyAddSubBalance,
        "chat_list": chatList,
        "chat_allow": chatAllow,
        "report_view": reportView,
        "report_overview": reportOverview,
        "report_product": reportProduct,
        "report_order": reportOrder,
        "report_finance": reportFinance,
        "report_inventory": reportInventory,
        "decentralization_list": decentralizationList,
        "decentralization_update": decentralizationUpdate,
        "decentralization_add": decentralizationAdd,
        "decentralization_remove": decentralizationRemove,
        "staff_list": staffList,
        "staff_update": staffUpdate,
        "staff_add": staffAdd,
        "staff_remove": staffRemove,
        "staff_delegating": staffDelegating,
        "agency_list": agencyList,
        "agency_register": agencyRegister,
        "agency_top_import": agencyTopImport,
        "agency_top_commission": agencyTopCommission,
        "agency_bonus_program": agencyBonusProgram,
        "store_info": storeInfo,
        "inventory_list": inventoryList,
        "inventory_import": inventoryImport,
        "inventory_tally_sheet": inventoryTallySheet,
        "revenue_expenditure": revenueExpenditure,
        "accountant_time_sheet": accountantTimeSheet,
        "add_revenue": addRevenue,
        "add_expenditure": addExpenditure,
        "setting_print": settingPrint,
        "branch_list": branchList,
        "create_order_pos": createOrderPos,
        "supplier": supplier,
        "barcode_print": barcodePrint,
        "timekeeping": timekeeping,
        "transfer_stock": transferStock,
        "onsale": onsale,
        "train": train,
        "overview": overview,
        "vip_edit": vipEdit,
        "onsale_list": onsaleList,
        "onsale_edit": onsaleEdit,
        "onsale_add": onsaleAdd,
        "onsale_remove": onsaleRemove,
        "onsale_assignment": onsaleAssignment,
        "gamification": gamification,
        "sale_list": saleList,
        "sale_config": saleConfig,
        "sale_top": saleTop,
        "ecommerce_list": ecommerceList,
        "ecommerce_products": ecommerceProducts,
        "ecommerce_connect": ecommerceConnect,
        "ecommerce_orders": ecommerceOrders,
        "ecommerce_inventory": ecommerceInventory,
        "config_sms": configSms,
        "banner_ads": bannerAds,
        "group_customer": groupCustomer,
        "history_operation": historyOperation,
        "customer_role_edit": customerRoleEdit,
        "change_price_pos": changePricePos,
        "agency_change_level": agencyChangeLevel,
        "communication_list":communicationList,
        "communication_update":communicationUpdate,
        "communication_delete":communicationDelete,
        "communication_add":communicationAdd,
        "communication_approve":communicationApprove,
        "train_add":trainAdd,
        "train_update":trainUpdate,
        "train_exam_list":trainExamList,
        "train_exam_add":trainExamAdd,
        "train_exam_update": trainExamUpdate,
        "train_exam_delete":trainExamDelete,
        "change_discount_pos":changeDiscountPos,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
