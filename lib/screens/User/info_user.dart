import 'package:flutter/material.dart';
import 'package:k6_app/models/user_models.dart';
import 'package:k6_app/screens/User/chatmana_user.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';

class InformationUser extends StatefulWidget {
  InformationUser({this.usermodel});
  final UserModel usermodel;

  @override
  _InformationUserState createState() => _InformationUserState();
}

class _InformationUserState extends State<InformationUser> {
  UserModel userModel;

  @override
  void initState() {
    super.initState();
    userModel = widget.usermodel;
  }

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
          showImage(),
          MyStyle().mySizebox(),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child:
                      _buildCard('ชื่อ', '${userModel.name ?? 'กำลังโหลด'}')),
              Expanded(
                flex: 1,
                child: _buildCard(
                    'นามสกุล', '${userModel.lastname ?? 'กำลังโหลด'}'),
              ),
            ],
          ),
          _buildCard('เพศ', '${userModel.gender ?? 'กำลังโหลด'}'),
          _buildCard('อีเมล', '${userModel.email ?? 'กำลังโหลด'}'),
          _buildCard('เบอร์โทรศัพท์', '${userModel.phone ?? 'กำลังโหลด'}'),
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
                  '${MyConstant().domain}/${userModel.image}',
                ) ==
                null
            ? Image.asset(
                'images/user.png',
                height: 150,
                width: 150,
              )
            : NetworkImage(
                '${MyConstant().domain}/${userModel.image}',
              ),
        radius: 60,
      ),
    );
  }

  Widget _buildCard(String title, String titleH2) {
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
