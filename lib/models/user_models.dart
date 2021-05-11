import 'dart:convert';

class UserModels {
  String id;
  final String name;
  final String email;
  final String phone;
  final String typeuser;
  final String uid;
  String urlPicture;
  String lat;
  String lng;
  UserModels({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.typeuser,
    this.uid,
    this.urlPicture,
    this.lat,
    this.lng,
  });

  UserModels copyWith({
    String id,
    String name,
    String email,
    String phone,
    String typeuser,
    String uid,
    String urlPicture,
    String lat,
    String lng,
  }) {
    return UserModels(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      typeuser: typeuser ?? this.typeuser,
      uid: uid ?? this.uid,
      urlPicture: urlPicture ?? this.urlPicture,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'typeuser': typeuser,
      'uid': uid,
      'urlPicture': urlPicture,
      'lat': lat,
      'lng': lng,
    };
  }

  factory UserModels.fromMap(Map<String, dynamic> map) {
    return UserModels(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      typeuser: map['typeuser'],
      uid: map['uid'],
      urlPicture: map['urlPicture'],
      lat: map['lat'],
      lng: map['lng'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModels.fromJson(String source) =>
      UserModels.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModels(id: $id, name: $name, email: $email, phone: $phone, typeuser: $typeuser, uid: $uid, urlPicture: $urlPicture, lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModels &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.typeuser == typeuser &&
        other.uid == uid &&
        other.urlPicture == urlPicture &&
        other.lat == lat &&
        other.lng == lng;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        typeuser.hashCode ^
        uid.hashCode ^
        urlPicture.hashCode ^
        lat.hashCode ^
        lng.hashCode;
  }
}
