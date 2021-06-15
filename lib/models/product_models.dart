import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  ProductModel({
    this.id,
    this.idshop,
    this.nameproduct,
    this.category,
    this.price,
    this.detail,
    this.image,
  });

  String id;
  String idshop;
  String nameproduct;
  Category category;
  String price;
  String detail;
  String image;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"] == null ? null : json["id"],
        idshop: json["idshop"] == null ? null : json["idshop"],
        nameproduct: json["nameproduct"] == null ? null : json["nameproduct"],
        category: json["category"] == null
            ? null
            : categoryValues.map[json["category"]],
        price: json["price"] == null ? null : json["price"],
        detail: json["detail"] == null ? null : json["detail"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "idshop": idshop == null ? null : idshop,
        "nameproduct": nameproduct == null ? null : nameproduct,
        "category": category == null ? null : categoryValues.reverse[category],
        "price": price == null ? null : price,
        "detail": detail == null ? null : detail,
        "image": image == null ? null : image,
      };
}

enum Category { EMPTY, CATEGORY }

final categoryValues =
    EnumValues({"ของกิน": Category.CATEGORY, "ของใช้": Category.EMPTY});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
