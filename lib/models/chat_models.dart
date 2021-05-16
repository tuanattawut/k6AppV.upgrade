import 'dart:convert';

class ChatModel {
  String name;
  String messageText;
  String imageURL;
  String time;
  ChatModel({
    this.name,
    this.messageText,
    this.imageURL,
    this.time,
  });

  ChatModel copyWith({
    String name,
    String messageText,
    String imageURL,
    String time,
  }) {
    return ChatModel(
      name: name ?? this.name,
      messageText: messageText ?? this.messageText,
      imageURL: imageURL ?? this.imageURL,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'messageText': messageText,
      'imageURL': imageURL,
      'time': time,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      name: map['name'],
      messageText: map['messageText'],
      imageURL: map['imageURL'],
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChatModel(name: $name, messageText: $messageText, imageURL: $imageURL, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatModel &&
        other.name == name &&
        other.messageText == messageText &&
        other.imageURL == imageURL &&
        other.time == time;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        messageText.hashCode ^
        imageURL.hashCode ^
        time.hashCode;
  }
}
