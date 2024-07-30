class Stamp {
  Stamp({
    this.nameProduct,
    this.quantity,
    this.barcode,
    this.productId,
    this.distributeName,
    this.elementDistributeName,
    this.subElementDistributeName,
    this.price,
    this.priceCapital,
    this.priceImport,
  });

  int? productId;
  int? quantity;
  String? barcode;
  String? nameProduct;
  String? distributeName;
  String? elementDistributeName;
  String? subElementDistributeName;
  double? price;
  double? priceCapital;
  double? priceImport;
}
