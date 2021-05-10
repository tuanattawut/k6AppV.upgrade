import 'package:flutter/material.dart';
import 'package:k6_app/utility/my_style.dart';
import 'package:k6_app/widget/infomation_seller.dart';
import 'package:k6_app/widget/product_list_seller.dart';
import 'package:k6_app/widget/rent_seller.dart';

class Homeseller extends StatefulWidget {
  @override
  _HomesellerState createState() => _HomesellerState();
}

class _HomesellerState extends State<Homeseller> {
  Widget currentWidget = ProductListSeller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("สำหรับผู้ขาย", style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
      drawer: showDrawer(),
      body: currentWidget,
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(children: <Widget>[
          showHead(),
          foodMenu(),
          infomationMenu(),
          rentMenu(),
          signOutMenu(),
        ]),
      );

  ListTile foodMenu() => ListTile(
        leading: Icon(Icons.shop),
        title: Text('รายการสินค้า'),
        subtitle: Text('รายการสินค้าของร้าน'),
        onTap: () {
          setState(() {
            currentWidget = ProductListSeller();
          });
          Navigator.pop(context);
        },
      );

  ListTile infomationMenu() => ListTile(
        leading: Icon(Icons.info),
        title: Text('รายละเอียด ของผู้ขาย'),
        subtitle: Text('รายละเอียด ของผู้ขาย พร้อม แก้ไข'),
        onTap: () {
          setState(() {
            currentWidget = InformationSeller();
          });
          Navigator.pop(context);
        },
      );

  ListTile rentMenu() => ListTile(
        leading: Icon(Icons.food_bank),
        title: Text('เช่า/จองพื้นที่'),
        subtitle: Text('เช่าหรือจองพื้นที่สำหรับขายสินค้า'),
        onTap: () {
          setState(() {
            currentWidget = RentSeller();
          });
          Navigator.pop(context);
        },
      );

  ListTile signOutMenu() => ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text('ออกจากระบบ'),
        subtitle: Text('ออกจากระบบ และ กลับไป หน้าแรก'),
        onTap: () {
          Navigator.pop(context);
        },
      );

  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
      arrowColor: Colors.amber,
      currentAccountPicture: MyStyle().showLogo(),
      accountName: Text('Name Seller'),
      accountEmail: Text('Login'),
    );
  }
}
