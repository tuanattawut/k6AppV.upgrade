import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/seller_model.dart';
import 'package:k6_app/screens/Seller/main_seller.dart';
import 'package:k6_app/screens/Seller/registerseller.dart';
import 'package:k6_app/utility/enc-dec.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_outlinebutton.dart';
import 'package:k6_app/utility/my_style.dart';
import 'package:k6_app/utility/normal_dialog.dart';
import 'package:k6_app/widget/Seller/loginfacebook_seller.dart';

class LoginSeller extends StatefulWidget {
  @override
  _LoginSellerState createState() => _LoginSellerState();
}

class _LoginSellerState extends State<LoginSeller> {
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
                MyStyle().mySizebox(),
                SizedBox(
                  height: 50,
                ),
                // MyStyle().showLogo(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('สำหรับผู้ขายล็อกอิน',
                        style: TextStyle(fontSize: 20, color: Colors.blue)),
                  ],
                ),
                MyStyle().mySizebox(),
                buildEmailField(),
                buildPasswordField(),
                MyStyle().mySizebox(),
                buildLoginButton(),
                MyStyle().mySizebox(),
                LoginFacebookSeller(),

                Row(children: const [
                  Expanded(
                      child: Divider(
                    color: Colors.blue,
                  )),
                  Text(" OR ",
                      style: TextStyle(fontSize: 14, color: Colors.black)),
                  Expanded(
                      child: Divider(
                    color: Colors.blue,
                  )),
                ]),

                buildRegisterSeller(context),
              ],
            ),
          ),
        ));
  }

  MyOutlinedButton buildRegisterSeller(BuildContext context) {
    return MyOutlinedButton(
      onPressed: () async {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => RegisterSeller());
        Navigator.of(context).push(route);
      },
      gradient: const LinearGradient(
          colors: [Colors.blue, Color.fromARGB(255, 81, 247, 164)]),
      child: const Text('สมัครขายสินค้า'),
    );
  }

  TextButton buildRegisterButton(BuildContext context) {
    return TextButton(
      child: Text('สมัครขายสินค้า'),
      onPressed: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => RegisterSeller());
        Navigator.of(context).push(route);
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
              //print('email =====> $email\npassword =====> $password');

              if (email == null ||
                  email!.isEmpty ||
                  !email!.contains('@') ||
                  password == null ||
                  password!.isEmpty ||
                  password!.length < 6) {
                normalDialog(context, 'กรุณากรอกข้อมูลให้ถูกต้อง');
              } else {
                showLoade(context);
                checkAuthen();
              }
            }
          }),
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
        icon: Icon(
          Icons.lock,
          color: Colors.blue,
        ),
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
        hintText: 'x@x.com',
      ),
    );
  }

  Future<Null> checkAuthen() async {
    String url =
        '${MyConstant().domain}/api/getSellerEmail.php?isAdd=true&email=$email';
    //print('url ===>> $url');
    try {
      Response response = await Dio().get(url);
      var result = json.decode(response.data);
      Navigator.pop(context);
      if (result == null) {
        normalDialog(context, 'ไม่พบอีเมลนี้ในระบบ กรุณาลองใหม่อีกครั้ง');
      } else {
        for (var map in result) {
          SellerModel sellerModel = SellerModel.fromMap(map);
          if (generateMd5(password!) == sellerModel.password) {
            if (sellerModel.role == 'seller') {
              Navigator.of(context).pushReplacement(new MaterialPageRoute(
                builder: (context) => Homeseller(
                  sellerModel: sellerModel,
                ),
              ));
              addLogin();
              break;
            } else if (sellerModel.role == 'noseller') {
              normalDialog(
                  context, 'บัญชีของคุณอยู่ระหว่างรอการอนุมัติจากผู้จัดการ');
            } else {
              normalDialog(
                  context, 'บัญชีของคุณไม่ผ่านการตรวจสอบ\nโปรดติดต่อผู้จัดการ');
            }
          } else {
            normalDialog(context, 'พาสเวิร์ดผิด กรุณา ลองอีกครั้ง ');
          }
        }
      }
    } catch (e) {
      normalDialog(context, 'ผิดพลาด ${e.toString()}');
      print('Have e Error ===>> ${e.toString()}');
    }
  }

  Future<Null> addLogin() async {
    String typeuser = 'seller';
    String url =
        '${MyConstant().domain}/api/addLogin.php?isAdd=true&typeuser=$typeuser';

    try {
      Response response = await Dio().get(url);
      //print('res = $response');

      if (response.toString() == 'true') {
      } else {}
    } catch (e) {}
  }
}
