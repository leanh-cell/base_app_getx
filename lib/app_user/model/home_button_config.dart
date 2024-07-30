class HomeButtonCf {
  HomeButtonCf({
    this.title,
    this.typeAction,
    this.imageUrl,
    this.value,
    this.svg,
  });

  String? title;
  String? typeAction;
  String? imageUrl;
  String? svg;
  String? value;

  factory HomeButtonCf.fromJson(Map<String, dynamic> json) => HomeButtonCf(
    title: json["title"],
    typeAction: json["type_action"],
    imageUrl: json["image_url"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "type_action": typeAction,
    "image_url": imageUrl,
    "value": value,
  };
}