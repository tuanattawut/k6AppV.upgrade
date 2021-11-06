import 'package:flutter/material.dart';
import 'package:k6_app/models/user_models.dart';
import 'package:k6_app/utility/my_style.dart';
import 'package:k6_app/utility/normal_dialog.dart';

class NewChatMana extends StatefulWidget {
  NewChatMana({required this.usermodel});
  final UserModel usermodel;
  @override
  _NewChatManaState createState() => _NewChatManaState();
}

class _NewChatManaState extends State<NewChatMana> {
  String? email, name, message;
  UserModel? userModel;

  @override
  void initState() {
    super.initState();
    userModel = widget.usermodel;
    email = userModel!.email;
    name = userModel!.firstname + ' ' + userModel!.lastname;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              MyStyle().showTitleH2('ชื่อ'),
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
          Text(
            name!,
            style: TextStyle(fontSize: 16),
          ),
          MyStyle().mySizebox(),
          Row(
            children: [
              MyStyle().showTitleH2('อีเมล'),
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
          Text(
            email!,
            style: TextStyle(fontSize: 16),
          ),
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

  TextFormField detail() {
    return TextFormField(
      onChanged: (value) => message = value.trim(),
      keyboardType: TextInputType.multiline,
      maxLines: 6,
      decoration: InputDecoration(
        hintText: 'พิมพ์ข้อความของคุณ',
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
        if (message == null || message!.isEmpty) {
          normalDialog(context, 'กรุณากรอกข้อมูลให้ครบถ้วน');
        } else {
          print('Title : $name, Text : $message');
        }
      },
    );
  }
}
