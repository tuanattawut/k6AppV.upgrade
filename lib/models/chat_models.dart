import 'dart:convert';

class ChatModel {
  String? id;
  String? message;
  String? idUser;
  String? idSeller;
  String? status;
  String? createdAt;
  String? updatedAt;
  ChatModel({
    this.id,
    this.message,
    this.idUser,
    this.idSeller,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  ChatModel copyWith({
    String? id,
    String? message,
    String? idUser,
    String? idSeller,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return ChatModel(
      id: id ?? this.id,
      message: message ?? this.message,
      idUser: idUser ?? this.idUser,
      idSeller: idSeller ?? this.idSeller,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'id_user': idUser,
      'id_seller': idSeller,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'],
      message: map['message'],
      idUser: map['id_user'],
      idSeller: map['id_seller'],
      status: map['status'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChatModel(id: $id, message: $message, idManager: $idUser, idSeller: $idSeller, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatModel &&
        other.id == id &&
        other.message == message &&
        other.idUser == idUser &&
        other.idSeller == idSeller &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        message.hashCode ^
        idUser.hashCode ^
        idSeller.hashCode ^
        status.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
