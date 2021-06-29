import 'package:flutter/material.dart';

class RegisterSeller extends StatefulWidget {
  @override
  _RegisterSellerState createState() => _RegisterSellerState();
}

class _RegisterSellerState extends State<RegisterSeller> {
  final _formstate = GlobalKey<FormState>();

  String name, lastname, password, email, phone, gender, image;
  File file;

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
              MyStyle().mySizebox(),
              groupImage(),
              buildNameField(),
              buildLastNameField(),
              buildEmailField(),
              buildPasswordField(),
              buildGenderField(),
              buildPhoneField(),
              MyStyle().mySizebox(),
              MyStyle().mySizebox(),
              buildRegisterButton(),
            ],
          ),
        ));
  }

  ElevatedButton buildRegisterButton() {
    return ElevatedButton(
      child: Text('สมัครสมาชิก'),
      onPressed: () async {
        if (this._formstate.currentState.validate()) if (name == null ||
            name.isEmpty ||
            lastname == null ||
            lastname.isEmpty ||
            password == null ||
            password.isEmpty ||
            phone == null ||
            phone.isEmpty) {
          normalDialog(context, 'มีช่องว่าง กรุณากรอกทุกช่อง ');
        } else if (email == null || email.isEmpty || !email.contains('@')) {
          normalDialog(context, 'กรอกอีเมลไม่ถูกต้อง');
        } else if (file == null) {
          normalDialog(context, 'โปรดใส่รูปภาพ');
        } else {
          uploadImage();
        }
      },
    );
  }

  Future<Null> uploadImage() async {
    Random random = Random();
    int i = random.nextInt(1000000);

    String nameImage = 'avatar$i.png';
    print('nameImage = $nameImage, pathImage = ${file.path}');

    String url = '${MyConstant().domain}/projectk6/saveimage.php';

    try {
      Map<String, dynamic> map = Map();
      map['file'] =
          await MultipartFile.fromFile(file.path, filename: nameImage);

      FormData formData = FormData.fromMap(map);
      await Dio().post(url, data: formData).then((value) {
        print('Response ===>>> $value');
        image = '/projectk6/Avatar/$nameImage';
        print('urlImage = $image');
        checkUser();
      });
    } catch (e) {}
  }

  Future<Null> checkUser() async {
    String url =
        '${MyConstant().domain}/projectk6/getUserWhereUser.php?isAdd=true&email=$email';
    try {
      Response response = await Dio().get(url);
      if (response.toString() == 'null') {
        register();
      } else {
        normalDialog(context, 'อีเมล $email ได้ถูกใช้ไปแล้ว กรุณาเปลี่ยนใหม่');
      }
    } catch (e) {}
  }

  Future<Null> register() async {
    String url =
        '${MyConstant().domain}/projectk6/addUser.php?isAdd=true&name=$name&lastname=$lastname&email=$email&password=$password&gender=$gender&phone=$phone&image=$image';

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

  Column groupImage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 150,
          child:
              file == null ? Image.asset('images/user.png') : Image.file(file),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () => chooseImage(ImageSource.camera),
              child: Text('ถ่ายภาพ'),
            ),
            TextButton(
                onPressed: () => chooseImage(ImageSource.gallery),
                child: Text('เลือกจากคลัง')),
          ],
        ),
      ],
    );
  }

  Future<Null> chooseImage(ImageSource imageSource) async {
    try {
      var object = await ImagePicker().getImage(
        source: imageSource,
        maxHeight: 800.0,
        maxWidth: 800.0,
      );

      setState(() {
        file = File(object.path);
      });
    } catch (e) {}
  }

  TextFormField buildGenderField() {
    return TextFormField(
      onChanged: (value) => gender = value.trim(),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'เพศ',
        hintText: 'ระบุหรือไม่ก็ได้',
      ),
    );
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
      ),
    );
  }

  TextFormField buildLastNameField() {
    return TextFormField(
      onChanged: (value) => lastname = value.trim(),
      validator: (value) {
        if (value.isEmpty)
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
        if (value.length < 10)
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
