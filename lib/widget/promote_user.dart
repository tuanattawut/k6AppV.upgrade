import 'package:flutter/material.dart';
import 'package:k6_app/models/Debouncer.dart';
import 'package:k6_app/utility/my_style.dart';

class PromoteUser extends StatefulWidget {
  PromoteUser({Key key}) : super(key: key);

  @override
  _PromoteUserState createState() => _PromoteUserState();
}

class _PromoteUserState extends State<PromoteUser> {
  double screenWidth, screenHeight;
  final debouncer = Debouncer(miliseconds: 500);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('สินค้าแนะนำ')),
        ),
        body: Stack(children: [
          MyStyle().buildBackground(screenWidth, screenHeight),
          Column(
            children: <Widget>[
              searchText(),
              showListView(),
            ],
          )
        ]));
  }

  Widget searchText() {
    return TextField(
      decoration: InputDecoration(hintText: 'ค้นหา'),
      onChanged: (value) {
        debouncer.run(() {
          setState(() {});
        });
      },
    );
  }

  Widget showListView() {
    return Expanded(
        child: ListView.builder(
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return Text('ไก่ย่าง');
            }));
  }
}
