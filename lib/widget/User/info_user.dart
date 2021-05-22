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
      padding: EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          image: DecorationImage(
            image: NetworkImage(
                'https://i.ytimg.com/vi/zW_9uX_HYj0/mqdefault.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
