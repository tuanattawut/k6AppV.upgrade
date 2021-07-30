import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/seller_model.dart';
import 'package:k6_app/screens/Seller/main_seller.dart';
import 'package:k6_app/screens/Seller/registerseller.dart';
import 'package:k6_app/utility/my_constant.dart';
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
                    Text(
                      'สำหรับผู้ขายล็อกอิน',
                      style: MyStyle().mainTitle,
                    ),
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
                    buildRegisterButton(context),
                  ],
                ),
                LoginFacebookSeller(),
              ],
            ),
          ),
        ));
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

  ElevatedButton buildLoginButton() {
    return ElevatedButton(
        child: Text('ล็อกอิน'),
        onPressed: () async {
          if (this._formstate.currentState!.validate()) {
            print('email =====> $email\npassword =====> $password');

            if (email == null ||
                email!.isEmpty ||
                !email!.contains('@') ||
                password == null ||
                password!.isEmpty ||
                password!.length < 6) {
              normalDialog(context, 'กรุณากรอกข้อมูลให้ถูกต้อง');
            } else {
              checkAuthen();
            }
          }
        });
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
        icon: Icon(Icons.email),
        hintText: 'x@x.com',
      ),
    );
  }

  Future<Null> checkAuthen() async {
    String url =
        '${MyConstant().domain}/projectk6/getSellerWhereSeller.php?isAdd=true&email=$email';
    // print('url ===>> $url');
    await Dio().get(url).then((value) async {
      if (value.toString() == 'null') {
        normalDialog(context, 'ไม่พบอีเมลนี้ในระบบ กรุณาลองใหม่อีกครั้ง');
      } else {
        for (var item in json.decode(value.data)) {
          SellerModel sellerModel = SellerModel.fromMap(item);
          if (password == sellerModel.password) {
            if (sellerModel.status == 'yes') {
              MaterialPageRoute route = MaterialPageRoute(
                builder: (value) => Homeseller(
                  sellerModel: sellerModel,
                ),
              );
              Navigator.of(context).push(route);
              break;
            } else if (sellerModel.status == 'no') {
              normalDialog(
                  context, 'บัญชีของคุณไม่ผ่านการตรวจสอบ\nโปรดติดต่อผู้จัดการ');
            } else {
              normalDialog(
                  context, 'บัญชีของคุณอยู่ระหว่างรอการยืนยันจากผู้จัดการ');
            }
          } else {
            normalDialog(context, 'พาสเวิร์ดผิด กรุณา ลองอีกครั้ง ');
          }
        }
      }
    });
  }
}
