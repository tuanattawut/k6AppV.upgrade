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
  String firstname;
  String lastname;
  String email;
  String password;
  String gender;
  String phone;
  String image;

  UserModel({
    required this.idUser,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    required this.gender,
    required this.phone,
    required this.image,
  });

  UserModel copyWith({
    String? idUser,
    String? firstname,
    String? lastname,
    String? email,
    String? password,
    String? gender,
    String? phone,
    String? image,
  }) {
    return UserModel(
      idUser: idUser ?? this.idUser,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      password: password ?? this.password,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idUser': idUser,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password,
      'gender': gender,
      'phone': phone,
      'image': image,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      idUser: map['idUser'],
      firstname: map['firstname'],
      lastname: map['lastname'],
      email: map['email'],
      password: map['password'],
      gender: map['gender'],
      phone: map['phone'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(idUser: $idUser, firstname: $firstname, lastname: $lastname, email: $email, password: $password, gender: $gender, phone: $phone, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.idUser == idUser &&
        other.firstname == firstname &&
        other.lastname == lastname &&
        other.email == email &&
        other.password == password &&
        other.gender == gender &&
        other.phone == phone &&
        other.image == image;
  }

  @override
  int get hashCode {
    return idUser.hashCode ^
        firstname.hashCode ^
        lastname.hashCode ^
        email.hashCode ^
        password.hashCode ^
        gender.hashCode ^
        phone.hashCode ^
        image.hashCode;
  }
}
