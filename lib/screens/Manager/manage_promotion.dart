import 'package:flutter/material.dart';

class ManagePromotion extends StatefulWidget {
  @override
  _ManagePromotionState createState() => _ManagePromotionState();
}

class _ManagePromotionState extends State<ManagePromotion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('จัดการโปรโมชั่น'),
      ),
    );
  }
}
