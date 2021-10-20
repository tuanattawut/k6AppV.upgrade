import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:http/http.dart' as http;
import 'package:k6_app/models/seller_model.dart';
import 'package:k6_app/screens/Seller/main_seller.dart';
import 'package:k6_app/utility/enc-dec.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';
import 'package:k6_app/utility/normal_dialog.dart';

class LoginFacebookSeller extends StatefulWidget {
  @override
  _LoginFacebookSellerState createState() => _LoginFacebookSellerState();
}

class _LoginFacebookSellerState extends State<LoginFacebookSeller> {
  String? name, lastname, password, idcard, email, phone, gender, image, idfb;
  DateTime birthday = DateTime.now();

  bool isLoggedIn = false;

  var profileData;

  var facebookLogin = FacebookLogin();

  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
      this.profileData = profileData;

      name = profileData['first_name'];
      lastname = profileData['last_name'];
      email = profileData['email'];

      image = 'profile.jpg';
      checkUser();
    });
  }

  Future<Null> registerThread() async {
    String passwordMd5 = generateMd5(password!);
    String url =
        '${MyConstant().domain}/api/addSeller.php?isAdd=true&firstname=$name&lastname=$lastname&idcard=$idcard&email=$email&password=$passwordMd5&gender=$gender&phone=$phone&birthday=$birthday&image=$image';

    try {
      Response response = await Dio().get(url);
      // print('res = $response');

      if (response.toString() == 'true') {
        normalDialog(context, 'สมัครสำเร็จ');

        Navigator.pushNamed(context, '/');
      } else {
        normalDialog(context, 'ไม่สามารถ สมัครได้ กรุณาลองอีกครั้ง');
      }
    } catch (e) {}
  }

  Future<Null> checkUser() async {
    String url =
        '${MyConstant().domain}/api/getSellerEmail.php?isAdd=true&email=$email';
    try {
      Response response = await Dio().get(url);
      var result = json.decode(response.data);
     // print(result);
      if (result == null) {
        showAddFBDialog();
      } else {
        for (var map in result) {
          SellerModel sellerModel = SellerModel.fromMap(map);
          if (sellerModel.role == 'seller') {
            MaterialPageRoute route = MaterialPageRoute(
              builder: (value) => Homeseller(
                sellerModel: sellerModel,
              ),
            );
            Navigator.of(context).push(route);
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
      normalDialog(context, 'ผิดพลาด');
      // print('Have e Error ===>> ${e.toString()}');
    }
  }

  Future<Null> showAddFBDialog() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              behavior: HitTestBehavior.opaque,
              child: StatefulBuilder(
                builder: (context, setState) => SimpleDialog(
                  title: ListTile(
                    title: Text('ลงชื่อเข้าใช้ด้วย Facebook',
                        style: MyStyle().mainH2Title),
                  ),
                  children: [
                    // Padding(
                    //   padding: EdgeInsets.all(10),
                    //   child: CircleAvatar(
                    //     backgroundColor: Colors.transparent,
                    //     backgroundImage: NetworkImage('$image'),
                    //     radius: 70,
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'ชื่อ : $name',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'นามสกุล : $lastname',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: buildIDcardField(),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'อีเมล : $email',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: buildPasswordField(),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'เพศ',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: RadioListTile(
                                  value: 'ชาย',
                                  groupValue: gender,
                                  onChanged: (value) {
                                    setState(() {
                                      gender = value as String;
                                    });
                                  },
                                  title: Text("ชาย"),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: RadioListTile(
                                  value: 'หญิง',
                                  groupValue: gender,
                                  onChanged: (value) {
                                    setState(() {
                                      gender = value as String;
                                    });
                                  },
                                  title: Text("หญิง"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('วันเกิด',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18,
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: InkWell(
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Text(
                                "${birthday.day} /${birthday.month} /${birthday.year}",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black54),
                              ),
                              InkWell(
                                child: Icon(Icons.keyboard_arrow_down),
                                onTap: chooseDateTime,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: buildPhoneField(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            // print(
                            //   'เก็บข้อมูล : $name,$email, $phone, $gender,$birthday',
                            // );

                            if (phone == null ||
                                phone!.isEmpty ||
                                phone!.length != 10) {
                              normalDialog(
                                  context, 'โปรด กรอกเบอร์โทรศัพท์ให้ถูกต้อง');
                            } else if (idcard!.length != 13 ||
                                idcard!.isEmpty ||
                                idcard == null) {
                              normalDialog(
                                  context, 'โปรด กรอกบัตรประชาชนให้ถูกต้อง');
                            } else if (password!.length != 6 ||
                                password!.isEmpty ||
                                password == null) {
                              normalDialog(
                                  context, 'โปรด กรอกพาสเวิร์ดให้ถูกต้อง');
                            } else {
                              registerThread();
                              Navigator.pop(context);
                            }
                          },
                          child: Text('ยืนยัน'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('ยกเลิก'),
                        ),
                      ],
                    ),
                  ],
                ),
              ));
        });
  }

  chooseDateTime() async {
    DateTime? _datepicker = await showDatePicker(
      context: context,
      initialDate: birthday,
      firstDate: DateTime(1947),
      lastDate: DateTime(2030),
    );
    if (_datepicker != null && _datepicker != birthday) {
      setState(() {
        birthday = _datepicker;
        print(
          birthday.toString(),
        );
      });
    }
  }

  TextFormField buildIDcardField() {
    return TextFormField(
      onChanged: (value) => idcard = value.trim(),
      validator: (value) {
        if (value!.length != 13)
          return 'โปรดกรอกรหัสบัตรประจำตัวประชาชน 13 หลัก';
        else
          return null;
      },
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'รหัสบัตรประชาชน',
      ),
    );
  }

  TextFormField buildPhoneField() {
    return TextFormField(
      onChanged: (value) => phone = value.trim(),
      validator: (value) {
        if (value!.length != 10)
          return 'โปรดกรอกเบอร์โทร 10 หลัก';
        else
          return null;
      },
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'เบอร์โทรศัพท์',
      ),
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      onChanged: (value) => password = value.trim(),
      validator: (value) {
        if (value!.length < 6)
          return 'โปรดกรอกพาสเวิร์ดมากกว่า 6 หลัก';
        else
          return null;
      },
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'พาสเวิร์ด',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SignInButtonBuilder(
      backgroundColor: Colors.indigo,
      text: 'ล็อกอินด้วย Facebook',
      icon: Icons.facebook,
      onPressed: () => initiateFacebookLogin(),
    );
  }

  void initiateFacebookLogin() async {
    var facebookLoginResult =
        await facebookLogin.logIn(['email', 'public_profile']);

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        onLoginStatusChanged(false);
        print('การล็อกอินเออเร่อ');
        break;
      case FacebookLoginStatus.cancelledByUser:
        onLoginStatusChanged(false);
        print('การล็อกอินถูกยกเลิกโดยผู้ใช้');
        break;
      case FacebookLoginStatus.loggedIn:
        var graphResponse = await http.get(Uri.parse(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${facebookLoginResult.accessToken.token}'));

        var profile = json.decode(graphResponse.body);
        // print(profile.toString());

        onLoginStatusChanged(true, profileData: profile);

        break;
    }
    // _logout() async {
    //   await facebookLogin.logOut();
    //   onLoginStatusChanged(false);
    //   print("Logged out");
    // }
  }
}
