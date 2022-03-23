import 'dart:convert';

class ChatmanagersellerModel {
  String? id;
  String? message;
  String? idManager;
  String? idSeller;
  String? status;
  String? createdAt;
  String? updatedAt;

  ChatmanagersellerModel({
    this.id,
    required this.message,
    this.idManager,
    this.idSeller,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  ChatmanagersellerModel copyWith({
    String? id,
    String? message,
    String? idManager,
    String? idSeller,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return ChatmanagersellerModel(
      id: id ?? this.id,
      message: message ?? this.message,
      idManager: idManager ?? this.idManager,
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
      'id_manager': idManager,
      'id_seller': idSeller,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory ChatmanagersellerModel.fromMap(Map<String, dynamic> map) {
    return ChatmanagersellerModel(
      id: map['id'],
      message: map['message'],
      idManager: map['id_manager'],
      idSeller: map['id_seller'],
      status: map['status'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatmanagersellerModel.fromJson(String source) =>
      ChatmanagersellerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChatmanagersellerModel(id: $id, message: $message, idManager: $idManager, idSeller: $idSeller, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatmanagersellerModel &&
        other.id == id &&
        other.message == message &&
        other.idManager == idManager &&
        other.idSeller == idSeller &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        message.hashCode ^
        idManager.hashCode ^
        idSeller.hashCode ^
        status.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
