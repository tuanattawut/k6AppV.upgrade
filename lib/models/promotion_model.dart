import 'dart:convert';

class PromotionModel {
  String idPromotion;
  String imgUrl;
  String regdate;
  PromotionModel({
    required this.idPromotion,
    required this.imgUrl,
    required this.regdate,
  });

  PromotionModel copyWith({
    String? idPromotion,
    String? imgUrl,
    String? regdate,
  }) {
    return PromotionModel(
      idPromotion: idPromotion ?? this.idPromotion,
      imgUrl: imgUrl ?? this.imgUrl,
      regdate: regdate ?? this.regdate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_promotion': idPromotion,
      'imgUrl': imgUrl,
      'regdate': regdate,
    };
  }

  factory PromotionModel.fromMap(Map<String, dynamic> map) {
    return PromotionModel(
      idPromotion: map['id_promotion'],
      imgUrl: map['imgUrl'],
      regdate: map['regdate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PromotionModel.fromJson(String source) =>
      PromotionModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'PromotionModel(idPromotion: $idPromotion, imgUrl: $imgUrl, regdate: $regdate)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PromotionModel &&
        other.idPromotion == idPromotion &&
        other.imgUrl == imgUrl &&
        other.regdate == regdate;
  }

  @override
  int get hashCode => idPromotion.hashCode ^ imgUrl.hashCode ^ regdate.hashCode;
}
