import 'package:flutter/material.dart';

class ManageSeller extends StatefulWidget {
  @override
  _ManageSellerState createState() => _ManageSellerState();
}

class _ManageSellerState extends State<ManageSeller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('จัดการร้านค้า'),
      ),
    );
  }
}
