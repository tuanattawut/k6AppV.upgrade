import 'package:flutter/material.dart';

class ManageUser extends StatefulWidget {
  @override
  _ManageUserState createState() => _ManageUserState();
}

class _ManageUserState extends State<ManageUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('จัดการผู้ใช้'),
      ),
    );
  }
}
