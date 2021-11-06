import 'package:flutter/material.dart';
import 'package:k6_app/models/user_models.dart';
import 'package:k6_app/widget/User/newchatmana_user.dart';
import 'package:k6_app/widget/User/showchatmana_user.dart';

class ChatmanaUser extends StatefulWidget {
  ChatmanaUser({required this.usermodel});
  final UserModel usermodel;

  @override
  _ChatmanaUserState createState() => _ChatmanaUserState();
}

class _ChatmanaUserState extends State<ChatmanaUser> {
  UserModel? userModel;

  @override
  void initState() {
    super.initState();
    userModel = widget.usermodel;
  }

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
            indicatorWeight: 4,
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
            NewChatMana(usermodel: userModel!),
            ShowChatmana(),
          ],
        ),
      ),
    );
  }
}
