import 'dart:convert';

List<ShopModel> shopModelFromJson(String str) =>
    List<ShopModel>.from(json.decode(str).map((x) => ShopModel.fromJson(x)));

String shopModelToJson(List<ShopModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShopModel {
  ShopModel({
    this.idShop,
    this.idSeller,
    this.idArea,
    this.nameshop,
    this.image,
    this.lat,
    this.long,
  });

  String idShop;
  String idSeller;
  String idArea;
  String nameshop;
  String image;
  String lat;
  String long;

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
        idShop: json["id_shop"] == null ? null : json["id_shop"],
        idSeller: json["id_seller"] == null ? null : json["id_seller"],
        idArea: json["id_area"] == null ? null : json["id_area"],
        nameshop: json["nameshop"] == null ? null : json["nameshop"],
        image: json["image"] == null ? null : json["image"],
        lat: json["lat"] == null ? null : json["lat"],
        long: json["long"] == null ? null : json["long"],
      );

  Map<String, dynamic> toJson() => {
        "id_shop": idShop == null ? null : idShop,
        "id_seller": idSeller == null ? null : idSeller,
        "id_area": idArea == null ? null : idArea,
        "nameshop": nameshop == null ? null : nameshop,
        "image": image == null ? null : image,
        "lat": lat == null ? null : lat,
        "long": long == null ? null : long,
      };
}
