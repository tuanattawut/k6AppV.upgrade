import 'package:flutter/material.dart';
import 'package:k6_app/screens/User/chatmana_user.dart';
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
          MyStyle().mySizebox(),
          showImage() ?? MyStyle().showProgress(),
          MyStyle().mySizebox(),
          _buildCard(Icons.person, 'ชื่อ', 'USER TEST'),
          _buildCard(Icons.email, 'อีเมล', 'TEST_USER@mail.com'),
          _buildCard(Icons.phone, 'เบอร์โทรศัพท์', '0000000000'),
          SizedBox(
            height: 30.0,
          ),
          ElevatedButton.icon(
            label: Text('ติดต่อผู้จัดการ'),
            icon: Icon(Icons.manage_accounts),
            onPressed: () {
              MaterialPageRoute route = MaterialPageRoute(
                builder: (value) => ChatmanaUser(),
              );
              Navigator.of(context).push(route);
            },
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
    return Center(
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(
            "https://i.pinimg.com/originals/51/f6/fb/51f6fb256629fc755b8870c801092942.png"),
        radius: 70,
      ),
    );
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
