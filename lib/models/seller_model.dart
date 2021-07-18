import 'dart:convert';

class SellerModel {
  final String idSeller;
  final String name;
  final String lastname;
  final String idcard;
  final String gender;
  final String phone;
  final DateTime birthday;
  final String email;
  final String password;
  final String image;
  final String idfb;
  final String status;
  SellerModel({
    required this.idSeller,
    required this.name,
    required this.lastname,
    required this.idcard,
    required this.gender,
    required this.phone,
    required this.birthday,
    required this.email,
    required this.password,
    required this.image,
    required this.idfb,
    required this.status,
  });

  SellerModel copyWith({
    String? idSeller,
    String? name,
    String? lastname,
    String? idcard,
    String? gender,
    String? phone,
    DateTime? birthday,
    String? email,
    String? password,
    String? image,
    String? idfb,
    String? status,
  }) {
    return SellerModel(
      idSeller: idSeller ?? this.idSeller,
      name: name ?? this.name,
      lastname: lastname ?? this.lastname,
      idcard: idcard ?? this.idcard,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      birthday: birthday ?? this.birthday,
      email: email ?? this.email,
      password: password ?? this.password,
      image: image ?? this.image,
      idfb: idfb ?? this.idfb,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_seller': idSeller,
      'name': name,
      'lastname': lastname,
      'idcard': idcard,
      'gender': gender,
      'phone': phone,
      'birthday': birthday,
      'email': email,
      'password': password,
      'image': image,
      'idfb': idfb,
      'status': status,
    };
  }

  factory SellerModel.fromMap(Map<String, dynamic> map) {
    return SellerModel(
      idSeller: map['id_seller'],
      name: map['name'],
      lastname: map['lastname'],
      idcard: map['idcard'],
      gender: map['gender'],
      phone: map['phone'],
      birthday: DateTime.parse(map['birthday']),
      email: map['email'],
      password: map['password'],
      image: map['image'],
      idfb: map['idfb'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SellerModel.fromJson(String source) =>
      SellerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SellerModel(idSeller: $idSeller, name: $name, lastname: $lastname, idcard: $idcard, gender: $gender, phone: $phone,birthday: $birthday, email: $email, password: $password, image: $image, idfb: $idfb, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SellerModel &&
        other.idSeller == idSeller &&
        other.name == name &&
        other.lastname == lastname &&
        other.idcard == idcard &&
        other.gender == gender &&
        other.phone == phone &&
        other.birthday == birthday &&
        other.email == email &&
        other.password == password &&
        other.image == image &&
        other.idfb == idfb &&
        other.status == status;
  }

  @override
  int get hashCode {
    return idSeller.hashCode ^
        name.hashCode ^
        lastname.hashCode ^
        idcard.hashCode ^
        gender.hashCode ^
        phone.hashCode ^
        birthday.hashCode ^
        email.hashCode ^
        password.hashCode ^
        image.hashCode ^
        idfb.hashCode ^
        status.hashCode;
  }
}
