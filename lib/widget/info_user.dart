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
          title: Center(
        child: Text('หน้าโปรไฟล์'),
      )),
      body: ListView(
        padding: EdgeInsets.all(5.0),
        children: <Widget>[
          showImage() ?? MyStyle().showProgress(),
          MyStyle().showTitle('ชื่อ: วัยรุ่นทำอุปกรณ์'),
          MyStyle().mySizebox(),
          MyStyle().showTitle('อีเมล: prayat@hotmail.com'),
        ],
      ),
    );
  }

  Widget showImage() {
    return Container(
      width: 300.0,
      height: 300.0,
      child: Image.network(
          'https://www.catdumb.com/wp-content/uploads/2021/05/hey-wai-roon-10.png'),
    );
  }
}
