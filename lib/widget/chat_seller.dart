import 'package:flutter/material.dart';
import 'package:k6_app/models/chat_models.dart';

class ChatSeller extends StatefulWidget {
  @override
  _ChatSellerState createState() => _ChatSellerState();
}

class _ChatSellerState extends State<ChatSeller> {
  ChatModel chatModel;
  ChatModel sourchat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          showChat(),
          linePadding(),
        ],
      ),
    );
  }

  Padding linePadding() {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 80),
      child: Divider(
        thickness: 1,
      ),
    );
  }

  ListTile showChat() {
    return ListTile(
      leading: CircleAvatar(
        radius: 35,
        backgroundImage: NetworkImage(
            'https://yt3.ggpht.com/ytc/AAUvwnhhdwY7KpwmJQoW_s5Gf0Y0fNDEhhoDPkW5wh5V=s900-c-k-c0x00ffffff-no-rj'),
      ),
      title: Text(
        'ประสิทธิโชค',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Row(
        children: [
          Text(
            ' ไม่ได้อยากเป็นเสือ',
            style: TextStyle(
              fontSize: 13,
            ),
          ),
        ],
      ),
      trailing: Text('23.35'),
    );
  }
}
