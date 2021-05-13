import 'package:flutter/material.dart';
import 'package:k6_app/utility/my_style.dart';

class RentSeller extends StatefulWidget {
  RentSeller({Key key}) : super(key: key);

  @override
  _RentSellerState createState() => _RentSellerState();
}

class _RentSellerState extends State<RentSeller> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        showInfoRent(),
      ],
    );
  }

  Widget showInfoRent() => Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            MyStyle().showTitleH2('เช่าจองแผงขายสินค้า'),
            showImage(),
            MyStyle().showTitleH2('ติดด่อเบอร์โทร'),
            Column(
              children: <Widget>[
                Text('0123456789'),
              ],
            ),
            MyStyle().mySizebox(),
          ],
        ),
      );
  Container showImage() {
    return Container(
      width: 500.0,
      height: 300.0,
      child: Image.network(
          'https://www.img.in.th/images/fbb204c0efd9c36f6030f875d0f0ea40.png'),
    );
  }
}
