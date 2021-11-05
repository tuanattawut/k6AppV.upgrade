import 'dart:convert';

class ChatModel {
  final String idchat;
  final String message;
  final String iduser;
  final String idseller;
  final String status;
  final String regdate;
  ChatModel({
    required this.idchat,
    required this.message,
    required this.iduser,
    required this.idseller,
    required this.status,
    required this.regdate,
  });

  ChatModel copyWith({
    String? idchat,
    String? message,
    String? iduser,
    String? idseller,
    String? status,
    String? regdate,
  }) {
    return ChatModel(
      idchat: idchat ?? this.idchat,
      message: message ?? this.message,
      iduser: iduser ?? this.iduser,
      idseller: idseller ?? this.idseller,
      status: status ?? this.status,
      regdate: regdate ?? this.regdate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_chat': idchat,
      'message': message,
      'id_user': iduser,
      'id_seller': idseller,
      'status': status,
      'regdate': regdate,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      idchat: map['id_chat'],
      message: map['message'],
      iduser: map['id_user'],
      idseller: map['id_seller'],
      status: map['status'],
      regdate: map['regdate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChatModel(id_chat: $idchat, message: $message, id_user: $iduser, id_seller: $idseller, status: $status, regdate: $regdate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatModel &&
        other.idchat == idchat &&
        other.message == message &&
        other.iduser == iduser &&
        other.idseller == idseller &&
        other.status == status &&
        other.regdate == regdate;
  }

  @override
  int get hashCode {
    return idchat.hashCode ^
        message.hashCode ^
        iduser.hashCode ^
        idseller.hashCode ^
        status.hashCode ^
        regdate.hashCode;
  }
}
