// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  UserModel({
    this.idUser,
    this.name,
    this.lastname,
    this.email,
    this.password,
    this.gender,
    this.phone,
    this.image,
    this.idfb,
  });

  String idUser;
  String name;
  String lastname;
  String email;
  String password;
  String gender;
  String phone;
  String image;
  String idfb;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        idUser: json["id_user"] == null ? null : json["id_user"],
        name: json["name"] == null ? null : json["name"],
        lastname: json["lastname"] == null ? null : json["lastname"],
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        gender: json["gender"] == null ? null : json["gender"],
        phone: json["phone"] == null ? null : json["phone"],
        image: json["image"] == null ? null : json["image"],
        idfb: json["idfb"] == null ? null : json["idfb"],
      );

  Map<String, dynamic> toJson() => {
        "id_user": idUser == null ? null : idUser,
        "name": name == null ? null : name,
        "lastname": lastname == null ? null : lastname,
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "gender": gender == null ? null : gender,
        "phone": phone == null ? null : phone,
        "image": image == null ? null : image,
        "idfb": idfb == null ? null : idfb,
      };
}
