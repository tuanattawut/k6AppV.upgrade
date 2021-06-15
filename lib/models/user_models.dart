import 'dart:convert';

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  UserModel({
    this.id,
    this.typeuser,
    this.name,
    this.email,
    this.password,
    this.phone,
    this.imageavatar,
    this.nameshop,
    this.imageshop,
    this.lat,
    this.lng,
  });

  String id;
  String typeuser;
  String name;
  String email;
  String password;
  String phone;
  dynamic imageavatar;
  String nameshop;
  String imageshop;
  String lat;
  String lng;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] == null ? null : json["id"],
        typeuser: json["typeuser"] == null ? null : json["typeuser"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        phone: json["phone"] == null ? null : json["phone"],
        imageavatar: json["imageavatar"],
        nameshop: json["nameshop"] == null ? null : json["nameshop"],
        imageshop: json["imageshop"] == null ? null : json["imageshop"],
        lat: json["lat"] == null ? null : json["lat"],
        lng: json["lng"] == null ? null : json["lng"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "typeuser": typeuser == null ? null : typeuser,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "phone": phone == null ? null : phone,
        "imageavatar": imageavatar,
        "nameshop": nameshop == null ? null : nameshop,
        "imageshop": imageshop == null ? null : imageshop,
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
      };
}
