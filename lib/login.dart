import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:k6_app/signinfb/signfb.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formstate = GlobalKey<FormState>();
  String email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formstate,
          child: ListView(
            children: <Widget>[
              buildEmailField(),
              buildPasswordField(),
              buildLoginButton(),
              buildRegisterButton(context),
              buildButtonFacebook(context),
            ],
          ),
        ));
  }

  ElevatedButton buildButtonFacebook(BuildContext context) {
    return ElevatedButton(
      child: Text('Facebook Login'),
      onPressed: () {
        loginWithFacebook();
      },
    );
  }

  ElevatedButton buildRegisterButton(BuildContext context) {
    return ElevatedButton(
      child: Text('Register new account'),
      onPressed: () {
        print('Goto  Regis pagge');
        Navigator.pushNamed(context, '/register');
      },
    );
  }

  ElevatedButton buildLoginButton() {
    return ElevatedButton(
        child: Text('Login'),
        onPressed: () async {
          if (this._formstate.currentState.validate()) {
            print('Valid Form');
            this._formstate.currentState.save();
            await FirebaseAuth.instance
                .signInWithEmailAndPassword(
                    email: this.email, password: this.password)
                .then((value) {
              if (value.user.emailVerified) {
                Scaffold.of(this._formstate.currentContext)
                    .showSnackBar(SnackBar(content: Text('Login Pass')));
                Navigator.pushNamed(context, '/homepage');
              } else {
                Scaffold.of(this._formstate.currentContext).showSnackBar(
                    SnackBar(content: Text('Please verify email')));
              }
            }).catchError((reason) {
              Scaffold.of(this._formstate.currentContext).showSnackBar(
                  SnackBar(content: Text('Login or Password Invalid')));
            });
          } else
            print('Invalid Form');
        });
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      onSaved: (value) {
        this.password = value.trim();
      },
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
      onSaved: (value) {
        this.email = value.trim();
      },
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
        hintText: 'x@x.com',
      ),
    );
  }

  Future<Null> callTypeUserDialog() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return SimpleDialog(
                title: ListTile(
                  title: Text('Type User ?'),
                  subtitle: Text('เลือกประเภทผู้ใช้'),
                ),
                children: [
                  RadioListTile(
                    value: 'user',
                    groupValue: typeUser,
                    onChanged: (value) {
                      setState(() {
                        typeUser = value;
                      });
                    },
                    title: Text('User'),
                  ),
                  RadioListTile(
                    value: 'merchant',
                    groupValue: typeUser,
                    onChanged: (value) {
                      setState(() {
                        typeUser = value;
                      });
                    },
                    title: Text('Merchant'),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        print(
                            ' Uid :    $uidfb , Name    :  $namefb , email :    $emailfb , Phone  : $phonefb, TypeUser  : $typeUser');
                      },
                      child: Text('ตกลง')),
                ],
              );
            },
          );
        });
  }

  String namefb, emailfb, phonefb, uidfb, typeUser = 'user';
  Future<Null> loginWithFacebook() async {
    FacebookLogin facebookLogin = FacebookLogin();

    FacebookLoginResult result =
        await facebookLogin.logIn(['email', 'public_profile']);

    String token = result.accessToken.token;

    FirebaseAuth.instance
        .signInWithCredential(FacebookAuthProvider.credential(token))
        .then((value) async {
      uidfb = value.user.uid;
      namefb = value.user.displayName;
      emailfb = value.user.email;
      phonefb = value.user.phoneNumber;

      await FirebaseFirestore.instance
          .collection('user')
          .doc(uidfb)
          .snapshots()
          .listen((event) {
        print('event ==> ${event.data()}');
        if (event.data() == null) {
          print(' ##### NULL ####');
          callTypeUserDialog();
        } else {
          print(' GO GO GO');
        }
      });
    });
    print('Token = $token');
    switch (result.status) {
      case FacebookLoginStatus.error:
        print("Error");
        break;

      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        break;

      case FacebookLoginStatus.loggedIn:
        print('login');
        break;
    }
  }
}
