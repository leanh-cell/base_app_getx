import 'dart:convert';

SendMessageRequest sendMessageRequestFromJson(String str) =>
    SendMessageRequest.fromJson(json.decode(str));

String sendMessageRequestToJson(SendMessageRequest data) =>
    json.encode(data.toJson());

class SendMessageRequest {
  SendMessageRequest({
    this.content,
    this.linkImages,
    this.productId,
  });

  String? content;
  String? linkImages;
  int? productId;

  factory SendMessageRequest.fromJson(Map<String, dynamic> json) =>
      SendMessageRequest(
        content: json["content"],
        linkImages: json["link_images"],
        productId: json["product_id"],
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "link_images": linkImages,
        "product_id": productId,
      };
}
