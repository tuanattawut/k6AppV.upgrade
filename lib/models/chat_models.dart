class ChatModel {
  String name;
  String icon;
  bool isGroup;
  String time;
  String currentMessage;
  String status;
  bool select = false;
  int id;
  ChatModel({
    this.name,
    this.icon,
    this.isGroup,
    this.time,
    this.currentMessage,
    this.status,
    this.select = false,
    this.id,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatModel &&
        other.name == name &&
        other.icon == icon &&
        other.isGroup == isGroup &&
        other.time == time &&
        other.currentMessage == currentMessage &&
        other.status == status &&
        other.select == select &&
        other.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        icon.hashCode ^
        isGroup.hashCode ^
        time.hashCode ^
        currentMessage.hashCode ^
        status.hashCode ^
        select.hashCode ^
        id.hashCode;
  }
}
