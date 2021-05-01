import 'dart:convert';

class UserModels {
  final String name;
  final String email;
  final String phonenumber;
  final String typeuser;
  final String uid;
  UserModels({
    this.name,
    this.email,
    this.phonenumber,
    this.typeuser,
    this.uid,
  });

  UserModels copyWith({
    String name,
    String email,
    String phonenumber,
    String typeuser,
    String uid,
  }) {
    return UserModels(
      name: name ?? this.name,
      email: email ?? this.email,
      phonenumber: phonenumber ?? this.phonenumber,
      typeuser: typeuser ?? this.typeuser,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phonenumber': phonenumber,
      'typeuser': typeuser,
      'uid': uid,
    };
  }

  factory UserModels.fromMap(Map<String, dynamic> map) {
    return UserModels(
      name: map['name'],
      email: map['email'],
      phonenumber: map['phonenumber'],
      typeuser: map['typeuser'],
      uid: map['uid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModels.fromJson(String source) =>
      UserModels.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModels(name: $name, email: $email, phonenumber: $phonenumber, typeuser: $typeuser,uid: $uid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModels &&
        other.name == name &&
        other.email == email &&
        other.phonenumber == phonenumber &&
        other.typeuser == typeuser &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        phonenumber.hashCode ^
        typeuser.hashCode ^
        uid.hashCode;
  }
}
