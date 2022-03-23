import 'package:flutter/material.dart';
import 'package:k6_app/models/manager_model.dart';
import 'package:k6_app/screens/Manager/approve_promotionseller.dart';
import 'package:k6_app/screens/Manager/approve_seller.dart';
import 'package:k6_app/screens/Manager/chat_manager.dart';
import 'package:k6_app/screens/Manager/manage_chat.dart';
import 'package:k6_app/screens/Manager/manage_noti.dart';
import 'package:k6_app/screens/Manager/manage_rentarea.dart';
import 'package:k6_app/screens/Manager/manage_report.dart';
import 'package:k6_app/screens/Manager/manage_user.dart';
import 'package:k6_app/screens/Manager/searchshop_manager.dart';
import 'package:k6_app/screens/Manager/shownoti_manager.dart';
import 'package:k6_app/screens/Seller/main_seller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homemanager extends StatefulWidget {
  Homemanager({required this.managerModel});
  final ManagerModel managerModel;
  @override
  _HomemanagerState createState() => _HomemanagerState();
}

class _HomemanagerState extends State<Homemanager> {
  ManagerModel? managerModel;
  @override
  void initState() {
    super.initState();
    managerModel = widget.managerModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("สำหรับผู้จัดการ", style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  confirmExit();
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
                  route: ChatManager(
                    managerModel: managerModel!,
                  )),
              MyMenu(
                title: 'ค้นหาร้าน\nที่ลงทะเบียน',
                icon: Icons.search,
                color: Colors.blue,
                route: SearchShop(),
              ),
              MyMenu(
                title: 'แจ้งเตือน',
                icon: Icons.notifications,
                color: Colors.blue,
                route: ShowNotimanager(),
              ),
              MyMenu(
                title: 'อนุมัติโปรโมชั่น\nร้านค้า',
                icon: Icons.approval,
                color: Colors.blue,
                route: ApprovePromotion(),
              ),
            ],
          ),
        ));
  }

  Future<Null> confirmExit() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('คุณต้องการออกจากระบบ ?'),
        children: <Widget>[
          Row(
            children: <Widget>[
              TextButton.icon(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/", (Route<dynamic> route) => false);
                  _logOut();
                },
                icon: Icon(
                  Icons.check,
                  color: Colors.red,
                ),
                label: Text('ออกจากระบบ',
                    style: TextStyle(
                      color: Colors.red,
                    )),
              ),
              TextButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.clear,
                  color: Colors.blue,
                ),
                label: Text('ยกเลิก'),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<void> _logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('role');
    prefs.remove('email');
    prefs.remove('password');
  }
}
