import 'package:flutter/material.dart';

import 'package:k6_app/screens/chatscreen.dart';

class ChatSeller extends StatefulWidget {
  @override
  _ChatSellerState createState() => _ChatSellerState();
}

class _ChatSellerState extends State<ChatSeller> {
  String name;
  String messageText;
  String imageUrl;
  String time;
  bool isMessageRead;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => ChatScreen(),
        );
        Navigator.push(context, route).then((value) => {});
      },
      child: Column(
        children: [
          Text('SHOW Chat '),
        ],
      ),
    );
  }
}
