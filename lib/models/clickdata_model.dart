import 'dart:convert';

class ClickdataModel {
  String? id;
  String? idUser;
  String? idProduct;
  String? view;
  String? createdAt;
  String? updatedAt;
  ClickdataModel({
    this.id,
    this.idUser,
    this.idProduct,
    this.view,
    this.createdAt,
    this.updatedAt,
  });

  ClickdataModel copyWith({
    String? id,
    String? idUser,
    String? idProduct,
    String? view,
    String? createdAt,
    String? updatedAt,
  }) {
    return ClickdataModel(
      id: id ?? this.id,
      idUser: idUser ?? this.idUser,
      idProduct: idProduct ?? this.idProduct,
      view: view ?? this.view,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_user': idUser,
      'id_product': idProduct,
      'view': view,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory ClickdataModel.fromMap(Map<String, dynamic> map) {
    return ClickdataModel(
      id: map['id'],
      idUser: map['id_user'],
      idProduct: map['id_product'],
      view: map['view'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ClickdataModel.fromJson(String source) =>
      ClickdataModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ClickdataModel(id: $id, idUser: $idUser, idProduct: $idProduct, view: $view, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClickdataModel &&
        other.id == id &&
        other.idUser == idUser &&
        other.idProduct == idProduct &&
        other.view == view &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        idUser.hashCode ^
        idProduct.hashCode ^
        view.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
