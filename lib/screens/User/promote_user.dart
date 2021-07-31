import 'package:flutter/material.dart';
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
            image: NetworkImage(
                'https://img.wongnai.com/p/1920x0/2019/09/20/ea870d3e5599444ba5c5fce3f1e09607.jpg'),
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
            'เส้นเล็กแห้ง',
            style: MyStyle().mainTitle,
          ),
        ),
      ],
    );
  }

  // Widget showDetail(int index) {
  //   String string = '_model.descriptions';
  //   if (string.length > 100) {
  //     string = string.substring(0, 99);
  //     string = '$string ...';
  //   }
  //   return Text(
  //     string,
  //     style: TextStyle(
  //       fontSize: 16,
  //       fontStyle: FontStyle.italic,
  //     ),
  //   );
  // }

  Widget showText(int index) {
    return Container(
      padding: EdgeInsets.only(right: 20.0),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          showName(index),
          Text(
            '฿300',
            style: TextStyle(fontSize: 25, color: Colors.red),
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
      child: Container(
        margin: EdgeInsets.only(
          top: 5,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 50,
              color: Colors.grey.withOpacity(0.23),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            showText(index),
            showImage(index),
          ],
        ),
      ),
    );
  }
}
