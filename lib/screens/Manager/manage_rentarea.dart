import 'package:flutter/material.dart';
import 'package:k6_app/screens/Manager/add_area_manager.dart';
import 'package:k6_app/screens/Manager/all_area_manager.dart';
import 'package:k6_app/screens/Manager/approve_area.dart';
import 'package:k6_app/screens/Seller/main_seller.dart';

class ManageRentArea extends StatefulWidget {
  @override
  _ManageRentAreaState createState() => _ManageRentAreaState();
}

class _ManageRentAreaState extends State<ManageRentArea> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text("จัดการเช่าจองแผง", style: TextStyle(color: Colors.white)),
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: GridView.count(
            crossAxisCount: 2,
            children: <Widget>[
              MyMenu(
                title: 'เพิ่มแผงร้านค้า',
                icon: Icons.add,
                color: Colors.blue,
                route: Addarea(),
              ),
              MyMenu(
                title: 'แผงทั้งหมด',
                icon: Icons.store,
                color: Colors.blue,
                route: Allarea(),
              ),
              MyMenu(
                title: 'อนุมัติเช่าแผง',
                icon: Icons.approval,
                color: Colors.blue,
                route: ApproveArea(),
              ),
            ],
          ),
        ));
  }
}
