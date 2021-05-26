import 'package:flutter/material.dart';

class ManageRentArea extends StatefulWidget {
  @override
  _ManageRentAreaState createState() => _ManageRentAreaState();
}

class _ManageRentAreaState extends State<ManageRentArea> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('จัดการเช่าจองพื้นที่'),
      ),
    );
  }
}
