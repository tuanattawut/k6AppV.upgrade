import 'dart:convert';

class PromotionsellerModel {
  String? id;
  String? idSeller;
  String? detailpromotion;
  String? image;
  String? status;
  String? updatedAt;
  String? nameshop;
  String? lat;
  String? long;
  String? phone;

  PromotionsellerModel({
    this.id,
    this.idSeller,
    this.detailpromotion,
    this.image,
    this.status,
    this.updatedAt,
    this.nameshop,
    this.lat,
    this.long,
    this.phone,
  });

  PromotionsellerModel copyWith({
    String? id,
    String? idSeller,
    String? detailpromotion,
    String? image,
    String? status,
    String? updatedAt,
    String? nameshop,
    String? lat,
    String? long,
    String? phone,
  }) {
    return PromotionsellerModel(
      id: id ?? this.id,
      idSeller: idSeller ?? this.idSeller,
      detailpromotion: detailpromotion ?? this.detailpromotion,
      image: image ?? this.image,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
      nameshop: nameshop ?? this.nameshop,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_seller': idSeller,
      'detailpromotion': detailpromotion,
      'image': image,
      'status': status,
      'updated_at': updatedAt,
      'nameshop': nameshop,
      'lat': lat,
      'long': long,
      'phone': phone,
    };
  }

  factory PromotionsellerModel.fromMap(Map<String, dynamic> map) {
    return PromotionsellerModel(
      id: map['id'],
      idSeller: map['id_seller'],
      detailpromotion: map['detailpromotion'],
      image: map['image'],
      status: map['status'],
      updatedAt: map['updated_at'],
      nameshop: map['nameshop'],
      lat: map['lat'],
      long: map['long'],
      phone: map['phone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PromotionsellerModel.fromJson(String source) =>
      PromotionsellerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PromotionsellerModel(id: $id, idSeller: $idSeller, detailpromotion: $detailpromotion, image: $image, status: $status, updatedAt: $updatedAt, nameshop: $nameshop, lat: $lat, long: $long, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PromotionsellerModel &&
        other.id == id &&
        other.idSeller == idSeller &&
        other.detailpromotion == detailpromotion &&
        other.image == image &&
        other.status == status &&
        other.updatedAt == updatedAt &&
        other.nameshop == nameshop &&
        other.lat == lat &&
        other.long == long &&
        other.phone == phone;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        idSeller.hashCode ^
        detailpromotion.hashCode ^
        image.hashCode ^
        status.hashCode ^
        updatedAt.hashCode ^
        nameshop.hashCode ^
        lat.hashCode ^
        long.hashCode ^
        phone.hashCode;
  }
}
