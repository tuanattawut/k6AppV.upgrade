import 'package:flutter/material.dart';
import 'package:k6_app/utility/my_style.dart';

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
        drawer: showDrawer(),
        body: (Text('สวัสดีครับ')));
  }

  Drawer showDrawer() => Drawer(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                showHead(),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                signOutMenu(),
              ],
            ),
          ],
        ),
      );

  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
      arrowColor: Colors.amber,
      currentAccountPicture: MyStyle().showLogo(),
      accountName: Text('คุณผู้จัดการ'),
      accountEmail: Text('เข้าสู่ระบบ'),
    );
  }

  ListTile signOutMenu() => ListTile(
        leading: Icon(
          Icons.exit_to_app_outlined,
        ),
        title: Text('ออกจากระบบ'),
        subtitle: Text('ออกจากระบบ และ กลับไป หน้าแรก'),
        onTap: () {
          Navigator.pop(context);
        },
      );
}
