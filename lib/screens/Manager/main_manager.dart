import 'package:flutter/material.dart';
import 'package:k6_app/screens/Manager/approve_seller.dart';
import 'package:k6_app/screens/Manager/manage_chat.dart';
import 'package:k6_app/screens/Manager/manage_noti.dart';
import 'package:k6_app/screens/Manager/manage_rentarea.dart';
import 'package:k6_app/screens/Manager/manage_report.dart';
import 'package:k6_app/screens/Manager/manage_user.dart';
import 'package:k6_app/screens/Seller/main_seller.dart';

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
                color: Colors.blue,
                route: ApproveSeller(),
              ),
              MyMenu(
                title: 'การใช้งานสมาชิก',
                icon: Icons.trending_up,
                color: Colors.blue,
                route: ManageUser(),
              ),
              MyMenu(
                title: 'รายงานผู้ใช้งาน',
                icon: Icons.storefront,
                color: Colors.blue,
                route: ManageReport(),
              ),
              MyMenu(
                title: 'แก้ไขข่าวสาร\nโปรโมชั่น',
                icon: Icons.info,
                color: Colors.blue,
                route: ManagePromotion(),
              ),
              MyMenu(
                title: 'จัดการเช่าจองแผง',
                icon: Icons.store_mall_directory,
                color: Colors.blue,
                route: ManageRentArea(),
              ),
              MyMenu(
                title: 'ข้อความแจ้งปัญหา',
                icon: Icons.message_outlined,
                color: Colors.blue,
                route: ManageChats(),
              ),
              MyMenu(
                  title: 'ข้อความจากผู้ขาย',
                  icon: Icons.chat,
                  color: Colors.blue,
                  route: {}),
            ],
          ),
        ));
  }
}
