import 'package:flutter/material.dart';

class ChatSeller extends StatefulWidget {
  @override
  _ChatSellerState createState() => _ChatSellerState();
}

class _ChatSellerState extends State<ChatSeller> {
  @override
  Widget build(BuildContext context) {
    return showChat();
  }

  Container showChat() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                border: Border.all(width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal.shade500.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  )
                ]),
            child: CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(
                  'https://i.pinimg.com/originals/32/54/6c/32546c416f82b5140e31bfb0b9124467.jpg'),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.65,
            padding: EdgeInsets.only(left: 20),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Park Ji Sung'),
                    Text('02.05 AM'),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
