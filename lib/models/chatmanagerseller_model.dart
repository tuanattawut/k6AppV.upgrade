import 'dart:convert';

class ChatmanagersellerModel {
  final String idchatmanager;
  final String message;
  final String idmanager;
  final String idseller;
  final String status;
  final String regdate;

  ChatmanagersellerModel({
    required this.idchatmanager,
    required this.message,
    required this.idmanager,
    required this.idseller,
    required this.status,
    required this.regdate,
  });

  ChatmanagersellerModel copyWith({
    String? idchatmanager,
    String? message,
    String? idmanager,
    String? idseller,
    String? status,
    String? regdate,
  }) {
    return ChatmanagersellerModel(
      idchatmanager: idchatmanager ?? this.idchatmanager,
      message: message ?? this.message,
      idmanager: idmanager ?? this.idmanager,
      idseller: idseller ?? this.idseller,
      status: status ?? this.status,
      regdate: regdate ?? this.regdate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_chatmanager': idchatmanager,
      'message': message,
      'id_manager': idmanager,
      'id_seller': idseller,
      'status': status,
      'regdate': regdate,
    };
  }

  factory ChatmanagersellerModel.fromMap(Map<String, dynamic> map) {
    return ChatmanagersellerModel(
      idchatmanager: map['id_chatmanager'],
      message: map['message'],
      idmanager: map['id_manager'],
      idseller: map['id_seller'],
      status: map['status'],
      regdate: map['regdate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatmanagersellerModel.fromJson(String source) =>
      ChatmanagersellerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChatmanagersellerModel(idchatmanager: $idchatmanager, message: $message, idmanager: $idmanager, idseller: $idseller, status: $status, regdate: $regdate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatmanagersellerModel &&
        other.idchatmanager == idchatmanager &&
        other.message == message &&
        other.idmanager == idmanager &&
        other.idseller == idseller &&
        other.status == status &&
        other.regdate == regdate;
  }

  @override
  int get hashCode {
    return idchatmanager.hashCode ^
        message.hashCode ^
        idmanager.hashCode ^
        idseller.hashCode ^
        status.hashCode ^
        regdate.hashCode;
  }
}
