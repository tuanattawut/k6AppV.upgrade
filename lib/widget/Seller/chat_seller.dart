import 'package:flutter/material.dart';

class ChatSeller extends StatefulWidget {
  @override
  _ChatSellerState createState() => _ChatSellerState();
}

class _ChatSellerState extends State<ChatSeller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แชท'),
      ),
      body: Center(
        child: Text(
          'Coming SOON',
          style: TextStyle(fontSize: 60),
        ),
      ),
    );
  }
}
