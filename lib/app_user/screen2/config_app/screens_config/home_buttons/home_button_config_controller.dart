import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/picker/category_post/category_post_picker.dart';
import 'package:com.ikitech.store/app_user/components/picker/image/image_dialog_picker.dart';
import 'package:com.ikitech.store/app_user/components/picker/post/post_picker.dart';
import 'package:com.ikitech.store/app_user/components/picker/product/product_picker.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/home_button_config.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/categories/category_screen.dart';
import 'package:sahashop_customer/app_customer/model/button_home.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';
import 'package:sahashop_customer/app_customer/model/category_post.dart';
import 'package:sahashop_customer/app_customer/model/post.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/utils/action_tap.dart';

class HomeButtonConfigController extends GetxController {
  var listButton = [
    TypesButton(name: "Chức năng", listButton: [
      HomeButtonCf(title: "Quét QR", typeAction: mapTypeAction[TYPE_ACTION.QR]),
      HomeButtonCf(
          title: "Hotline", typeAction: mapTypeAction[TYPE_ACTION.CALL]),
      HomeButtonCf(
          title: "Tin nhắn",
          typeAction: mapTypeAction[TYPE_ACTION.MESSAGE_TO_SHOP]),
      HomeButtonCf(
          title: "Xu thưởng", typeAction: mapTypeAction[TYPE_ACTION.SCORE]),
      HomeButtonCf(
          title: "Voucher", typeAction: mapTypeAction[TYPE_ACTION.VOUCHER]),
      HomeButtonCf(
          title: "Bán chạy",
          typeAction: mapTypeAction[TYPE_ACTION.PRODUCTS_TOP_SALES]),
      HomeButtonCf(
          title: "Sản phẩm mới",
          typeAction: mapTypeAction[TYPE_ACTION.PRODUCTS_NEW]),
      HomeButtonCf(
          title: "Giảm giá",
          typeAction: mapTypeAction[TYPE_ACTION.PRODUCTS_DISCOUNT]),
      HomeButtonCf(
          title: "Combo", typeAction: mapTypeAction[TYPE_ACTION.COMBO]),
      HomeButtonCf(
          title: "Thưởng sản phẩm",
          typeAction: mapTypeAction[TYPE_ACTION.BONUS_PRODUCT]),
    ]),
    TypesButton(name: "Chuyển hướng", listButton: [
      HomeButtonCf(
          title: "Tới trang Web", typeAction: mapTypeAction[TYPE_ACTION.LINK]),
      HomeButtonCf(
          title: "Sản phẩm", typeAction: mapTypeAction[TYPE_ACTION.PRODUCT]),
      HomeButtonCf(
          title: "Danh mục sản phẩm",
          typeAction: mapTypeAction[TYPE_ACTION.CATEGORY_PRODUCT]),
      HomeButtonCf(
          title: "Bài viết", typeAction: mapTypeAction[TYPE_ACTION.POST]),
      HomeButtonCf(
          title: "Danh mục bài viết",
          typeAction: mapTypeAction[TYPE_ACTION.CATEGORY_POST]),
    ]),
  ];

  DataAppCustomerController dataAppCustomerController = Get.find();

  var currentButtons = RxList<HomeButton>();
  var currentButtonCfs = RxList<HomeButtonCf>();
  var pageType = 0.obs;
  var waitingSave = false.obs;

  HomeButtonConfigController() {
    if (dataAppCustomerController.homeData.value.listLayout != null) {
      var button = dataAppCustomerController.homeData.value.listLayout
          ?.firstWhereOrNull((element) => element.model == 'HomeButton');

      if (button != null) {
        buttonToButtonCf(currentButtons(button.list!.cast<HomeButton>()));
      }
    }
  }

  bool hasInListShow(HomeButtonCf cf) {
    var lsTypeStr = checkTypeDefault.map((e) => mapTypeAction[e]).toList();
    var lsTypeCurrentStr = currentButtonCfs.map((e) => e.typeAction).toList();

    if (lsTypeStr.contains(cf.typeAction) &&
        lsTypeCurrentStr.contains(cf.typeAction)) {
      return true;
    }

    return false;
  }

  void onReset() async {
    waitingSave.value = true;
    try {
      List<HomeButton> listButton = [];
      await RepositoryManager.configUiRepository.updateAppButton(listButton);
      await dataAppCustomerController.getHomeData();

      if (dataAppCustomerController.homeData.value.listLayout != null) {
        var button = dataAppCustomerController.homeData.value.listLayout
            ?.firstWhereOrNull((element) => element.model == 'HomeButton');

        if (button != null) {
          buttonToButtonCf(currentButtons(button.list!.cast<HomeButton>()));
        }
      }
    } catch (err) {
      SahaAlert.showError(message: "Có lỗi khi cập nhật nút");
    }
    waitingSave.value = false;
    SahaAlert.showSuccess(message: "Cập nhật thành công");
  }

  void onSave() async {
    waitingSave.value = true;
    try {
      var listButton = currentButtonCfs
          .map((element) => HomeButton(
              typeAction: element.typeAction,
              title: element.title,
              value: element.value,
              imageUrl: element.imageUrl))
          .toList();
      await RepositoryManager.configUiRepository.updateAppButton(listButton);
      await dataAppCustomerController.getHomeData();

      if (dataAppCustomerController.homeData.value.listLayout != null) {
        var button = dataAppCustomerController.homeData.value.listLayout
            ?.firstWhereOrNull((element) => element.model == 'HomeButton');

        if (button != null) {
          buttonToButtonCf(currentButtons(button.list!.cast<HomeButton>()));
        }
      }
    } catch (err) {
      SahaAlert.showError(message: "Có lỗi khi cập nhật nút");
    }
    waitingSave.value = false;
    SahaAlert.showSuccess(message: "Cập nhật thành công");
  }

  void addButton(HomeButtonCf homeButtonCf) async {
    var newButton = HomeButtonCf(
        title: homeButtonCf.title,
        value: homeButtonCf.value,
        svg: homeButtonCf.svg,
        typeAction: homeButtonCf.typeAction);

    if (hasInListShow(newButton)) {
      SahaAlert.showError(message: "Bạn đã thêm nút này ");
      return;
    }
    if (currentButtonCfs.length == 20) {
      SahaAlert.showError(message: "Chỉ được thêm tối đã 20 nút");
      return;
    }

    var lsTypeStr = checkTypeDefault.map((e) => mapTypeAction[e]).toList();

    if (lsTypeStr.contains(newButton.typeAction)) {
      if (newButton.typeAction == mapTypeAction[TYPE_ACTION.CALL]) {
        await SahaDialogApp.showDialogInput(
            title: "Nhập số điện thoại",
            hintText: "",
            onCancel: () {
              return;
            },
            onInput: (va) {
              if (va.length == 0) {
                SahaAlert.showError(
                    message: "Số điện thoại không được để trống");
                return;
              } else {
                newButton.value = va;
                currentButtonCfs.add(newButton);
                Get.back();
              }
            });
      } else {
        currentButtonCfs.add(newButton);
      }
      return;
    }

    if (newButton.typeAction == mapTypeAction[TYPE_ACTION.LINK]) {
      await SahaDialogApp.showDialogInput(
          title: "Tên nút",
          hintText: "",
          onCancel: () {
            return;
          },
          onInput: (va) {
            if (va.length == 0) {
              SahaAlert.showError(message: "Tên nút không được trống");
              return;
            } else {
              newButton.title = va;
              Get.back();
              SahaDialogApp.showDialogInput(
                  title: "Nhập địa chỉ web",
                  hintText: "https://",
                  onCancel: () {
                    return;
                  },
                  onInput: (va) {
                    if (GetUtils.isURL(va)) {
                      newButton.value = va;
                      Get.back();
                      ImageDialogPicker.showPickOneImage(onSuccess: (path) {
                        newButton.imageUrl = path;
                        currentButtonCfs.add(newButton);
                      }, onCancel: () {
                        return;
                      });
                    } else {
                      SahaAlert.showError(message: "Địa chỉ không hợp lệ");
                      return;
                    }
                  });
            }
          });

      return;
    }

    if (newButton.typeAction == mapTypeAction[TYPE_ACTION.PRODUCT]) {
      Get.to(() => ProductPickerScreen(
            listProductInput: [],
            callback: (List<Product> products) {
              for (var element in products) {
                currentButtonCfs.add(HomeButtonCf(
                    title: element.name,
                    value: element.id.toString(),
                    typeAction: newButton.typeAction,
                    imageUrl:
                        element.images != null && element.images!.length > 0
                            ? element.images![0].imageUrl
                            : ""));

                if (currentButtonCfs.length == 20) {
                  SahaAlert.showError(message: "Chỉ được thêm tối đã 20 nút");
                  return;
                }
              }
            },
          ));

      return;
    }

    if (newButton.typeAction == mapTypeAction[TYPE_ACTION.CATEGORY_PRODUCT]) {
      Get.to(() => CategoryScreen(
                isSelect: true,
              ))!
          .then((categories) {
        List<Category> categories2 = categories['list_cate'];

        for (var element in categories2) {
          currentButtonCfs.add(HomeButtonCf(
              title: element.name,
              typeAction: newButton.typeAction,
              value: element.id.toString(),
              imageUrl: element.imageUrl != null ? element.imageUrl : ""));

          if (currentButtonCfs.length == 20) {
            SahaAlert.showError(message: "Chỉ được thêm tối đã 20 nút");
            return;
          }
        }
      });
    }

    if (newButton.typeAction == mapTypeAction[TYPE_ACTION.POST]) {
      Get.to(() => PostPickerScreen(
            listPostInput: [],
            callback: (List<Post> products) {
              for (var element in products) {
                currentButtonCfs.add(HomeButtonCf(
                    title: element.title,
                    typeAction: newButton.typeAction,
                    value: element.id.toString(),
                    imageUrl:
                        element.imageUrl != null ? element.imageUrl : ""));

                if (currentButtonCfs.length == 20) {
                  SahaAlert.showError(message: "Chỉ được thêm tối đã 20 nút");
                  return;
                }
              }
            },
          ));

      return;
    }

    if (newButton.typeAction == mapTypeAction[TYPE_ACTION.CATEGORY_POST]) {
      Get.to(() => CategoryPostPickerScreen(
                isSelect: true,
              ))!
          .then((categories) {
        List<CategoryPost> categories2 = categories;

        for (var element in categories2) {
          currentButtonCfs.add(HomeButtonCf(
              title: element.title,
              typeAction: newButton.typeAction,
              value: element.id.toString(),
              imageUrl: element.imageUrl != null ? element.imageUrl : ""));

          if (currentButtonCfs.length == 20) {
            SahaAlert.showError(message: "Chỉ được thêm tối đã 20 nút");
            return;
          }
        }
      });
    }
  }

  void removeButton(HomeButtonCf homeButtonCf) {
    currentButtonCfs.remove(homeButtonCf);
  }

  void buttonToButtonCf(List<HomeButton>? buttons) {
    if (buttons != null && buttons.length > 0)
      currentButtonCfs(buttons
          .map((e) => HomeButtonCf(
              title: e.title,
              typeAction: e.typeAction,
              imageUrl: e.imageUrl,
              value: e.value,
              svg: ""))
          .toList());
  }

  void changeIndex(int oldIndex, int newIndex) {
    var pre = currentButtonCfs[oldIndex];
    currentButtonCfs.removeAt(oldIndex);
    currentButtonCfs.insert(newIndex, pre);
  }
}

class TypesButton {
  List<HomeButtonCf> listButton = [];
  String name;

  TypesButton({required this.listButton, required this.name});
}
