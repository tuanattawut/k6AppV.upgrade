import 'dart:convert';

class ReportModel {
  String? message;
  String? createdAt;
  String? id;
  String? firstname;
  String? lastname;
  String? phone;
  String? email;
  String? image;
  ReportModel({
    this.message,
    this.createdAt,
    this.id,
    this.firstname,
    this.lastname,
    this.phone,
    this.email,
    this.image,
  });

  ReportModel copyWith({
    String? message,
    String? createdAt,
    String? id,
    String? firstname,
    String? lastname,
    String? phone,
    String? email,
    String? image,
  }) {
    return ReportModel(
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
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
      'created_at': createdAt,
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'phone': phone,
      'email': email,
      'image': image,
    };
  }

  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel(
      message: map['message'],
      createdAt: map['created_at'],
      id: map['id'],
      firstname: map['firstname'],
      lastname: map['lastname'],
      phone: map['phone'],
      email: map['email'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportModel.fromJson(String source) =>
      ReportModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReportModel(message: $message, createdAt: $createdAt, id: $id, firstname: $firstname, lastname: $lastname, phone: $phone, email: $email, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReportModel &&
        other.message == message &&
        other.createdAt == createdAt &&
        other.id == id &&
        other.firstname == firstname &&
        other.lastname == lastname &&
        other.phone == phone &&
        other.email == email &&
        other.image == image;
  }

  @override
  int get hashCode {
    return message.hashCode ^
        createdAt.hashCode ^
        id.hashCode ^
        firstname.hashCode ^
        lastname.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        image.hashCode;
  }
}
