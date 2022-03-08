import 'dart:convert';

class SellerModel {
  final String idSeller;
  final String firstname;
  final String lastname;
  final String idcard;
  final String gender;
  final String phone;
  final DateTime birthday;
  final String email;
  final String password;
  final String image;
  final String role;
  SellerModel({
    required this.idSeller,
    required this.firstname,
    required this.lastname,
    required this.idcard,
    required this.gender,
    required this.phone,
    required this.birthday,
    required this.email,
    required this.password,
    required this.image,
    required this.role,
  });

  SellerModel copyWith({
    String? idSeller,
    String? firstname,
    String? lastname,
    String? idcard,
    String? gender,
    String? phone,
    DateTime? birthday,
    String? email,
    String? password,
    String? image,
    String? role,
  }) {
    return SellerModel(
      idSeller: idSeller ?? this.idSeller,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      idcard: idcard ?? this.idcard,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      birthday: birthday ?? this.birthday,
      email: email ?? this.email,
      password: password ?? this.password,
      image: image ?? this.image,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': idSeller,
      'firstname': firstname,
      'lastname': lastname,
      'idcard': idcard,
      'gender': gender,
      'phone': phone,
      'birthday': birthday.millisecondsSinceEpoch,
      'email': email,
      'password': password,
      'image': image,
      'role': role,
    };
  }

  factory SellerModel.fromMap(Map<String, dynamic> map) {
    return SellerModel(
      idSeller: map['id'].toString(),
      firstname: map['firstname'],
      lastname: map['lastname'],
      idcard: map['idcard'],
      gender: map['gender'],
      phone: map['phone'],
      birthday: DateTime.parse(map['birthday']),
      email: map['email'],
      password: map['password'],
      image: map['image'],
      role: map['role'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SellerModel.fromJson(String source) =>
      SellerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SellerModel(idSeller: $idSeller, firstname: $firstname, lastname: $lastname, idcard: $idcard, gender: $gender, phone: $phone, birthday: $birthday, email: $email, password: $password, image: $image, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SellerModel &&
        other.idSeller == idSeller &&
        other.firstname == firstname &&
        other.lastname == lastname &&
        other.idcard == idcard &&
        other.gender == gender &&
        other.phone == phone &&
        other.birthday == birthday &&
        other.email == email &&
        other.password == password &&
        other.image == image &&
        other.role == role;
  }

  @override
  int get hashCode {
    return idSeller.hashCode ^
        firstname.hashCode ^
        lastname.hashCode ^
        idcard.hashCode ^
        gender.hashCode ^
        phone.hashCode ^
        birthday.hashCode ^
        email.hashCode ^
        password.hashCode ^
        image.hashCode ^
        role.hashCode;
  }
}
