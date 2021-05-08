import 'package:flutter/material.dart';
import 'package:k6_app/utility/my_style.dart';

class InformationUser extends StatefulWidget {
  @override
  _InformationUserState createState() => _InformationUserState();
}

class _InformationUserState extends State<InformationUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('ข้อมูล')),
        ),
        body: Container(
          child: ListView(
            padding: EdgeInsets.all(20),
            children: <Widget>[
              MyStyle().showTitle('ชื่อผู้ใช้'),
              MyStyle().mySizebox(),
              ElevatedButton(onPressed: () {}, child: Text('แชทกับผู้จัดการ')),
              MyStyle().mySizebox(),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('ออกจากระบบ'))
            ],
          ),
        ));
  }
}
