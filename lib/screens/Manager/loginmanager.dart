import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/manager_model.dart';
import 'package:k6_app/screens/Manager/main_manager.dart';
import 'package:k6_app/utility/enc-dec.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';
import 'package:k6_app/utility/normal_dialog.dart';

class LoginManager extends StatefulWidget {
  @override
  _LoginManagerState createState() => _LoginManagerState();
}

class _LoginManagerState extends State<LoginManager> {
  final _formstate = GlobalKey<FormState>();
  bool statusRedEye = true;
  String? email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formstate,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            behavior: HitTestBehavior.opaque,
            child: ListView(
              padding: EdgeInsets.all(20.0),
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'สำหรับผู้จัดการล็อกอิน',
                      style: MyStyle().mainTitle,
                    ),
                  ],
                ),
                MyStyle().mySizebox(),
                buildEmailField(),
                buildPasswordField(),
                MyStyle().mySizebox(),
                buildLoginButton(),
              ],
            ),
          ),
        ));
  }

  TextFormField buildEmailField() {
    return TextFormField(
      onChanged: (value) => email = value.trim(),
      validator: (value) {
        if (value!.isEmpty)
          return 'โปรดกรอกอีเมลให้ถูกต้อง';
        else
          return null;
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'อีเมล',
        icon: Icon(Icons.email),
        hintText: 'x@x.com',
      ),
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      onChanged: (value) => password = value.trim(),
      validator: (value) {
        if (value!.length < 6)
          return 'โปรดกรอกพาสเวิร์ด 6 ตัวขึ้นไป';
        else
          return null;
      },
      obscureText: statusRedEye,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              statusRedEye = !statusRedEye;
            });
          },
          icon: statusRedEye
              ? Icon(
                  Icons.remove_red_eye,
                )
              : Icon(
                  Icons.remove_red_eye_outlined,
                ),
        ),
        labelText: 'พาสเวิร์ด',
        icon: Icon(Icons.lock),
      ),
    );
  }

  ElevatedButton buildLoginButton() {
    return ElevatedButton(
        child: Text('ล็อกอิน'),
        onPressed: () async {
          if (this._formstate.currentState!.validate()) {
            //print('email =====> $email\npassword =====> $password');
            if (email == null ||
                email!.isEmpty ||
                password == null ||
                password!.isEmpty ||
                password!.length < 6) {
              normalDialog(context, 'กรุณากรอกข้อมูลให้ถูกต้อง');
            } else {
              showLoade(context);
              checkAuthen();
            }
          }
        });
  }

  Future<Null> checkAuthen() async {
    String url =
        '${MyConstant().domain}/api/getManagerEmail.php?isAdd=true&email=$email';
    // print('url ===>> $url');
    try {
      Response response = await Dio().get(url);
      //  print('res = $response');

      var result = json.decode(response.data);
      Navigator.pop(context);
      // print('result = $result');
      if (result == null) {
        normalDialog(context, 'ไม่พบอีเมลนี้ในระบบ กรุณาลองใหม่อีกครั้ง');
      } else {
        for (var map in result) {
          ManagerModel managerModel = ManagerModel.fromMap(map);
          if (generateMd5(password!) == managerModel.password) {
            Navigator.of(context).pushReplacement(new MaterialPageRoute(
                builder: (context) => Homemanager(
                      managerModel: managerModel,
                    )));

            break;
          } else {
            normalDialog(context, 'พาสเวิร์ดผิด กรุณา ลองอีกครั้ง ');
          }
        }
      }
    } catch (e) {
      normalDialog(context, 'ผิดพลาด');
      //print('Have e Error ===>> ${e.toString()}');
    }
  }
}
