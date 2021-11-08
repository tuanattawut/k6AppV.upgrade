import 'dart:convert';

class AreaModel {
  String? idArea;
  String? idSeller;
  String? namearea;
  String? image;
  String? detail;
  String? scale;
  String? rentalfee;
  String? lat;
  String? lng;
  AreaModel({
    this.idArea,
    this.idSeller,
    this.namearea,
    this.image,
    this.detail,
    this.scale,
    this.rentalfee,
    this.lat,
    this.lng,
  });

  AreaModel copyWith({
    String? idArea,
    String? idSeller,
    String? namearea,
    String? image,
    String? detail,
    String? scale,
    String? rentalfee,
    String? lat,
    String? lng,
  }) {
    return AreaModel(
      idArea: idArea ?? this.idArea,
      idSeller: idSeller ?? this.idSeller,
      namearea: namearea ?? this.namearea,
      image: image ?? this.image,
      detail: detail ?? this.detail,
      scale: scale ?? this.scale,
      rentalfee: rentalfee ?? this.rentalfee,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_area': idArea,
      'id_seller': idSeller,
      'namearea': namearea,
      'image': image,
      'detail': detail,
      'scale': scale,
      'rentalfee': rentalfee,
      'lat': lat,
      'lng': lng,
    };
  }

  factory AreaModel.fromMap(Map<String, dynamic> map) {
    return AreaModel(
      idArea: map['id_area'] != null ? map['id_area'] : null,
      idSeller: map['id_seller'] != null ? map['id_seller'] : null,
      namearea: map['namearea'] != null ? map['namearea'] : null,
      image: map['image'] != null ? map['image'] : null,
      detail: map['detail'] != null ? map['detail'] : null,
      scale: map['scale'] != null ? map['scale'] : null,
      rentalfee: map['rentalfee'] != null ? map['rentalfee'] : null,
      lat: map['lat'] != null ? map['lat'] : null,
      lng: map['lng'] != null ? map['lng'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AreaModel.fromJson(String source) =>
      AreaModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AreaModel(idArea: $idArea, idSeller: $idSeller, namearea: $namearea, image: $image, detail: $detail, scale: $scale, rentalfee: $rentalfee, lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AreaModel &&
        other.idArea == idArea &&
        other.idSeller == idSeller &&
        other.namearea == namearea &&
        other.image == image &&
        other.detail == detail &&
        other.scale == scale &&
        other.rentalfee == rentalfee &&
        other.lat == lat &&
        other.lng == lng;
  }

  @override
  int get hashCode {
    return idArea.hashCode ^
        idSeller.hashCode ^
        namearea.hashCode ^
        image.hashCode ^
        detail.hashCode ^
        scale.hashCode ^
        rentalfee.hashCode ^
        lat.hashCode ^
        lng.hashCode;
  }
}
