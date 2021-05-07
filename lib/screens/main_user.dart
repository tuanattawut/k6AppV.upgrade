import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:k6_app/utility/my_style.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final auth = FirebaseAuth.instance;
  final user = FirebaseFirestore.instance;
  final fblogout = FacebookLogin();
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text('K6 E-App');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: cusSearchBar,
      //   actions: <Widget>[
      //     IconButton(
      //       icon: cusIcon,
      //       onPressed: () {
      //         setState(() {
      //           if (this.cusIcon.icon == Icons.search) {
      //             this.cusIcon = Icon(Icons.cancel);
      //             this.cusSearchBar = TextField(
      //               textInputAction: TextInputAction.go,
      //               style: TextStyle(
      //                 color: Colors.white,
      //                 fontSize: 18,
      //               ),
      //             );
      //           } else {
      //             this.cusIcon = Icon(Icons.search);
      //             this.cusSearchBar = Text('K6 E-App');
      //           }
      //         });
      //       },
      //     ),
      //     IconButton(
      //         icon: Icon(Icons.exit_to_app),
      //         onPressed: () {
      //           auth.signOut();
      //           fblogout.logOut();
      //           Navigator.pop(context);
      //         })
      //   ],
      // ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.announcement),
            label: 'โปรโมชั่น',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'หน้าหลัก',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'ฉัน',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        onTap: _onItemTapped,
      ),
    );
  }

  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    Scaffold(
        appBar: AppBar(
          title: Center(child: Text('โปรโมชั่น')),
        ),
        body: Container(
          child: ListView(
            padding: EdgeInsets.all(20),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyStyle().showTitle('หน้าแสดงประกาศโปรโมชั่น'),
                ],
              ),
            ],
          ),
        )),
    Scaffold(
        appBar: AppBar(
          title: Center(child: Text('หน้าหลัก')),
        ),
        body: Container(
          child: ListView(
            padding: EdgeInsets.all(20),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyStyle().showTitle('หน้าหลัก'),
                ],
              ),
            ],
          ),
        )),
    Scaffold(
        appBar: AppBar(
          title: Center(child: Text('ข้อมูล')),
        ),
        body: Container(
          child: ListView(
            padding: EdgeInsets.all(20),
            children: <Widget>[
              MyStyle().showTitle('ชื่อผู้ใช้'),
              MyStyle().mySizebox(),
              ElevatedButton(onPressed: () {}, child: Text('แชทกับผู้จัดการ')),
              MyStyle().mySizebox(),
              ElevatedButton(onPressed: () {}, child: Text('ออกจากระบบ'))
            ],
          ),
        )),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
