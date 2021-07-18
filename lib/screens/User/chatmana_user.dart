import 'package:flutter/material.dart';
import 'package:k6_app/widget/User/newchatmana_user.dart';
import 'package:k6_app/widget/User/showchatmana_user.dart';

class ChatmanaUser extends StatefulWidget {
  @override
  _ChatmanaUserState createState() => _ChatmanaUserState();
}

class _ChatmanaUserState extends State<ChatmanaUser> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('ติดต่อผู้จัดการ'),
          bottom: TabBar(
            unselectedLabelColor: Colors.white,
            labelColor: Colors.yellow,
            indicatorWeight: 4,
            indicatorColor: Colors.yellow,
            tabs: <Widget>[
              Tab(
                text: ('สร้างข้อความ'),
              ),
              Tab(
                text: ('รายการข้อความ'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            NewChatMana(),
            ShowChatmana(),
          ],
        ),
      ),
    );
  }
}
