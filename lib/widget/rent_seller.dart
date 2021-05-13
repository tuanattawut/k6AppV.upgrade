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
    return Scaffold(
      body: MyStyle().showProgress(),
    );
  }
}
