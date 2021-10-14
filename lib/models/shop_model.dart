import 'dart:convert';

List<ShopModel> shopModelFromJson(String str) =>
    List<ShopModel>.from(json.decode(str).map((x) => ShopModel.fromJson(x)));

String shopModelToJson(List<ShopModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShopModel {
  String idShop;
  String idSeller;
  String idArea;
  String nameshop;
  String image;
  String lat;
  String lng;
  ShopModel({
    required this.idShop,
    required this.idSeller,
    required this.idArea,
    required this.nameshop,
    required this.image,
    required this.lat,
    required this.lng,
  });

  ShopModel copyWith({
    String? idShop,
    String? idSeller,
    String? idArea,
    String? nameshop,
    String? image,
    String? lat,
    String? lng,
  }) {
    return ShopModel(
      idShop: idShop ?? this.idShop,
      idSeller: idSeller ?? this.idSeller,
      idArea: idArea ?? this.idArea,
      nameshop: nameshop ?? this.nameshop,
      image: image ?? this.image,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idShop': idShop,
      'idSeller': idSeller,
      'idArea': idArea,
      'nameshop': nameshop,
      'image': image,
      'lat': lat,
      'lng': lng,
    };
  }

  factory ShopModel.fromMap(Map<String, dynamic> map) {
    return ShopModel(
      idShop: map['id_shop'],
      idSeller: map['id_seller'],
      idArea: map['id_area'],
      nameshop: map['nameshop'],
      image: map['image'],
      lat: map['lat'],
      lng: map['lng'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopModel.fromJson(String source) =>
      ShopModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ShopModel(idShop: $idShop, idSeller: $idSeller, idArea: $idArea, nameshop: $nameshop, image: $image, lat: $lat, long: $lng)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShopModel &&
        other.idShop == idShop &&
        other.idSeller == idSeller &&
        other.idArea == idArea &&
        other.nameshop == nameshop &&
        other.image == image &&
        other.lat == lat &&
        other.lng == lng;
  }

  @override
  int get hashCode {
    return idShop.hashCode ^
        idSeller.hashCode ^
        idArea.hashCode ^
        nameshop.hashCode ^
        image.hashCode ^
        lat.hashCode ^
        lng.hashCode;
  }
}
