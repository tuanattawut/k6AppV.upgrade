import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:k6_app/screens/login.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';
import 'package:k6_app/utility/normal_dialog.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formstate = GlobalKey<FormState>();

  String? name, lastname, password, email, phone, gender, image = 'profile.jpg';
  File? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("สมัครสมาชิก"),
        ),
        body: Form(
            key: _formstate,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              behavior: HitTestBehavior.opaque,
              child: ListView(
                padding: EdgeInsets.all(20.0),
                children: <Widget>[
                  // groupImage(),
                  buildNameField(),
                  buildLastNameField(),
                  buildEmailField(),
                  buildPasswordField(),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'เพศ',
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
                                  gender = value as String?;
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
                                  gender = value as String?;
                                });
                              },
                              title: Text("หญิง"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  buildPhoneField(),
                  MyStyle().mySizebox(),
                  MyStyle().mySizebox(),
                  buildRegisterButton(),
                ],
              ),
            )));
  }

  Container buildRegisterButton() {
    return Container(
        margin: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Color.fromARGB(255, 81, 247, 164)],
            begin: FractionalOffset.centerLeft,
            end: FractionalOffset.centerRight,
          ),
        ),
        child: TextButton(
          child: const Text(
            'สมัครสมาชิก',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          onPressed: () async {
            if (this._formstate.currentState!.validate()) if (name == null ||
                name!.isEmpty ||
                lastname == null ||
                lastname!.isEmpty ||
                password == null ||
                password!.isEmpty ||
                phone == null ||
                phone!.isEmpty ||
                phone!.length != 10 ||
                gender == null ||
                gender!.isEmpty) {
              normalDialog(context, 'มีช่องว่าง กรุณากรอกทุกช่อง ');
            } else if (email == null ||
                email!.isEmpty ||
                !email!.contains('@')) {
              normalDialog(context, 'กรอกอีเมลไม่ถูกต้อง');
            }
            // else if (file == null) {
            //   normalDialog(context, 'โปรดใส่รูปภาพ');
            // }
            else {
              showLoade(context);
              //uploadImage();
              checkUser();
            }
          },
        ));
  }

  Future<Null> uploadImage() async {
    Random random = Random();
    int i = random.nextInt(100000);

    String nameImage = 'user_$i.jpg';
    //print('nameImage = $nameImage, pathImage = ${file?.path}');

    String url = '${MyConstant().domain}/upload/saveImageUser.php';
    // print(url);
    try {
      Map<String, dynamic> map = Map();
      map['file'] =
          await MultipartFile.fromFile(file!.path, filename: nameImage);

      FormData formData = FormData.fromMap(map);
      await Dio().post(url, data: formData).then((value) {
        // print('Response ===>>> $value');
        image = '$nameImage';
        //print('urlImage = $image');
        checkUser();
      });
    } catch (e) {}
  }

  Future<Null> checkUser() async {
    String url =
        '${MyConstant().domain}/api/getUserEmail.php?isAdd=true&email=$email';
    try {
      Response response = await Dio().get(url);
      Navigator.pop(context);
      if (response.toString() == 'null') {
        register();
      } else {
        normalDialog(context, 'อีเมล $email ได้ถูกใช้ไปแล้ว กรุณาเปลี่ยนใหม่');
      }
    } catch (e) {}
  }

  Future<Null> register() async {
    String url =
        '${MyConstant().domain}/api/adduser?firstname=$name&lastname=$lastname&phone=$phone&gender=$gender&email=$email&image&password=$password';

    try {
      Response response = await Dio().get(url);
      var result = json.decode(response.data);
      print(result);
      if (result == true) {
        normalDialog(context, 'สมัครสำเร็จ');
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        normalDialog(context, 'ไม่สามารถ สมัครได้กรุณาลองอีกครั้ง');
      }
    } catch (e) {
      normalDialog(context, 'ผิดพลาด ${e.toString()}');
    }
  }

  Column groupImage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 150,
          child:
              file == null ? Image.asset('images/user.png') : Image.file(file!),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () => chooseImage(ImageSource.camera),
              label: Text('ถ่ายภาพ'),
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.image),
              onPressed: () => chooseImage(ImageSource.gallery),
              label: Text('เลือกจากคลัง'),
            ),
          ],
        ),
      ],
    );
  }

  Future<Null> chooseImage(ImageSource imageSource) async {
    try {
      var object = await ImagePicker().pickImage(
        source: imageSource,
        maxHeight: 800.0,
        maxWidth: 800.0,
      );

      setState(() {
        file = File(object!.path);
      });
    } catch (e) {}
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

  TextFormField buildEmailField() {
    return TextFormField(
      onChanged: (value) => email = value.trim(),
      validator: (value) {
        if (!value!.contains('@') || value.isEmpty)
          return 'โปรดกรอกอีเมลในช่อง ตัวอย่าง  xx@xx.com';
        else
          return null;
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'อีเมล',
      ),
    );
  }

  TextFormField buildNameField() {
    return TextFormField(
      onChanged: (value) => name = value.trim(),
      validator: (value) {
        if (value!.isEmpty)
          return 'โปรดกรอกชื่อในช่อง';
        else
          return null;
      },
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'ชื่อ',
      ),
    );
  }

  TextFormField buildLastNameField() {
    return TextFormField(
      onChanged: (value) => lastname = value.trim(),
      validator: (value) {
        if (value!.isEmpty)
          return 'โปรดกรอกนามสกุลในช่อง';
        else
          return null;
      },
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'นามสกุล',
        icon: null,
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
}
