import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:k6_app/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formstate = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  String typeUser;

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Register", style: TextStyle(color: Colors.white)),
        ),
        body: Form(
          key: _formstate,
          child: ListView(
            children: <Widget>[
              buildNameField(),
              buildEmailField(),
              buildPasswordField(),
              buildPhoneField(),
              buildTitle(),
              buildTyperUser(),
              buildTyperMerchant(),
              buildRegisterButton(),
            ],
          ),
        ));
  }

  RadioListTile<String> buildTyperMerchant() {
    return RadioListTile(
      value: 'merchant',
      groupValue: typeUser,
      onChanged: (value) {
        setState(() {
          typeUser = value;
        });
      },
      title: Text('Merchant'),
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
      title: Text('User'),
    );
  }

  Container buildTitle() {
    return Container(
        margin: EdgeInsets.only(top: 20), child: Text('Type User : '));
  }

  ElevatedButton buildRegisterButton() {
    return ElevatedButton(
      child: Text('Register'),
      onPressed: () async {
        if (this._formstate.currentState.validate()) print(this.email.text);
        print(this.password.text);

        final _user = await auth.createUserWithEmailAndPassword(
            email: this.email.text.trim(), password: this.password.text.trim());
        _user.user.sendEmailVerification();
        String uid = auth.currentUser.uid.toString();

        Map<String, dynamic> users = {
          'uid': uid,
          'name': name.text,
          'email': email.text,
          'phone': phonenumber.text,
          'typeuser': typeUser,
        };

        await FirebaseFirestore.instance
            .collection('user')
            .doc(uid)
            .set(users)
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
      controller: password,
      validator: (value) {
        if (value.length < 6)
          return 'Please Enter more than 6 Character';
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
      controller: email,
      validator: (value) {
        if (value.isEmpty)
          return 'Please fill in E-mail field';
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
      controller: name,
      validator: (value) {
        if (value.isEmpty)
          return 'Please fill in Name field';
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
      controller: phonenumber,
      validator: (value) {
        if (value.length < 10)
          return 'Please Enter more than 10 Character';
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
