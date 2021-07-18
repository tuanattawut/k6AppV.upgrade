import 'package:flutter/material.dart';
import 'package:k6_app/utility/my_style.dart';
import 'package:k6_app/utility/normal_dialog.dart';

class AddPromotion extends StatefulWidget {
  @override
  _AddPromotionState createState() => _AddPromotionState();
}

class _AddPromotionState extends State<AddPromotion> {
  String? titletext, text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มการแจ้งเตือน'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            titleText(),
            MyStyle().mySizebox(),
            fromText(),
            MyStyle().mySizebox(),
            saveButton()
          ],
        ),
      ),
    );
  }

  TextFormField titleText() {
    return TextFormField(
      onChanged: (value) => titletext = value.trim(),
      decoration: InputDecoration(
          icon: Text(
            'หัวข้อ:',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 3,
            ),
          )),
    );
  }

  TextFormField fromText() {
    return TextFormField(
      onChanged: (value) => text = value.trim(),
      keyboardType: TextInputType.multiline,
      maxLines: 6,
      decoration: InputDecoration(
        icon: Text(
          'เนื้อหา:',
          style: TextStyle(fontSize: 20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 3,
          ),
        ),
      ),
    );
  }

  ElevatedButton saveButton() {
    return ElevatedButton(
      child: Text('บันทึกข้อมูล'),
      onPressed: () {
        if (titletext == null ||
            titletext!.isEmpty ||
            text == null ||
            text!.isEmpty) {
          normalDialog(context, 'กรุณากรอกให้ครบทุกช่อง');
        } else {
          print('Title : $titletext, Text : $text');
        }
      },
    );
  }
}
