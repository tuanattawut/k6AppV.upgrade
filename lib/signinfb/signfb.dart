import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

String name, email, phone, uid;
Future<Null> loginWithFacebook() async {
  FacebookLogin facebookLogin = FacebookLogin();

  FacebookLoginResult result =
      await facebookLogin.logIn(['email', 'public_profile']);

  String token = result.accessToken.token;

  FirebaseAuth.instance
      .signInWithCredential(FacebookAuthProvider.credential(token))
      .then((value) async {
    uid = value.user.uid;
    name = value.user.displayName;
    email = value.user.email;
    phone = value.user.phoneNumber;

    print(
        ' Uid :    $uid , Name    :  $name , email :    $email , Phone  : $phone');

    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .snapshots()
        .listen((event) {
      print('event ==> ${event.data()}');
      if (event.data() == null) {
        print(' ##### NULL ####');
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
