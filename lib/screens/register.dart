import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';
import 'package:k6_app/utility/normal_dialog.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formstate = GlobalKey<FormState>();

  String name, password, email, phone, typeuser, imageavatar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("สมัครสมาชิก", style: TextStyle(color: Colors.white)),
        ),
        body: Form(
          key: _formstate,
          child: ListView(
            padding: EdgeInsets.all(20.0),
            children: <Widget>[
              buildNameField(),
              buildEmailField(),
              buildPasswordField(),
              buildPhoneField(),
              MyStyle().mySizebox(),
              MyStyle().showTitleH2('เลือกชนิดของสมาชิก: '),
              buildTyperUser(),
              buildTyperSeller(),
              MyStyle().mySizebox(),
              buildRegisterButton(),
            ],
          ),
        ));
  }

  RadioListTile<String> buildTyperSeller() {
    return RadioListTile(
      value: 'seller',
      groupValue: typeuser,
      onChanged: (value) {
        setState(() {
          typeuser = value;
        });
      },
      title: Text('ผู้ขาย'),
    );
  }

  RadioListTile<String> buildTyperUser() {
    return RadioListTile(
      value: 'user',
      groupValue: typeuser,
      onChanged: (value) {
        setState(() {
          typeuser = value;
        });
      },
      title: Text('สมาชิกทั่วไป'),
    );
  }

  ElevatedButton buildRegisterButton() {
    return ElevatedButton(
      child: Text('สมัครสมาชิก'),
      onPressed: () async {
        if (this._formstate.currentState.validate())
          print(
              'name = $name, email = $email, password = $password, typeuser = $typeuser');
        if (name == null ||
            name.isEmpty ||
            password == null ||
            password.isEmpty ||
            phone == null ||
            phone.isEmpty) {
          print('Have Space');
          normalDialog(context, 'มีช่องว่าง กรุณากรอกทุกช่อง ');
        } else if (typeuser == null) {
          normalDialog(context, 'โปรด เลือกชนิดของผู้สมัคร');
        } else if (email == null || email.isEmpty || !email.contains('@')) {
          normalDialog(context, 'กรอกอีเมลไม่ถูกต้อง');
        } else {
          checkUser();
        }
      },
    );
  }

  Future<Null> checkUser() async {
    String url =
        '${MyConstant().domain}/k6app/getUserWhereUser.php?isAdd=true&email=$email';
    try {
      Response response = await Dio().get(url);
      if (response.toString() == 'null') {
        registerThread();
      } else {
        normalDialog(
            context, 'อีเมลนี้ $email ได้ถูกใช้ไปแล้ว กรุณาเปลี่ยนใหม่');
      }
    } catch (e) {}
  }

  Future<Null> registerThread() async {
    String url =
        '${MyConstant().domain}/k6app/addUser.php?isAdd=true&name=$name&email=$email&password=$password&phone=$phone&typeuser=$typeuser&imageavatar=$imageavatar';

    try {
      Response response = await Dio().get(url);
      print('res = $response');

      if (response.toString() == 'true') {
        Navigator.pop(context);
      } else {
        normalDialog(context, 'ไม่สามารถ สมัครได้ กรุณาลองอีกครั้ง');
      }
    } catch (e) {}
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      onChanged: (value) => password = value.trim(),
      validator: (value) {
        if (value.length < 6)
          return 'โปรดกรอกพาสเวิร์ดมากกว่า 6 หลัก';
        else
          return null;
      },
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'พาสเวิร์ด',
        icon: Icon(Icons.lock),
      ),
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      onChanged: (value) => email = value.trim(),
      validator: (value) {
        if (!value.contains('@') || value.isEmpty)
          return 'โปรดกรอกอีเมลในช่อง ตัวอย่าง  xx@xx.com';
        else
          return null;
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'อีเมล',
        icon: Icon(Icons.email),
        hintText: 'xx@xx.com',
      ),
    );
  }

  TextFormField buildNameField() {
    return TextFormField(
      onChanged: (value) => name = value.trim(),
      validator: (value) {
        if (value.isEmpty)
          return 'โปรดกรอกชื่อในช่อง';
        else
          return null;
      },
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'ชื่อ',
        icon: Icon(Icons.person),
      ),
    );
  }

  TextFormField buildPhoneField() {
    return TextFormField(
      onChanged: (value) => phone = value.trim(),
      validator: (value) {
        if (value.length < 10)
          return 'โปรดกรอกเบอร์โทร 10 หลัก';
        else
          return null;
      },
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'เบอร์โทรศัพท์',
        icon: Icon(Icons.phone_android),
      ),
    );
  }
}
