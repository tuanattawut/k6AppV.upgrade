import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:http/http.dart' as http;
import 'package:k6_app/models/user_models.dart';
import 'package:k6_app/screens/User/main_user.dart';
import 'package:k6_app/utility/enc-dec.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';
import 'package:k6_app/utility/normal_dialog.dart';

class LoginFacebook extends StatefulWidget {
  @override
  _LoginFacebookState createState() => _LoginFacebookState();
}

class _LoginFacebookState extends State<LoginFacebook> {
  String? firstname, lastname, email, password, gender, phone, image;

  bool isLoggedIn = false;

  var profileData;

  var facebookLogin = FacebookLogin();

  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
      this.profileData = profileData;

      firstname = profileData['first_name'];
      lastname = profileData['last_name'];
      email = profileData['email'];
      image = 'profile.jpg';
      checkUser();
    });
  }

  Future<Null> registerThread() async {
    String passwordMd5 = generateMd5(password!);
    String url =
        '${MyConstant().domain}/api/addUser.php?isAdd=true&firstname=$firstname&lastname=$lastname&email=$email&password=$passwordMd5&gender=$gender&phone=$phone&image=$image';

    try {
      Response response = await Dio().get(url);
      //print('res = $response');
      print(passwordMd5);
      if (response.toString() == 'ได้') {
        normalDialog(
            context, 'เข้าใช้สำเร็จด้วยชื่อ :\n${profileData['name']} ');
      } else {
        normalDialog(context, 'ไม่สามารถ สมัครได้ กรุณาลองอีกครั้ง');
      }
    } catch (e) {}
  }

  Future<Null> checkUser() async {
    String url =
        '${MyConstant().domain}/api/getUserEmail.php?isAdd=true&email=$email';
    try {
      Response response = await Dio().get(url);
      var result = json.decode(response.data);
      if (response.toString() == 'null') {
        showAddFBDialog();
      } else {
        for (var map in result) {
          UserModel userModel = UserModel.fromMap(map);
          MaterialPageRoute route = MaterialPageRoute(
            builder: (value) => Homepage(
              usermodel: userModel,
            ),
          );
          Navigator.of(context).push(route);

          print(response.toString());
          // Navigator.pushNamed(context, '/homepage'); break;
        }
      }
    } catch (e) {
      normalDialog(context, 'ผิดพลาด : ${e.toString()}');
      //print('Have e Error ===>> ${e.toString()}');
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
                    //     backgroundImage: NetworkImage(
                    //         '${MyConstant().domain}/upload/profile/profile.jpg'),
                    //     radius: 70,
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'ชื่อ : $firstname',
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
                      child: buildPhoneField(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            // print(
                            //     'เก็บข้อมูล : $firstname,$email, $phone, $gender ,$password');

                            if (phone == null ||
                                phone!.isEmpty ||
                                phone!.length != 10) {
                              normalDialog(context, 'โปรด กรอกเบอร์โทรศัพท์');
                            } else if (password == null ||
                                password!.isEmpty ||
                                password!.length < 6) {
                              normalDialog(context,
                                  'โปรด กรอกพาสเวิร์ดให้ถูกต้อง\nและมากกว่า 6 ตัวอักษร');
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

  @override
  Widget build(BuildContext context) {
    return SignInButtonBuilder(
      backgroundColor: Colors.indigo,
      text: 'ล็อกอินด้วย Facebook',
      icon: Icons.facebook,
      onPressed: () => initiateFacebookLogin(),
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
        print(profile.toString());

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
