import 'dart:convert';

class PromotionsellerModel {
  String? idPromotionseller;
  String? idSeller;
  String? detailpromotion;
  String? image;
  String? status;
  String? regdate;
  PromotionsellerModel({
    this.idPromotionseller,
    this.idSeller,
    this.detailpromotion,
    this.image,
    this.status,
    this.regdate,
  });

  PromotionsellerModel copyWith({
    String? idPromotionseller,
    String? idSeller,
    String? detailpromotion,
    String? image,
    String? status,
    String? regdate,
  }) {
    return PromotionsellerModel(
      idPromotionseller: idPromotionseller ?? this.idPromotionseller,
      idSeller: idSeller ?? this.idSeller,
      detailpromotion: detailpromotion ?? this.detailpromotion,
      image: image ?? this.image,
      status: status ?? this.status,
      regdate: regdate ?? this.regdate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idpromotionseller': idPromotionseller,
      'id_seller': idSeller,
      'detailpromotion': detailpromotion,
      'image': image,
      'status': status,
      'regdate': regdate,
    };
  }

  factory PromotionsellerModel.fromMap(Map<String, dynamic> map) {
    return PromotionsellerModel(
      idPromotionseller:
          map['idpromotionseller'] != null ? map['idpromotionseller'] : null,
      idSeller: map['id_seller'] != null ? map['id_seller'] : null,
      detailpromotion:
          map['detailpromotion'] != null ? map['detailpromotion'] : null,
      image: map['image'] != null ? map['image'] : null,
      status: map['status'] != null ? map['status'] : null,
      regdate: map['regdate'] != null ? map['regdate'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PromotionsellerModel.fromJson(String source) =>
      PromotionsellerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PromotionsellerModel(idPromotionseller: $idPromotionseller, idSeller: $idSeller, detailpromotion: $detailpromotion, image: $image, status: $status, regdate: $regdate)';
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
        other.regdate == regdate;
  }

  @override
  int get hashCode {
    return idPromotionseller.hashCode ^
        idSeller.hashCode ^
        detailpromotion.hashCode ^
        image.hashCode ^
        status.hashCode ^
        regdate.hashCode;
  }
}
