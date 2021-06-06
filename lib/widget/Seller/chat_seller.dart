import 'package:flutter/material.dart';



class ChatSeller extends StatefulWidget {
  @override
  _ChatSellerState createState() => _ChatSellerState();
}

class _ChatSellerState extends State<ChatSeller> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        
      },
      child: Column(
        children: [
          Text('SHOW Chat '),
        ],
      ),
    );
  }
}
