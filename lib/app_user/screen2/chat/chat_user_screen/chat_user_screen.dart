import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty/saha_empty_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_container.dart';
import 'package:com.ikitech.store/app_user/model/box_chat_customer.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:uuid/uuid.dart';

import 'chat_user_controller.dart';

class ChatUserScreen extends StatelessWidget {
  BoxChatCustomer boxChatCustomerInput;

  ChatUserScreen({required this.boxChatCustomerInput}) {
    chatController = ChatController(boxChatCustomerInput: boxChatCustomerInput);
  }
  late ChatController chatController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              child: CachedNetworkImage(
                imageUrl: boxChatCustomerInput.customer?.avatarImage ?? "",
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                placeholder: (context, url) => SahaLoadingContainer(
                  height: 40,
                  width: 30,
                ),
                errorWidget: (context, url, error) => Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: SahaEmptyImage(),
                ),
              ),
              borderRadius: BorderRadius.circular(3000),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${boxChatCustomerInput.customer?.name ?? "Chưa đặt tên"}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Avenir'),
                ),
                SizedBox(
                  height: 2,
                ),
                boxChatCustomerInput.lastMessage == null
                    ? Container()
                    : Text(
                        "${SahaStringUtils().displayTimeAgoFromTime(boxChatCustomerInput.lastMessage?.createdAt ?? DateTime.now()) == "0 phút trước" ? "đang hoạt động" : SahaStringUtils().displayTimeAgoFromTime(boxChatCustomerInput.lastMessage?.createdAt ?? DateTime.now())}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12, fontFamily: 'Avenir'),
                      ),
              ],
            ),
          ],
        ),
      ),
      body: Obx(
        () => Chat(
          dateLocale: 'vi',
          l10n: const ChatL10nEn(
            inputPlaceholder: 'Tin nhắn',
          ),
          messages: chatController.listMessages.toList(),
          onAttachmentPressed: chatController.multiPickerImage,
          onSendPressed: _onSendMessage,
          user: chatController.userMain.value,
          onEndReached: _handleEndReached,
          onEndReachedThreshold: 1,
          showUserAvatars:
              boxChatCustomerInput.customer?.avatarImage != null ? true : false,
          showUserNames: true,

          theme:  DefaultChatTheme(
            attachmentButtonIcon: Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
            inputTextDecoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isCollapsed: true),
            inputBorderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            backgroundColor:  Theme.of(context).primaryColor.withOpacity(0.1),
            inputBackgroundColor: Color(0xFF88120D),
            inputTextCursorColor: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<void> _handleEndReached() async {
    await chatController.loadMoreMessage();
  }

  void _addMessage(types.Message message) {
    chatController.listMessages.insert(0, message);
  }

  void _onSendMessage(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: chatController.userMain.value,
      id: const Uuid().v4(),
      text: message.text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    _addMessage(textMessage);
    chatController.sendMessageToCustomer(message.text);
  }
}
