
class ImageChat {
  ImageChat({
    this.linkImages,
    this.height,
    this.width,
    required this.size,
  });


  String? linkImages;
  double? height;
  double? width;
  int? size;

  factory ImageChat.fromJson(Map<String, dynamic> json) => ImageChat(
    linkImages: json["link_images"],
    height: json["height"].toDouble(),
    width: json["width"].toDouble(),
    size: json["size"],
  );

  Map<String, dynamic> toJson() => {
    "link_images": linkImages,
    "height": height,
    "width": width,
    "size": size,
  };
}
