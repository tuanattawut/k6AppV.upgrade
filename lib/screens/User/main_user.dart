import 'package:flutter/material.dart';
import 'package:k6_app/models/user_models.dart';
import 'package:k6_app/screens/User/info_user.dart';
import 'package:k6_app/screens/User/noti_user.dart';
import 'package:k6_app/screens/User/product_user.dart';
import 'package:k6_app/widget/User/promote_user.dart';

class Homepage extends StatefulWidget {
  Homepage({required this.usermodel});
  final UserModel usermodel;
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  UserModel? userModel;
  List<Widget>? _widgetOptions;
  @override
  void initState() {
    super.initState();
    userModel = widget.usermodel;
    _widgetOptions = <Widget>[
      ProductListUser(usermodel: userModel!),
      PromoteUser(),
      NotiUser(),
      InformationUser(usermodel: userModel!),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions!.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'หน้าหลัก',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.thumb_up_alt_outlined),
            activeIcon: Icon(Icons.thumb_up),
            label: 'สินค้าแนะนำ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            activeIcon: Icon(Icons.notifications),
            label: 'แจ้งเตือน',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'ฉัน',
          ),
        ],
        backgroundColor: Colors.white70,
        unselectedItemColor: Colors.grey[600],
        selectedItemColor: Colors.blue,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
