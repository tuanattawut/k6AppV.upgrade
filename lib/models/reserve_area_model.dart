import 'dart:convert';

class ResearveAreaModel {
  String? idSeller1;
  String? firstname;
  String? lastname;
  String? idcard;
  String? phone;
  String? gender;
  String? birthday;
  String? email;
  String? image;
  String? idArea;
  String? idSeller;
  String? namearea;
  String? detail;
  String? scale;
  String? rentalfee;
  String? lat;
  String? lng;
  String? regdate;
  ResearveAreaModel({
    this.idSeller1,
    this.firstname,
    this.lastname,
    this.idcard,
    this.phone,
    this.gender,
    this.birthday,
    this.email,
    this.image,
    this.idArea,
    this.idSeller,
    this.namearea,
    this.detail,
    this.scale,
    this.rentalfee,
    this.lat,
    this.lng,
    this.regdate,
  });

  ResearveAreaModel copyWith({
    String? idSeller1,
    String? firstname,
    String? lastname,
    String? idcard,
    String? phone,
    String? gender,
    String? birthday,
    String? email,
    String? image,
    String? idArea,
    String? idSeller,
    String? namearea,
    String? detail,
    String? scale,
    String? rentalfee,
    String? lat,
    String? lng,
    String? regdate,
  }) {
    return ResearveAreaModel(
      idSeller1: idSeller1 ?? this.idSeller1,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      idcard: idcard ?? this.idcard,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      email: email ?? this.email,
      image: image ?? this.image,
      idArea: idArea ?? this.idArea,
      idSeller: idSeller ?? this.idSeller,
      namearea: namearea ?? this.namearea,
      detail: detail ?? this.detail,
      scale: scale ?? this.scale,
      rentalfee: rentalfee ?? this.rentalfee,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      regdate: regdate ?? this.regdate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idSeller': idSeller1,
      'firstname': firstname,
      'lastname': lastname,
      'idcard': idcard,
      'phone': phone,
      'gender': gender,
      'birthday': birthday,
      'email': email,
      'image': image,
      'id_area': idArea,
      'id_seller': idSeller,
      'namearea': namearea,
      'detail': detail,
      'scale': scale,
      'rentalfee': rentalfee,
      'lat': lat,
      'lng': lng,
      'regdate': regdate,
    };
  }

  factory ResearveAreaModel.fromMap(Map<String, dynamic> map) {
    return ResearveAreaModel(
      idSeller1: map['idSeller'] != null ? map['idSeller'] : null,
      firstname: map['firstname'] != null ? map['firstname'] : null,
      lastname: map['lastname'] != null ? map['lastname'] : null,
      idcard: map['idcard'] != null ? map['idcard'] : null,
      phone: map['phone'] != null ? map['phone'] : null,
      gender: map['gender'] != null ? map['gender'] : null,
      birthday: map['birthday'] != null ? map['birthday'] : null,
      email: map['email'] != null ? map['email'] : null,
      image: map['image'] != null ? map['image'] : null,
      idArea: map['id_area'] != null ? map['id_area'] : null,
      idSeller: map['id_seller'] != null ? map['id_seller'] : null,
      namearea: map['namearea'] != null ? map['namearea'] : null,
      detail: map['detail'] != null ? map['detail'] : null,
      scale: map['scale'] != null ? map['scale'] : null,
      rentalfee: map['rentalfee'] != null ? map['rentalfee'] : null,
      lat: map['lat'] != null ? map['lat'] : null,
      lng: map['lng'] != null ? map['lng'] : null,
      regdate: map['regdate'] != null ? map['regdate'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResearveAreaModel.fromJson(String source) =>
      ResearveAreaModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ResearveAreaModel(idSeller1: $idSeller1, firstname: $firstname, lastname: $lastname, idcard: $idcard, phone: $phone, gender: $gender, birthday: $birthday, email: $email, image: $image, idArea: $idArea, idSeller: $idSeller, namearea: $namearea, detail: $detail, scale: $scale, rentalfee: $rentalfee, lat: $lat, lng: $lng, regdate: $regdate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResearveAreaModel &&
        other.idSeller1 == idSeller1 &&
        other.firstname == firstname &&
        other.lastname == lastname &&
        other.idcard == idcard &&
        other.phone == phone &&
        other.gender == gender &&
        other.birthday == birthday &&
        other.email == email &&
        other.image == image &&
        other.idArea == idArea &&
        other.idSeller == idSeller &&
        other.namearea == namearea &&
        other.detail == detail &&
        other.scale == scale &&
        other.rentalfee == rentalfee &&
        other.lat == lat &&
        other.lng == lng &&
        other.regdate == regdate;
  }

  @override
  int get hashCode {
    return idSeller1.hashCode ^
        firstname.hashCode ^
        lastname.hashCode ^
        idcard.hashCode ^
        phone.hashCode ^
        gender.hashCode ^
        birthday.hashCode ^
        email.hashCode ^
        image.hashCode ^
        idArea.hashCode ^
        idSeller.hashCode ^
        namearea.hashCode ^
        detail.hashCode ^
        scale.hashCode ^
        rentalfee.hashCode ^
        lat.hashCode ^
        lng.hashCode ^
        regdate.hashCode;
  }
}
