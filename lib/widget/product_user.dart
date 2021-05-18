import 'package:flutter/material.dart';
import 'package:k6_app/screens/show_detail.dart';
import 'package:k6_app/utility/my_style.dart';

class ProductListUser extends StatefulWidget {
  @override
  _ProductListUserState createState() => _ProductListUserState();
}

class _ProductListUserState extends State<ProductListUser> {
  @override
  void initState() {
    super.initState();
  }

  List<Widget> widgets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('หน้าหลัก')),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: 4,
          itemBuilder: (BuildContext buildContext, int index) {
            return showListView(index);
          },
        ),
      ),
    );
  }

  Widget showImage(int index) {
    return Container(
      padding: EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            image: DecorationImage(
              image: NetworkImage(
                  'https://www.taokaecafe.com/asp-bin/pic_taokae/sh2308.jpg'),
              fit: BoxFit.cover,
            )),
      ),
    );
  }

  Widget showName(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.5 - 35,
          child: Text(
            'หมูปิ้ง',
            style: MyStyle().mainTitle,
          ),
        ),
      ],
    );
  }

  Widget showDetail(int index) {
    String string =
        'หมูปิ้งจากอินเดีย แช่น้ำคลอง15วัน ก่อนนำมาหมัก และย่างด้วยถ่านที่ไม่ใช่สีม่วง แต่ก็ร่วงได้';
    if (string.length > 100) {
      string = string.substring(0, 99);
      string = '$string ...';
    }

    return Text(
      string,
      style: TextStyle(
        fontSize: 14.0,
        fontStyle: FontStyle.italic,
        color: Colors.grey.shade600,
      ),
    );
  }

  Widget showText(int index) {
    return Container(
      padding: EdgeInsets.only(right: 20.0),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          showName(index),
          showDetail(index),
          MyStyle().showTitleH2('ราคา 9000000 บาท'),
        ],
      ),
    );
  }

  Widget showListView(int index) {
    return GestureDetector(
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(
          builder: (value) => ShowDetail(),
        );
        Navigator.of(context).push(route);
      },
      child: Row(
        children: <Widget>[
          showImage(index),
          showText(index),
        ],
      ),
    );
  }
}
