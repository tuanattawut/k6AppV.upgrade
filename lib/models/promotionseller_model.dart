import 'dart:convert';

class PromotionsellerModel {
  String? idPromotionseller;
  String? idSeller;
  String? detailpromotion;
  String? image;
  String? status;
  String? updatedAt;
  String? nameshop;
  PromotionsellerModel({
    this.idPromotionseller,
    this.idSeller,
    this.detailpromotion,
    this.image,
    this.status,
    this.updatedAt,
    this.nameshop,
  });

  PromotionsellerModel copyWith({
    String? idPromotionseller,
    String? idSeller,
    String? detailpromotion,
    String? image,
    String? status,
    String? updatedAt,
    String? nameshop,
  }) {
    return PromotionsellerModel(
      idPromotionseller: idPromotionseller ?? this.idPromotionseller,
      idSeller: idSeller ?? this.idSeller,
      detailpromotion: detailpromotion ?? this.detailpromotion,
      image: image ?? this.image,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
      nameshop: nameshop ?? this.nameshop,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': idPromotionseller,
      'id_seller': idSeller,
      'detailpromotion': detailpromotion,
      'image': image,
      'status': status,
      'updated_at': updatedAt,
      'nameshop': nameshop,
    };
  }

  factory PromotionsellerModel.fromMap(Map<String, dynamic> map) {
    return PromotionsellerModel(
      idPromotionseller: map['id'] != null ? map['id'] : null,
      idSeller: map['id_seller'] != null ? map['id_seller'] : null,
      detailpromotion:
          map['detailpromotion'] != null ? map['detailpromotion'] : null,
      image: map['image'] != null ? map['image'] : null,
      status: map['status'] != null ? map['status'] : null,
      updatedAt: map['updated_at'] != null ? map['updated_at'] : null,
      nameshop: map['nameshop'] != null ? map['nameshop'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PromotionsellerModel.fromJson(String source) =>
      PromotionsellerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PromotionsellerModel(idPromotionseller: $idPromotionseller, idSeller: $idSeller, detailpromotion: $detailpromotion, image: $image, status: $status, updated_at: $updatedAt,nameshop: $nameshop)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PromotionsellerModel &&
        other.idPromotionseller == idPromotionseller &&
        other.idSeller == idSeller &&
        other.detailpromotion == detailpromotion &&
        other.image == image &&
        other.status == status &&
        other.updatedAt == updatedAt &&
        other.nameshop == nameshop;
  }

  @override
  int get hashCode {
    return idPromotionseller.hashCode ^
        idSeller.hashCode ^
        detailpromotion.hashCode ^
        image.hashCode ^
        status.hashCode ^
        updatedAt.hashCode ^
        nameshop.hashCode;
  }
}
