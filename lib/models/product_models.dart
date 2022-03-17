import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  String? id;
  String? idShop;
  String? nameproduct;
  String? detail;
  String? idSubcategory;
  String? price;
  String? image;
  String? view;
  String? createdAt;
  String? updatedAt;

  ProductModel({
    this.id,
    required this.idShop,
    required this.nameproduct,
    required this.detail,
    required this.idSubcategory,
    required this.price,
    required this.image,
    this.view,
    this.createdAt,
    this.updatedAt,
  });

  ProductModel copyWith({
    String? id,
    String? idShop,
    String? nameproduct,
    String? detail,
    String? idSubcategory,
    String? price,
    String? image,
    String? view,
    String? createdAt,
    String? updatedAt,
  }) {
    return ProductModel(
      id: id ?? this.id,
      idShop: idShop ?? this.idShop,
      nameproduct: nameproduct ?? this.nameproduct,
      detail: detail ?? this.detail,
      idSubcategory: idSubcategory ?? this.idSubcategory,
      price: price ?? this.price,
      image: image ?? this.image,
      view: view ?? this.view,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_shop': idShop,
      'nameproduct': nameproduct,
      'detail': detail,
      'id_subcategory': idSubcategory,
      'price': price,
      'image': image,
      'view': view,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'].toString(),
      idShop: map['id_shop'].toString(),
      nameproduct: map['nameproduct'],
      detail: map['detail'],
      idSubcategory: map['id_subcategory'].toString(),
      price: map['price'].toString(),
      image: map['image'],
      view: map['view'].toString(),
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductModel(id: $id, idShop: $idShop, nameproduct: $nameproduct, detail: $detail, idSubcategory: $idSubcategory, price: $price, image: $image, view: $view, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModel &&
        other.id == id &&
        other.idShop == idShop &&
        other.nameproduct == nameproduct &&
        other.detail == detail &&
        other.idSubcategory == idSubcategory &&
        other.price == price &&
        other.image == image &&
        other.view == view &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        idShop.hashCode ^
        nameproduct.hashCode ^
        detail.hashCode ^
        idSubcategory.hashCode ^
        price.hashCode ^
        image.hashCode ^
        view.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
