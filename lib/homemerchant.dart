import 'package:flutter/material.dart';

class Homemerchant extends StatefulWidget {
  @override
  _HomemerchantState createState() => _HomemerchantState();
}

class _HomemerchantState extends State<Homemerchant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("สำหรับผู้ขาย", style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
        body: (Text('สวัสดีครับ')));
  }
}
