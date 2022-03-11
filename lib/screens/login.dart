import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/user_models.dart';
import 'package:k6_app/screens/Manager/loginmanager.dart';
import 'package:k6_app/screens/Seller/loginseller.dart';
import 'package:k6_app/screens/User/main_user.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_outlinebutton.dart';
import 'package:k6_app/utility/my_style.dart';
import 'package:k6_app/utility/normal_dialog.dart';
import 'package:k6_app/widget/User/loginfacebook.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formstate = GlobalKey<FormState>();
  bool statusRedEye = true;
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formstate,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: ListView(
            padding: EdgeInsets.all(20.0),
            children: <Widget>[
              MyStyle().mySizebox(),
              SizedBox(
                height: 50,
              ),
              //MyStyle().showLogo(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ระบบแนะนำสินค้าและร้านค้า ',
                      style: TextStyle(fontSize: 20, color: Colors.blue)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ตลาดเคหะคลองหก ',
                      style: TextStyle(fontSize: 20, color: Colors.blue)),
                ],
              ),
              MyStyle().mySizebox(),
              buildEmailField(),
              buildPasswordField(),
              MyStyle().mySizebox(),
              buildLoginButton(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('ยังไม่ได้เป็นสมาชิก?'),
                  buildRegisterButton(context),
                ],
              ),
              LoginFacebook(),
              // Row(children: const [
              //   Expanded(
              //       child: Divider(
              //     color: Colors.blue,
              //   )),
              //   Text(" OR ",
              //       style: TextStyle(fontSize: 14, color: Colors.black)),
              //   Expanded(
              //       child: Divider(
              //     color: Colors.blue,
              //   )),
              // ]),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     buildsellerButton(),
              //     MyStyle().mySizebox(),
              //     MyStyle().mySizebox(),
              //     managerButton(),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded managerButton() {
    return Expanded(
      flex: 1,
      child: MyOutlinedButton(
        onPressed: () {
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => LoginManager());
          Navigator.of(context).push(route);
        },
        gradient: const LinearGradient(
            colors: [Colors.blue, Color.fromARGB(255, 81, 247, 164)]),
        child: const Text('สำหรับผู้จัดการ'),
      ),
    );
  }

  Expanded buildsellerButton() {
    return Expanded(
      flex: 1,
      child: MyOutlinedButton(
        onPressed: () {
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => LoginSeller());
          Navigator.of(context).push(route);
        },
        gradient: const LinearGradient(
            colors: [Colors.blue, Color.fromARGB(255, 81, 247, 164)]),
        child: const Text('สำหรับผู้ขาย'),
      ),
    );
  }

  TextButton buildRegisterButton(BuildContext context) {
    return TextButton(
      child: Text(
        'สมัครสมาชิก',
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/register');
      },
    );
  }

  Container buildLoginButton() {
    return Container(
        height: 40,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Color.fromARGB(255, 81, 247, 164)],
            begin: FractionalOffset.centerLeft,
            end: FractionalOffset.centerRight,
          ),
        ),
        child: TextButton(
            child: const Text(
              'เข้าสู่ระบบ',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onPressed: () async {
              if (this._formstate.currentState!.validate()) {
                // print('email ======>  $email');
                if (email == null ||
                    email!.isEmpty ||
                    !email!.contains('@') ||
                    password == null ||
                    password!.isEmpty ||
                    password!.length < 8) {
                  normalDialog(context, 'กรุณากรอกข้อมูลให้ถูกต้อง');
                } else {
                  showLoade(context);
                  checkAuthen();
                }
              }
            }));
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      onChanged: (value) => password = value.trim(),
      validator: (value) {
        if (value!.length < 8)
          return 'โปรดกรอกรหัสผ่าน 8 ตัวขึ้นไป';
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
        labelText: 'รหัสผ่าน',
        icon: Icon(
          Icons.lock,
          color: Colors.blue,
        ),
        hintText: 'ระบุรหัสผ่าน 8 ตัวขึ้นไป',
      ),
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      onChanged: (value) => email = value.trim(),
      validator: (value) {
        if (value!.isEmpty || !value.contains('@'))
          return 'โปรดกรอกอีเมลให้ถูกต้อง';
        else
          return null;
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'อีเมล',
        icon: Icon(
          Icons.email,
          color: Colors.blue,
        ),
        hintText: 'ระบุอีเมลของท่าน',
      ),
    );
  }

  Future<Null> checkAuthen() async {
    String url =
        '${MyConstant().domain}/api/getUserEmail.php?isAdd=true&email=$email';
    //  print('url ===>> $url');
    try {
      Response response = await Dio().get(url);
      //print('res = $response');

      var result = json.decode(response.data);
      //  print('result = $result');
      Navigator.pop(context);
      if (result == null) {
        normalDialog(context, 'ไม่พบอีเมลนี้ในระบบ กรุณาลองใหม่อีกครั้ง');
      } else {
        addLogin();
      }
    } catch (e) {
      normalDialog(context, 'ผิดพลาด ${e.toString()}');
    }
  }

  Future<Null> addLogin() async {
    String url =
        '${MyConstant().domain}/api/loginuser?email=$email&password=$password';

    try {
      Response response = await Dio().get(url);
      var result = json.decode(response.data);
      print(result);
      if (result == false) {
        normalDialog(context, 'รหัสผ่านผิด กรุณาลองอีกครั้ง ');
      } else {
        for (var map in result) {
          UserModel userModel = UserModel.fromMap(map);
          print(userModel.firstname);
          Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (context) => Homepage(
                    usermodel: userModel,
                  )));
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
