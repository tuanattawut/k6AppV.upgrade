import 'package:flutter/material.dart';

import 'package:k6_app/screens/User/show_detail.dart';
import 'package:k6_app/utility/my_style.dart';

class PromoteUser extends StatefulWidget {
  @override
  _PromoteUserState createState() => _PromoteUserState();
}

class _PromoteUserState extends State<PromoteUser> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('สินค้าแนะนำ')),
      ),
      body: Stack(
        children: [
          Container(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext buildContext, int index) {
                return showListView(index);
              },
            ),
          ),
        ],
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
            image: NetworkImage(''),
            fit: BoxFit.cover,
          ),
        ),
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
            '_model.name',
            style: MyStyle().mainTitle,
          ),
        ),
      ],
    );
  }

  Widget showDetail(int index) {
    String string = '_model.descriptions';
    if (string.length > 100) {
      string = string.substring(0, 99);
      string = '$string ...';
    }
    return Text(
      string,
      style: TextStyle(
        fontSize: 16,
        fontStyle: FontStyle.italic,
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
          Text(
            '{_model.price} ฿',
            style: TextStyle(fontSize: 18, color: Colors.red),
          )
        ],
      ),
    );
  }

  Widget showListView(int index) {
    return GestureDetector(
      onTap: () {
        // MaterialPageRoute route = MaterialPageRoute(
        //   builder: (value) => ShowDetail(productModel: ,),
        // );
        // Navigator.of(context).push(route);
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
