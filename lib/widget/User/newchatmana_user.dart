import 'package:flutter/material.dart';
import 'package:k6_app/utility/my_style.dart';
import 'package:k6_app/utility/normal_dialog.dart';

class NewChatMana extends StatefulWidget {
  @override
  _NewChatManaState createState() => _NewChatManaState();
}

class _NewChatManaState extends State<NewChatMana> {
  String? toppicchat, detailchat;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              MyStyle().showTitleH2('หัวข้อ'),
              Text(
                ' *',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              )
            ],
          ),
          MyStyle().mySizebox(),
          topic(),
          MyStyle().mySizebox(),
          Row(
            children: [
              MyStyle().showTitleH2('รายละเอียด'),
              Text(
                ' *',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              )
            ],
          ),
          MyStyle().mySizebox(),
          detail(),
          MyStyle().mySizebox(),
          saveButton()
        ],
      ),
    );
  }

  TextFormField topic() {
    return TextFormField(
      onChanged: (value) => toppicchat = value.trim(),
      decoration: InputDecoration(
        hintText: ' พิมพ์หัวข้อของคุณ',
      ),
    );
  }

  TextFormField detail() {
    return TextFormField(
      onChanged: (value) => detailchat = value.trim(),
      keyboardType: TextInputType.multiline,
      maxLines: 6,
      decoration: InputDecoration(
        hintText: 'พิมพ์รายละเอียดของคุณ',
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple),
        ),
      ),
    );
  }

  ElevatedButton saveButton() {
    return ElevatedButton(
      child: Text('สร้างข้อความ'),
      onPressed: () {
        if (toppicchat == null ||
            toppicchat!.isEmpty ||
            detailchat == null ||
            detailchat!.isEmpty) {
          normalDialog(context, 'กรุณากรอกข้อมูลให้ครบถ้วน');
        } else {
          print('Title : $toppicchat, Text : $detailchat');
        }
      },
    );
  }
}
