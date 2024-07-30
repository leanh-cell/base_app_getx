class Attribute {
  int? id;
  String? name;
  Null numericalOrder;

  Attribute({this.id, this.name, this.numericalOrder});

  Attribute.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    numericalOrder = json['numerical_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['numerical_order'] = this.numericalOrder;
    return data;
  }
}