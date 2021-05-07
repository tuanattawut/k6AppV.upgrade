import 'package:flutter/material.dart';
import 'package:k6_app/utility/my_style.dart';

class Homeshop extends StatefulWidget {
  @override
  _HomeshopState createState() => _HomeshopState();
}

class _HomeshopState extends State<Homeshop> {
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
        body: (Text('สวัสดีครับ')));
  }

  Drawer showDrawer() => Drawer(
        child: ListView(children: <Widget>[
          showHead(),
          foodMenu(),
          infomationMenu(),
          signOutMenu(),
        ]),
      );

  ListTile foodMenu() => ListTile(
        leading: Icon(Icons.shop),
        title: Text('รายการสินค้า'),
        subtitle: Text('รายการสินค้าของร้าน'),
        onTap: () => Navigator.pop(context),
      );

  ListTile infomationMenu() => ListTile(
        leading: Icon(Icons.info),
        title: Text('รายละเอียด ของร้าน'),
        subtitle: Text('รายละเอียด ของร้าน พร้อม แก้ไข'),
        onTap: () {},
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
      accountName: Text('Name Shop'),
      accountEmail: Text('Login'),
    );
  }
}
