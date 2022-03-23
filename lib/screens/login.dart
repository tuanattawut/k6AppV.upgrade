import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/manager_model.dart';
import 'package:k6_app/models/seller_model.dart';
import 'package:k6_app/models/user_models.dart';
import 'package:k6_app/screens/Manager/main_manager.dart';
import 'package:k6_app/screens/Seller/main_seller.dart';
import 'package:k6_app/screens/Seller/registerseller.dart';
import 'package:k6_app/screens/User/main_user.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_outlinebutton.dart';
import 'package:k6_app/utility/my_style.dart';
import 'package:k6_app/utility/normal_dialog.dart';
import 'package:k6_app/widget/User/loginfacebook.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formstate = GlobalKey<FormState>();
  bool statusRedEye = true;
  String? email, password, role;

  @override
  void initState() {
    super.initState();
    find();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                height: MediaQuery.of(context).size.height * 0.05,
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
              Row(
                children: [
                  Text('เข้าสู่ระบบโดย', style: TextStyle(fontSize: 16)),
                ],
              ),
              RadioListTile(
                value: 'user',
                groupValue: role,
                onChanged: (value) {
                  setState(() {
                    role = value.toString();
                  });
                },
                title: Text("สมาชิก"),
              ),
              RadioListTile(
                value: 'seller',
                groupValue: role,
                onChanged: (value) {
                  setState(() {
                    role = value.toString();
                  });
                },
                title: Text("ผู้ขาย"),
              ),
              RadioListTile(
                value: 'manager',
                groupValue: role,
                onChanged: (value) {
                  setState(() {
                    role = value.toString();
                  });
                },
                title: Text("ผู้จัดการ"),
              ),
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
              Row(children: const [
                Expanded(
                    child: Divider(
                  color: Colors.blue,
                )),
                Text(" หรือ ",
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
      ),
    );
  }

  Future<Null> find() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.getString('role') != null) {
        email = prefs.getString('email');
        password = prefs.getString('password');
        // print('Thisis > ${prefs.getString('email')}');
        if (prefs.getString('role') == 'user') {
          showLoade(context);
          checkAuthen();
        } else if (prefs.getString('role') == 'seller') {
          showLoade(context);
          checkSeller();
        } else if (prefs.getString('role') == 'manager') {
          showLoade(context);
          checkAuthenManager();
        } else {
          normalDialog(context, 'กรุณาเลือกสิทธิ์การเข้าใช้งาน');
        }
      }
    });
  }

  Future<Null> gogo() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('role', role.toString());
    prefs.setString('email', email.toString());
    prefs.setString('password', password.toString());
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
                  gogo();
                  if (role == 'user') {
                    showLoade(context);
                    checkAuthen();
                  } else if (role == 'seller') {
                    showLoade(context);
                    checkSeller();
                  } else if (role == 'manager') {
                    showLoade(context);
                    checkAuthenManager();
                  } else {
                    normalDialog(context, 'กรุณาเลือกสิทธิ์การเข้าใช้งาน');
                  }
                }
              }
            }));
  }

  Future<Null> addLoginManager() async {
    String url =
        '${MyConstant().domain}/api/loginmanager?email=$email&password=$password';
    try {
      Response response = await Dio().get(url);
      var result = json.decode(response.data);
      print(result);
      if (result == false) {
        normalDialog(context, 'รหัสผ่านผิด กรุณาลองอีกครั้ง ');
      } else {
        for (var map in result) {
          ManagerModel managerModel = ManagerModel.fromMap(map);
          Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (context) => Homemanager(
                    managerModel: managerModel,
                  )));
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Null> checkAuthenManager() async {
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
        addLoginManager();
      }
    } catch (e) {
      normalDialog(context, 'ผิดพลาด');
      //print('Have e Error ===>> ${e.toString()}');
    }
  }

  Future<Null> checkSeller() async {
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
        addLoginSeller();
      }
    } catch (e) {
      print('Have e Error ===>> ${e.toString()}');
    }
  }

  Future<Null> addLoginSeller() async {
    String url =
        '${MyConstant().domain}/api/loginseller?email=$email&password=$password';
    try {
      Response response = await Dio().get(url);
      var result = json.decode(response.data);
      //print(result);
      if (result == false) {
        normalDialog(context, 'รหัสผ่านผิด กรุณาลองอีกครั้ง ');
      } else {
        for (var map in result) {
          SellerModel sellerModel = SellerModel.fromMap(map);
          if (sellerModel.role == 'seller') {
            Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (context) => Homeseller(
                sellerModel: sellerModel,
              ),
            ));
            break;
          } else if (sellerModel.role == 'noseller') {
            normalDialog(
                context, 'บัญชีของคุณอยู่ระหว่างรอการอนุมัติจากผู้จัดการ');
          } else {
            normalDialog(
                context, 'บัญชีของคุณไม่ผ่านการตรวจสอบ\nโปรดติดต่อผู้จัดการ');
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
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
      print(e.toString());
    }
  }

  Future<Null> addLogin() async {
    String url =
        '${MyConstant().domain}/api/loginuser?email=$email&password=$password';

    try {
      Response response = await Dio().get(url);
      var result = json.decode(response.data);
      //print(result);
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
