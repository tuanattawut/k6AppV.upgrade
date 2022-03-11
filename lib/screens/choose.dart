import 'package:flutter/material.dart';
import 'package:k6_app/screens/Manager/loginmanager.dart';
import 'package:k6_app/screens/Seller/loginseller.dart';
import 'package:k6_app/screens/login.dart';
import 'package:k6_app/utility/my_outlinebutton.dart';

class ChooseType extends StatefulWidget {
  const ChooseType({Key? key}) : super(key: key);

  @override
  State<ChooseType> createState() => _ChooseTypeState();
}

class _ChooseTypeState extends State<ChooseType> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      behavior: HitTestBehavior.opaque,
      child: ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          SizedBox(
            height: 150,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('ระบบแนะนำสินค้าและร้านค้า ',
                  style: TextStyle(fontSize: 20, color: Colors.blue)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('ตลาดเคหะคลองหก ',
                  style: TextStyle(fontSize: 20, color: Colors.blue)),
            ],
          ),
          SizedBox(
            height: 100,
          ),
          builduserButton(),
          SizedBox(
            height: 30,
          ),
          buildsellerButton(),
          SizedBox(
            height: 30,
          ),
          managerButton()
        ],
      ),
    ));
  }

  MyOutlinedButton builduserButton() {
    return MyOutlinedButton(
      onPressed: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => LoginPage());
        Navigator.of(context).push(route);
      },
      gradient: const LinearGradient(
          colors: [Colors.blue, Color.fromARGB(255, 81, 247, 164)]),
      child: const Text('ซื้อสินค้า', style: TextStyle(fontSize: 18)),
    );
  }

  MyOutlinedButton buildsellerButton() {
    return MyOutlinedButton(
      onPressed: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => LoginSeller());
        Navigator.of(context).push(route);
      },
      gradient: const LinearGradient(
          colors: [Colors.blue, Color.fromARGB(255, 81, 247, 164)]),
      child: const Text('ขายสินค้า', style: TextStyle(fontSize: 18)),
    );
  }

  MyOutlinedButton managerButton() {
    return MyOutlinedButton(
      onPressed: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => LoginManager());
        Navigator.of(context).push(route);
      },
      gradient: const LinearGradient(
          colors: [Colors.blue, Color.fromARGB(255, 81, 247, 164)]),
      child: const Text('ผู้จัดการตลาด', style: TextStyle(fontSize: 18)),
    );
  }
}
