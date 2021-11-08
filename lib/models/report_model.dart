import 'dart:convert';

class ReportModel {
  String? message;
  String? regdate;
  String? idUser;
  String? firstname;
  String? lastname;
  String? phone;
  String? email;
  String? image;
  ReportModel({
    this.message,
    this.regdate,
    this.idUser,
    this.firstname,
    this.lastname,
    this.phone,
    this.email,
    this.image,
  });

  ReportModel copyWith({
    String? message,
    String? regdate,
    String? idUser,
    String? firstname,
    String? lastname,
    String? phone,
    String? email,
    String? image,
  }) {
    return ReportModel(
      message: message ?? this.message,
      regdate: regdate ?? this.regdate,
      idUser: idUser ?? this.idUser,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'regdate': regdate,
      'id_user': idUser,
      'firstname': firstname,
      'lastname': lastname,
      'phone': phone,
      'email': email,
      'image': image,
    };
  }

  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel(
      message: map['message'] != null ? map['message'] : null,
      regdate: map['regdate'] != null ? map['regdate'] : null,
      idUser: map['id_user'] != null ? map['id_user'] : null,
      firstname: map['firstname'] != null ? map['firstname'] : null,
      lastname: map['lastname'] != null ? map['lastname'] : null,
      phone: map['phone'] != null ? map['phone'] : null,
      email: map['email'] != null ? map['email'] : null,
      image: map['image'] != null ? map['image'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportModel.fromJson(String source) =>
      ReportModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReportModel(message: $message, regdate: $regdate, idUser: $idUser, firstname: $firstname, lastname: $lastname, phone: $phone, email: $email, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReportModel &&
        other.message == message &&
        other.regdate == regdate &&
        other.idUser == idUser &&
        other.firstname == firstname &&
        other.lastname == lastname &&
        other.phone == phone &&
        other.email == email &&
        other.image == image;
  }

  @override
  int get hashCode {
    return message.hashCode ^
        regdate.hashCode ^
        idUser.hashCode ^
        firstname.hashCode ^
        lastname.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        image.hashCode;
  }
}
