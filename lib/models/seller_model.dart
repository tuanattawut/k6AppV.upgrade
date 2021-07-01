// To parse this JSON data, do
//
//     final sellerModel = sellerModelFromJson(jsonString);

import 'dart:convert';

List<SellerModel> sellerModelFromJson(String str) => List<SellerModel>.from(
    json.decode(str).map((x) => SellerModel.fromJson(x)));

String sellerModelToJson(List<SellerModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SellerModel {
  SellerModel({
    this.idSeller,
    this.name,
    this.lastname,
    this.idcard,
    this.gender,
    this.phone,
    this.birthday,
    this.email,
    this.password,
    this.image,
    this.idfb,
    this.status,
  });

  String idSeller;
  String name;
  String lastname;
  String idcard;
  String gender;
  String phone;
  DateTime birthday;
  String email;
  String password;
  String image;
  String idfb;
  String status;

  factory SellerModel.fromJson(Map<String, dynamic> json) => SellerModel(
        idSeller: json["id_seller"] == null ? null : json["id_seller"],
        name: json["name"] == null ? null : json["name"],
        lastname: json["lastname"] == null ? null : json["lastname"],
        idcard: json["idcard"] == null ? null : json["idcard"],
        gender: json["gender"] == null ? null : json["gender"],
        phone: json["phone"] == null ? null : json["phone"],
        birthday:
            json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        image: json["image"] == null ? null : json["image"],
        idfb: json["idfb"] == null ? null : json["idfb"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id_seller": idSeller == null ? null : idSeller,
        "name": name == null ? null : name,
        "lastname": lastname == null ? null : lastname,
        "idcard": idcard == null ? null : idcard,
        "gender": gender == null ? null : gender,
        "phone": phone == null ? null : phone,
        "birthday": birthday == null
            ? null
            : "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "image": image == null ? null : image,
        "idfb": idfb == null ? null : idfb,
        "status": status == null ? null : status,
      };
}
