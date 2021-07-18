// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  String idUser;
  String name;
  String lastname;
  String email;
  String password;
  String gender;
  String phone;
  String image;
  String idfb;
  UserModel({
    required this.idUser,
    required this.name,
    required this.lastname,
    required this.email,
    required this.password,
    required this.gender,
    required this.phone,
    required this.image,
    required this.idfb,
  });

  UserModel copyWith({
    String? idUser,
    String? name,
    String? lastname,
    String? email,
    String? password,
    String? gender,
    String? phone,
    String? image,
    String? idfb,
  }) {
    return UserModel(
      idUser: idUser ?? this.idUser,
      name: name ?? this.name,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      password: password ?? this.password,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      idfb: idfb ?? this.idfb,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idUser': idUser,
      'name': name,
      'lastname': lastname,
      'email': email,
      'password': password,
      'gender': gender,
      'phone': phone,
      'image': image,
      'idfb': idfb,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      idUser: map['idUser'],
      name: map['name'],
      lastname: map['lastname'],
      email: map['email'],
      password: map['password'],
      gender: map['gender'],
      phone: map['phone'],
      image: map['image'],
      idfb: map['idfb'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(idUser: $idUser, name: $name, lastname: $lastname, email: $email, password: $password, gender: $gender, phone: $phone, image: $image, idfb: $idfb)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.idUser == idUser &&
        other.name == name &&
        other.lastname == lastname &&
        other.email == email &&
        other.password == password &&
        other.gender == gender &&
        other.phone == phone &&
        other.image == image &&
        other.idfb == idfb;
  }

  @override
  int get hashCode {
    return idUser.hashCode ^
        name.hashCode ^
        lastname.hashCode ^
        email.hashCode ^
        password.hashCode ^
        gender.hashCode ^
        phone.hashCode ^
        image.hashCode ^
        idfb.hashCode;
  }
}
