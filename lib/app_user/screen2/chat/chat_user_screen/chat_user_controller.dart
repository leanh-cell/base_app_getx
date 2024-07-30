import 'dart:convert';
import 'dart:io';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/chat/send_message_request.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/chat/send_message_response.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/data/socket/socket.dart';
import 'package:com.ikitech.store/app_user/model/box_chat_customer.dart';
import 'package:com.ikitech.store/app_user/model/message.dart';
import 'package:com.ikitech.store/app_user/utils/image_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter/material.dart';
import 'package:sahashop_customer/app_customer/model/info_customer.dart';
import 'package:uuid/uuid.dart';
import 'message_to_json.dart';

class ChatController extends GetxController {
  late BoxChatCustomer boxChatCustomerInput;
   var infoCustomer = InfoCustomer().obs;
  var limitedSocket = 0.obs;
  var messageEditingController = new TextEditingController(text: "").obs;
  var pageLoadMore = 1;
  var isEndPageCombo = false;
  var listMessageRes = RxList<MessageRes>();
  var allImageInMessage = RxList<List<dynamic>?>();
  var listImageResponse = [];
  var listImageRequest = [];
  var listSaveDataImages = RxList<List<ImageData>?>();
  var timeNow = DateTime.now().obs;
  var isLoading = false.obs;
  var listMessages = RxList<types.Message>();
  List<ImageChat> listImageChat = [];
  final int? customerId;


  var userMain =
      types.User(id: "11111", imageUrl: "aaa", firstName: "shop").obs;
  var userChat = types.User(id: "").obs;
  ChatController({required this.boxChatCustomerInput,this.customerId}) {
    userChat.value = types.User(
        id: '${boxChatCustomerInput.id}',
        imageUrl: boxChatCustomerInput.customer?.avatarImage ?? '',
        firstName: '${boxChatCustomerInput.customer?.name ?? ''}');
    loadMoreMessage(isRefresh: true);
    getDataMessageCustomer();
  }

  void getDataMessageCustomer() {
    print("sssssssssssssss");
    SocketUser().listenCustomerWithId(boxChatCustomerInput.customerId, (data) {
      timeNow.value = DateTime.now();
      limitedSocket.value++;
      if (limitedSocket.value == 1) {
        print("------------------------------$data");
        var resData = MessageRes.fromJson(data);
        if (resData.linkImages == null) {
          final message = types.TextMessage(
            author: userChat.value,
            id: resData.id.toString(),
            createdAt: resData.createdAt?.millisecondsSinceEpoch ??
                timeNow.value.millisecondsSinceEpoch,
            text: resData.content ?? "",
            status: boxChatCustomerInput.customerUnread == 0
                ? types.Status.seen
                : types.Status.sent,
          );
          listMessages.insert(0, message);
        } else {
          try {
            var listImage = (jsonDecode(resData.linkImages!) as List)
                .map((e) => ImageChat.fromJson(e as Map<String, dynamic>))
                .toList();
            listImage.forEach((e) {
              final message = types.ImageMessage(
                author: userChat.value,
                height: e.height,
                id: e.linkImages!,
                name: e.linkImages!,
                size: e.size ?? 1000000,
                createdAt:
                    DateTime.now().millisecondsSinceEpoch,
                uri: e.linkImages!,
                width: e.width,
                status: boxChatCustomerInput.customerUnread == 0
                    ? types.Status.seen
                    : types.Status.sent,
              );
              listMessages.insert(0, message);
            });
          } catch (err) {
            //allImageInMessage[i] = [listMessage[i].linkImages];
          }
        }
      }
      Future.delayed(Duration(seconds: 1), () {
        limitedSocket.value = 0;
      });
    });
  }

  Future<void> loadMoreMessage({bool? isRefresh}) async {
    isLoading.value = true;
    if (isRefresh == true) {
      pageLoadMore = 1;
      isEndPageCombo = false;
    }
    timeNow.value = DateTime.now();
    try {
      if (!isEndPageCombo) {
        var res = await RepositoryManager.chatRepository
            .getAllMessageUser(boxChatCustomerInput.customerId, pageLoadMore);
        res!.data!.data!.forEach((eMain) {
          print(eMain.isUser);
          if (eMain.isUser == false) {
            if (eMain.linkImages == null) {
              final message = types.TextMessage(
                author: userChat.value,
                id: eMain.id.toString(),
                createdAt: eMain.createdAt?.millisecondsSinceEpoch ??
                    timeNow.value.millisecondsSinceEpoch,
                text: eMain.content ?? "",
                status: boxChatCustomerInput.customerUnread == 0
                    ? types.Status.seen
                    : types.Status.sent,
              );
              listMessages.add(message);
            } else {
              try {
                var listImage = (jsonDecode(eMain.linkImages!) as List)
                    .map((e) => ImageChat.fromJson(e as Map<String, dynamic>))
                    .toList();
                listImage.forEach((e) {
                  final message = types.ImageMessage(
                    author: userChat.value,
                    height: e.height,
                    id: e.linkImages!,
                    name: e.linkImages!,
                    size: e.size ?? 1000000,
                    createdAt:
                    eMain.createdAt?.millisecondsSinceEpoch ??
                        timeNow.value.millisecondsSinceEpoch,
                    uri: e.linkImages!,
                    width: e.width,
                    status: boxChatCustomerInput.customerUnread == 0
                        ? types.Status.seen
                        : types.Status.sent,
                  );
                  listMessages.add(message);
                });
              } catch (err) {
                //allImageInMessage[i] = [listMessage[i].linkImages];
              }
            }
          } else {
            if (eMain.linkImages == null) {
              final message = types.TextMessage(
                author: userMain.value,
                id: eMain.id.toString(),
                createdAt: eMain.createdAt?.millisecondsSinceEpoch ??
                    timeNow.value.millisecondsSinceEpoch,
                text: eMain.content ?? "",
                status: boxChatCustomerInput.customerUnread == 0
                    ? types.Status.seen
                    : types.Status.sent,
              );
              listMessages.add(message);
            } else {
              try {
                var listImage = (jsonDecode(eMain.linkImages!) as List)
                    .map((e) => ImageChat.fromJson(e as Map<String, dynamic>)).toList();
                listImage.forEach((e) {
                  final message = types.ImageMessage(
                    author: userMain.value,
                    height: e.height,
                    id: e.linkImages!,
                    name: e.linkImages!,
                    size: e.size ?? 1000000,
                    createdAt:
                    eMain.createdAt?.millisecondsSinceEpoch ??
                        timeNow.value.millisecondsSinceEpoch,
                    uri: e.linkImages!,
                    width: e.width,
                    status: boxChatCustomerInput.customerUnread == 0
                        ? types.Status.seen
                        : types.Status.sent,
                  );
                  listMessages.add(message);
                });
              } catch (err) {
                print(err);
                //allImageInMessage[i] = [listMessage[i].linkImages];
              }
            }
          }
        });
        listMessages.refresh();

        if (res.data!.nextPageUrl != null) {
          pageLoadMore++;
          isEndPageCombo = false;
        } else {
          isEndPageCombo = true;
        }
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }

  void addMessage(types.Message message) {
    listMessages.insert(0, message);
  }

  Future<SendMessageResponse?> sendImageToCustomer() async {
    timeNow.value = DateTime.now();
    try {
      var res = await RepositoryManager.chatRepository.sendMessageToCustomer(
          boxChatCustomerInput.customerId,
          SendMessageRequest(linkImages: jsonEncode(listImageChat)));
      messageEditingController.value.text = "";
      messageEditingController.refresh();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<SendMessageResponse?> sendMessageToCustomer(
      String? textMessage) async {
    timeNow.value = DateTime.now();
    try {
      var res = await RepositoryManager.chatRepository.sendMessageToCustomer(
          boxChatCustomerInput.customerId,
          SendMessageRequest(
            content: textMessage,
          ));
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  var dataImages = <ImageData>[];

  void updateListImage(List<XFile> listXFile) {
    var listPre = dataImages.toList();
    var newList = <ImageData>[];
    for (var file in listXFile) {
      var dataPre = listPre.firstWhereOrNull((itemPre) => itemPre.file == file);

      if (dataPre != null) {
        newList.add(dataPre);
      } else {
        newList.add(ImageData(
            file: file, linkImage: null, errorUpload: false, uploading: false));
      }
    }
    dataImages = newList;
    dataImages.forEach((e) async {
      final size = File(e.file!.path).lengthSync();
      final bytes = await e.file!.readAsBytes();
      final image = await decodeImageFromList(bytes);
      final imageName = e.file!.path.split('/').last;
      final message = types.ImageMessage(
        author: userMain.value,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: imageName,
        size: size,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        uri: e.file!.path,
        width: image.width.toDouble(),
        status: types.Status.sent
      );

      addMessage(message);
    });
    uploadListImage();
  }

  void uploadListImage() async {
    int stackComplete = 0;
    listImageChat = [];
    var responses = await Future.wait(dataImages.map((imageData) {
      if (imageData.linkImage == null) {
        return uploadImageData(
            indexImage: dataImages.indexOf(imageData),
            onOK: () {
              stackComplete++;
            });
      } else
        return Future.value(null);
    }));
    print("===========${dataImages}");

    dataImages.forEach((e) async {
      final size = File(e.file!.path).lengthSync();
      final bytes = await e.file!.readAsBytes();
      final image = await decodeImageFromList(bytes);
      listImageChat.add(ImageChat(
          size: size,
          height: image.height.toDouble(),
          width: image.width.toDouble(),
          linkImages: e.linkImage ?? ""));
      print(listImageChat.length == dataImages.length);
      if (listImageChat.length == dataImages.length) {
        sendImageToCustomer();
      }
    });
  }

  Future<void> uploadImageData(
      {required int indexImage, required Function onOK}) async {
    try {
      var fileUp = await ImageUtils.getImageCompress(
          File(dataImages[indexImage].file!.path),
          minWidth: 700,
          minHeight: 512,
          quality: 15);

      var link = await RepositoryManager.imageRepository.uploadImage(fileUp);

      dataImages[indexImage].linkImage = link;
    } catch (err) {
      print(err);
      dataImages[indexImage].linkImage = null;
    }
    onOK();
  }

  Future<void> multiPickerImage() async {
    dataImages = [];
    List<XFile>? resultList = <XFile>[];
    String error = 'No Error Detected';
    try {
      resultList = await ImagePicker().pickMultiImage(
        imageQuality: 70,
        maxWidth: 1440,
      );
    } on Exception catch (e) {
      print(error);
      error = e.toString();
      print(error);
    }

    if (resultList!.isNotEmpty) {
      updateListImage(resultList);
    } else {
      return;
    }
  }

  Future<void> getInfoCustomer() async {
    try {
      var data = await RepositoryManager.customerRepository
          .getInfoCustomer(customerId!);
      infoCustomer.value = data!.data!;
      
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }


}

class ImageData {
  XFile? file;
  String? linkImage;
  bool? errorUpload;
  bool? uploading;

  ImageData({this.file, this.linkImage, this.errorUpload, this.uploading});
}
