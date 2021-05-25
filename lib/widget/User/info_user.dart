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
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          Row(
            children: [
              Icon(
                Icons.account_circle_rounded,
                size: 40,
              ),
              MyStyle().mySizebox(),
              MyStyle().showTitle('ข้อมูลโปรไฟล์'),
            ],
          ),
          showImage() ?? MyStyle().showProgress(),
          Row(
            children: [
              Icon(
                Icons.person,
                size: 40,
              ),
              MyStyle().mySizebox(),
              MyStyle().showTitle('ชื่อ'),
            ],
          ),
          MyStyle().showTitleH2('วัยรุ่นทำอุปกรณ์'),
          MyStyle().mySizebox(),
          Row(
            children: [
              Icon(
                Icons.mail,
                size: 40,
              ),
              MyStyle().mySizebox(),
              MyStyle().showTitle('อีเมล'),
            ],
          ),
          MyStyle().showTitleH2('prayat@hotmail.com'),
          Row(
            children: [
              Icon(
                Icons.phone,
                size: 40,
              ),
              MyStyle().mySizebox(),
              MyStyle().showTitle('เบอร์โทรศัพท์'),
            ],
          ),
          MyStyle().showTitleH2('0898765432'),
          SizedBox(
            height: 30.0,
          ),
          ElevatedButton(
            child: Text('ออกจากระบบ'),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Widget showImage() {
    return Container(
        padding: EdgeInsets.all(20.0),
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.width * 0.5,
        child: CircleAvatar(
          backgroundImage:
              NetworkImage('https://i.ytimg.com/vi/GUw7B6OXcX4/hqdefault.jpg'),
          backgroundColor: Colors.transparent,
        ));
  }
}
