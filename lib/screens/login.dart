import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:k6_app/models/user_models.dart';
import 'package:k6_app/utility/my_style.dart';
import 'package:k6_app/utility/normal_dialog.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

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
            padding: EdgeInsets.all(20.0),
            children: <Widget>[
              MyStyle().mySizebox(),
              MyStyle().showLogo(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ระบบแนะนำสินค้าและร้านค้า',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              MyStyle().mySizebox(),
              buildEmailField(),
              buildPasswordField(),
              MyStyle().mySizebox(),
              buildLoginButton(),
              buildRegisterButton(context),
              facebookButton(context),
            ],
          ),
        ));
  }

  SignInButtonBuilder facebookButton(BuildContext context) {
    return SignInButtonBuilder(
      backgroundColor: Colors.deepPurple,
      text: 'ล็อกอินด้วย Facebook',
      icon: Icons.facebook,
      onPressed: () {
        loginWithFacebook();
      },
    );
  }

  ElevatedButton buildRegisterButton(BuildContext context) {
    return ElevatedButton(
      child: Text('สมัครสมาชิกใหม่'),
      onPressed: () {
        print('Goto  Regis pagge');
        Navigator.pushNamed(context, '/register');
      },
    );
  }

  ElevatedButton buildLoginButton() {
    return ElevatedButton(
        child: Text('ล็อกอิน'),
        onPressed: () async {
          if (this._formstate.currentState.validate()) {
            print('Valid Form');
            this._formstate.currentState.save();
            await FirebaseAuth.instance
                .signInWithEmailAndPassword(
                    email: this.email, password: this.password)
                .then((value) async {
              if (value.user.emailVerified) {
                ScaffoldMessenger.of(this._formstate.currentContext)
                    .showSnackBar(SnackBar(content: Text('Login Pass')));
                print('#### Login with Email SS');

                // await Firebase.initializeApp().then((value) async {
                //   String uid = FirebaseAuth.instance.currentUser.uid.toString();
                //   FirebaseFirestore.instance
                //       .collection('user')
                //       .doc(uid)
                //       .snapshots()
                //       .listen((event) {
                //     UserModels model = UserModels.fromMap(event.data());
                //     switch (model.typeuser) {
                //       case 'user':
                //         Navigator.pushNamed(context, '/homepage');
                //         break;
                //       case 'seller':
                //         Navigator.pushNamed(context, '/homeseller');
                //         break;
                //       case 'manager':
                //         Navigator.pushNamed(context, '/homemanager');
                //         break;
                //       default:
                //     }
                //   });
                // });
              } else {
                ScaffoldMessenger.of(this._formstate.currentContext)
                    .showSnackBar(
                        SnackBar(content: Text('Please verify email')));
              }
            }).catchError((reason) {
              ScaffoldMessenger.of(this._formstate.currentContext).showSnackBar(
                  SnackBar(content: Text('Login or Password Invalid')));
            });
          } else
            print('Invalid Form');
          normalDialog(context, 'กรุณากรอกข้อมูล');
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

  Future<Null> insertUserfbtoCloud() async {
    // UserModel model = UserModel(
    //   name: name,
    //   email: email,
    //   phone: phone,
    //   typeuser: typeUser,
    //   uid: uid,
    // );
    // Map<String, dynamic> data = model.toMap();
    // await Firebase.initializeApp().then((value) async {
    //   await FirebaseFirestore.instance
    //       .collection('user')
    //       .doc(uid)
    //       .set(data)
    //       .then((value) {
    //     switch (typeUser) {
    //       case 'user':
    //         Navigator.pushNamed(context, '/homepage');
    //         break;
    //       case 'seller':
    //         Navigator.pushNamed(context, '/homeseller');
    //         break;
    //       case 'manager':
    //         Navigator.pushNamed(context, '/homemanager');
    //         break;
    //       default:
    //     }
    //   });
    // });
  }

  Future<Null> callTypeUserDialog() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return SimpleDialog(
                title: ListTile(
                  title: Text('ประเภทผู้ใช้ ?'),
                  subtitle: Text('โปรดเลือกประเภทผู้ใช้'),
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
                    title: Text('สมาชิก'),
                  ),
                  RadioListTile(
                    value: 'seller',
                    groupValue: typeUser,
                    onChanged: (value) {
                      setState(() {
                        typeUser = value;
                      });
                    },
                    title: Text('ผู้ขาย'),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        print(
                            ' Uid :    $uid , Name    :  $name , email :    $email , Phone  : $phone, TypeUser  : $typeUser');
                        insertUserfbtoCloud();
                      },
                      child: Text('ตกลง')),
                ],
              );
            },
          );
        });
  }

  String name, phone, uid, typeUser = 'user';
  Future<Null> loginWithFacebook() async {
    //   FacebookLogin facebookLogin = FacebookLogin();

    //   FacebookLoginResult result =
    //       await facebookLogin.logIn(['email', 'public_profile']);

    //   String token = result.accessToken.token;

    //   FirebaseAuth.instance
    //       .signInWithCredential(FacebookAuthProvider.credential(token))
    //       .then((value) async {
    //     uid = value.user.uid;
    //     name = value.user.displayName;
    //     email = value.user.email;
    //     phone = value.user.phoneNumber;

    //     FirebaseFirestore.instance
    //         .collection('user')
    //         .doc(uid)
    //         .snapshots()
    //         .listen((event) {
    //       print('event ==> ${event.data()}');
    //       if (event.data() == null) {
    //         callTypeUserDialog();
    //       } else {
    //         Firebase.initializeApp().then((value) async {
    //           FirebaseFirestore.instance
    //               .collection('user')
    //               .doc(uid)
    //               .snapshots()
    //               .listen((event) {
    //             UserModels model = UserModels.fromMap(event.data());
    //             switch (model.typeuser) {
    //               case 'user':
    //                 Navigator.pushNamed(context, '/homepage');
    //                 break;
    //               case 'seller':
    //                 Navigator.pushNamed(context, '/homeseller');
    //                 break;
    //               case 'manager':
    //                 Navigator.pushNamed(context, '/homemanager');
    //                 break;
    //               default:
    //             }
    //           });
    //         });
    //       }
    //     });
    //   });
    //   print('Token = $token');
    //   switch (result.status) {
    //     case FacebookLoginStatus.error:
    //       print("Error");
    //       break;

    //     case FacebookLoginStatus.cancelledByUser:
    //       print("CancelledByUser");
    //       break;

    //     case FacebookLoginStatus.loggedIn:
    //       print('login');
    //       break;
    //   }
  }
}
