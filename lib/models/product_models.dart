import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  ProductModel({
    this.idProduct,
    this.idShop,
    this.idCategory,
    this.nameproduct,
    this.price,
    this.detail,
    this.image,
  });

  String idProduct;
  String idShop;
  String idCategory;
  String nameproduct;
  String price;
  String detail;
  String image;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        idProduct: json["id_product"] == null ? null : json["id_product"],
        idShop: json["id_shop"] == null ? null : json["id_shop"],
        idCategory: json["id_category"] == null ? null : json["id_category"],
        nameproduct: json["nameproduct"] == null ? null : json["nameproduct"],
        price: json["price"] == null ? null : json["price"],
        detail: json["detail"] == null ? null : json["detail"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id_product": idProduct == null ? null : idProduct,
        "id_shop": idShop == null ? null : idShop,
        "id_category": idCategory == null ? null : idCategory,
        "nameproduct": nameproduct == null ? null : nameproduct,
        "price": price == null ? null : price,
        "detail": detail == null ? null : detail,
        "image": image == null ? null : image,
      };
}
