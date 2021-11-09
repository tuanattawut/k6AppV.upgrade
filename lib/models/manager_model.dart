import 'dart:convert';

class ManagerModel {
  String? idmanager;
  String? email;
  String? password;
  String? firstname;
  String? lastname;
  ManagerModel({
    this.idmanager,
    this.email,
    this.password,
    this.firstname,
    this.lastname,
  });

  ManagerModel copyWith({
    String? idmanager,
    String? email,
    String? password,
    String? firstname,
    String? lastname,
  }) {
    return ManagerModel(
      idmanager: idmanager ?? this.idmanager,
      email: email ?? this.email,
      password: password ?? this.password,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_manager': idmanager,
      'email': email,
      'password': password,
      'firstname': firstname,
      'lastname': lastname,
    };
  }

  factory ManagerModel.fromMap(Map<String, dynamic> map) {
    return ManagerModel(
      idmanager: map['id_manager'],
      email: map['email'],
      password: map['password'],
      firstname: map['firstname'],
      lastname: map['lastname'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ManagerModel.fromJson(String source) =>
      ManagerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ManagerModel(idmanager: $idmanager, email: $email, password: $password, firstname: $firstname, lastname: $lastname)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ManagerModel &&
        other.idmanager == idmanager &&
        other.email == email &&
        other.password == password &&
        other.firstname == firstname &&
        other.lastname == lastname;
  }

  @override
  int get hashCode {
    return idmanager.hashCode ^
        email.hashCode ^
        password.hashCode ^
        firstname.hashCode ^
        lastname.hashCode;
  }
}
