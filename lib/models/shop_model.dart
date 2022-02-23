import 'dart:convert';

List<ShopModel> shopModelFromJson(String str) =>
    List<ShopModel>.from(json.decode(str).map((x) => ShopModel.fromJson(x)));

String shopModelToJson(List<ShopModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShopModel {
  String? id;
  String? idSeller;
  String? idArea;
  String? nameshop;
  String? categoryType;
  String? lat;
  String? long;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  ShopModel({
    required this.id,
    required this.idSeller,
    required this.idArea,
    required this.nameshop,
    required this.categoryType,
    required this.lat,
    required this.long,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  ShopModel copyWith({
    String? id,
    String? idSeller,
    String? idArea,
    String? nameshop,
    String? categoryType,
    String? lat,
    String? long,
    String? image,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
  }) {
    return ShopModel(
      id: id ?? this.id,
      idSeller: idSeller ?? this.idSeller,
      idArea: idArea ?? this.idArea,
      nameshop: nameshop ?? this.nameshop,
      categoryType: categoryType ?? this.categoryType,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_seller': idSeller,
      'id_area': idArea,
      'nameshop': nameshop,
      'categoryType': categoryType,
      'lat': lat,
      'long': long,
      'image': image,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }

  factory ShopModel.fromMap(Map<String, dynamic> map) {
    return ShopModel(
      id: map['id'],
      idSeller: map['id_seller'],
      idArea: map['id_area'],
      nameshop: map['nameshop'],
      categoryType: map['categoryType'],
      lat: map['lat'],
      long: map['long'],
      image: map['image'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      deletedAt: map['deleted_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopModel.fromJson(String source) =>
      ShopModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ShopModel(id: $id, idSeller: $idSeller, idArea: $idArea, nameshop: $nameshop, categoryType: $categoryType, lat: $lat, long: $long, image: $image, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShopModel &&
        other.id == id &&
        other.idSeller == idSeller &&
        other.idArea == idArea &&
        other.nameshop == nameshop &&
        other.categoryType == categoryType &&
        other.lat == lat &&
        other.long == long &&
        other.image == image &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.deletedAt == deletedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        idSeller.hashCode ^
        idArea.hashCode ^
        nameshop.hashCode ^
        categoryType.hashCode ^
        lat.hashCode ^
        long.hashCode ^
        image.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        deletedAt.hashCode;
  }
}
