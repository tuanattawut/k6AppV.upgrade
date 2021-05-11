import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:k6_app/screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:k6_app/models/user_models.dart';
import 'package:k6_app/utility/my_style.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formstate = GlobalKey<FormState>();

  String name, password, email, phone, typeUser;

  final auth = FirebaseAuth.instance;

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
              buildNameField(),
              buildEmailField(),
              buildPasswordField(),
              buildPhoneField(),
              MyStyle().mySizebox(),
              MyStyle().showTitleH2('เลือกชนิดของสมาชิก:'),
              buildTyperUser(),
              buildTyperSeller(),
              MyStyle().mySizebox(),
              buildRegisterButton(),
            ],
          ),
        ));
  }

  RadioListTile<String> buildTyperSeller() {
    return RadioListTile(
      value: 'seller',
      groupValue: typeUser,
      onChanged: (value) {
        setState(() {
          typeUser = value;
        });
      },
      title: Text('ผู้ขาย'),
    );
  }

  RadioListTile<String> buildTyperUser() {
    return RadioListTile(
      value: 'user',
      groupValue: typeUser,
      onChanged: (value) {
        setState(() {
          typeUser = value;
        });
      },
      title: Text('สมาชิก'),
    );
  }

  ElevatedButton buildRegisterButton() {
    return ElevatedButton(
      child: Text('Register'),
      onPressed: () async {
        if (this._formstate.currentState.validate()) print(this.email);
        print(this.password);

        final _user = await auth.createUserWithEmailAndPassword(
            email: this.email.trim(), password: this.password.trim());
        _user.user.sendEmailVerification();
        String uid = auth.currentUser.uid.toString();

        UserModels model = UserModels(
            name: name,
            email: email,
            phone: phone,
            typeuser: typeUser,
            uid: uid);
        Map<String, dynamic> data = model.toMap();
        await FirebaseFirestore.instance
            .collection('user')
            .doc(uid)
            .set(data)
            .then((value) => print('Insert value'));

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
            ModalRoute.withName('/'));
      },
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
        labelText: 'Password',
        icon: Icon(Icons.lock),
      ),
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      onChanged: (value) => email = value.trim(),
      validator: (value) {
        if (value.isEmpty)
          return 'โปรดกรอกอีเมลในช่อง';
        else
          return null;
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'E-mail',
        icon: Icon(Icons.email),
        hintText: 'aa@aa.com',
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
        labelText: 'Full Name',
        icon: Icon(Icons.person),
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
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'Phone Number',
        icon: Icon(Icons.phone_android),
      ),
    );
  }
}
