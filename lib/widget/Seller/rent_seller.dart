import 'package:flutter/material.dart';
import 'package:k6_app/utility/my_style.dart';

class RentSeller extends StatefulWidget {
  @override
  _RentSellerState createState() => _RentSellerState();
}

class _RentSellerState extends State<RentSeller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เช่าจองแผงขายสินค้า'),
      ),
      body: Column(
        children: <Widget>[
          Center(child: showInfoRent()),
        ],
      ),
    );
  }

  Widget showInfoRent() => Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text('เช่าจองแผงขายสินค้า\n Coming SOON',
                style: TextStyle(fontSize: 40)),
          ],
        ),
      );
  Container showImage() {
    return Container(
      width: 500.0,
      height: 300.0,
      child: Image.network(''),
    );
  }
}
