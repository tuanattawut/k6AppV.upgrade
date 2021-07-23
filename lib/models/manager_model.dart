import 'dart:convert';

class ManagerModel {
  String? idmanager;
  String? email;
  String? password;
  ManagerModel({
    this.idmanager,
    this.email,
    this.password,
  });

  ManagerModel copyWith({
    String? idmanager,
    String? email,
    String? password,
  }) {
    return ManagerModel(
      idmanager: idmanager ?? this.idmanager,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idmanager': idmanager,
      'email': email,
      'password': password,
    };
  }

  factory ManagerModel.fromMap(Map<String, dynamic> map) {
    return ManagerModel(
      idmanager: map['idmanager'],
      email: map['email'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ManagerModel.fromJson(String source) =>
      ManagerModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ManagerModel(idmanager: $idmanager, email: $email, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ManagerModel &&
        other.idmanager == idmanager &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode => idmanager.hashCode ^ email.hashCode ^ password.hashCode;
}
