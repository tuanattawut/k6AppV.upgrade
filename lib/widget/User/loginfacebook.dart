import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:k6_app/models/user_models.dart';
import 'package:k6_app/screens/User/main_user.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';
import 'package:k6_app/utility/normal_dialog.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginFacebook extends StatefulWidget {
  @override
  _LoginFacebookState createState() => _LoginFacebookState();
}

class _LoginFacebookState extends State<LoginFacebook> {
  String? firstname, lastname, email, password, gender, phone, image;

  bool isLoggedIn = false;

  var profileData;

  // static final FacebookLogin facebookSignIn = new FacebookLogin();

  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
      this.profileData = profileData;

      firstname = profileData['first_name'];
      lastname = profileData['last_name'];
      email = profileData['email'];
      checkUser();
    });
  }

  Future<Null> registerThread() async {
    String url =
        '${MyConstant().domain}/api/adduser?firstname=$firstname&lastname=$lastname&phone=$phone&gender=$gender&email=$email&image&password=$password';

    try {
      Response response = await Dio().get(url);
      //print('res = $response');
      var result = json.decode(response.data);
      if (result == true) {
        normalDialog(context, 'เข้าใช้สำเร็จด้วยชื่อ :\n$firstname');
      } else {
        normalDialog(context, 'ไม่สามารถ สมัครได้ กรุณาลองอีกครั้ง');
      }
    } catch (e) {
      normalDialog(context, 'ผิดพลาด ${e.toString()}');
    }
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
          //print(response.toString());
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
                                password!.length < 8) {
                              normalDialog(context,
                                  'โปรด กรอกรหัสผ่านให้ถูกต้อง\nและมากกว่า 8 ตัวอักษร');
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
      text: 'เข้าสู่ระบบด้วย Facebook',
      icon: Icons.facebook,
      onPressed: () => initiateFacebookLogin(),
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      onChanged: (value) => password = value.trim(),
      validator: (value) {
        if (value!.length < 8)
          return 'โปรดกรอกรหัสผ่านมากกว่า 8 หลัก';
        else
          return null;
      },
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'รหัสผ่าน',
      ),
    );
  }

  void initiateFacebookLogin() async {
    final result = await FacebookAuth.i.login(
      permissions: [
        'email',
        'public_profile',
        'user_birthday',
        'user_friends',
        'user_gender',
        'user_link'
      ],
    );

    if (result.status == LoginStatus.success) {
      print(result.message);
      // you are logged
      // final AccessToken accessToken = result.accessToken!;
      //  print('นี่คือโทเคน >> ${accessToken.token}');
      final userData = await FacebookAuth.i.getUserData(
        fields:
            "first_name,last_name,email,picture.width(200),birthday,friends,gender,link",
      );
      // print(userData);
      onLoginStatusChanged(true, profileData: userData);
    } else {
      print(result.status);
      print(result.message);
      onLoginStatusChanged(false);
    }
  }
}
