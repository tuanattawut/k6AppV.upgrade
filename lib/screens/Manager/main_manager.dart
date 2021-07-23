import 'package:flutter/material.dart';
import 'package:k6_app/screens/Manager/approve_seller.dart';
import 'package:k6_app/screens/Manager/manage_chat.dart';
import 'package:k6_app/screens/Manager/manage_noti.dart';
import 'package:k6_app/screens/Manager/manage_rentarea.dart';
import 'package:k6_app/screens/Manager/manage_seller.dart';
import 'package:k6_app/screens/Manager/manage_user.dart';

class Homemanager extends StatefulWidget {
  @override
  _HomemanagerState createState() => _HomemanagerState();
}

class _HomemanagerState extends State<Homemanager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("สำหรับผู้จัดการ", style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: GridView.count(
            crossAxisCount: 2,
            children: <Widget>[
              MyMenu(
                title: 'จัดการผู้ขาย',
                icon: Icons.approval,
                color: Colors.red,
                route: ApproveSeller(),
              ),
              MyMenu(
                title: 'การใช้งานสมาชิก',
                icon: Icons.trending_up,
                color: Colors.pink,
                route: ManageUser(),
              ),
              MyMenu(
                title: 'จำนวนร้านค้า',
                icon: Icons.storefront,
                color: Colors.orange,
                route: ManageSeller(),
              ),
              MyMenu(
                title: 'เพิ่มแจ้งเตือน',
                icon: Icons.campaign,
                color: Colors.red,
                route: ManagePromotion(),
              ),
              MyMenu(
                title: 'จัดการเช่าจองพื้นที่',
                icon: Icons.precision_manufacturing_outlined,
                color: Colors.green,
                route: ManageRentArea(),
              ),
              MyMenu(
                title: 'ข้อความ',
                icon: Icons.chat,
                color: Colors.blue,
                route: ManageChats(),
              ),
            ],
          ),
        ));
  }
}

class MyMenu extends StatelessWidget {
  MyMenu({
    required this.title,
    required this.icon,
    required this.color,
    required this.route,
  });

  final String title;
  final IconData icon;
  final MaterialColor color;
  final route;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => route),
          );
        },
        splashColor: Colors.deepPurple,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                icon,
                size: 70,
                color: color,
              ),
              Text(title, style: TextStyle(fontSize: 20.0)),
            ],
          ),
        ),
      ),
    );
  }
}
