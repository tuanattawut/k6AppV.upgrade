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
                size: 25,
              ),
              MyStyle().mySizebox(),
              MyStyle().showTitle('ข้อมูลโปรไฟล์'),
            ],
          ),
          showImage() ?? MyStyle().showProgress(),
          _buildCard(Icons.person, 'ชื่อ', 'วัยรุ่นทำอุปกรณ์'),
          _buildCard(Icons.email, 'อีเมล', 'Prayat@mail.com'),
          _buildCard(Icons.phone, 'เบอร์โทรศัพท์', '0987654321'),
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

  Widget _buildCard(IconData icon, String title, String titleH2) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      color: Colors.white38,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 25,
                ),
                MyStyle().mySizebox(),
                MyStyle().showTitle(title),
              ],
            ),
            Text(
              titleH2,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
