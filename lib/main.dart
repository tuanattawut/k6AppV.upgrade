import 'package:flutter/material.dart';
import 'package:k6_app/screens/main_manager.dart';
import 'package:k6_app/screens/main_seller.dart';
import 'package:k6_app/screens/main_user.dart';
import 'package:k6_app/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:k6_app/screens/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return buildMaterialApp();
  }

  MaterialApp buildMaterialApp() {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/',
      routes: {
        '/loginpage': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/': (context) => Homepage(),
        '/homeseller': (context) => Homeseller(),
        '/homemanager': (context) => Homemanager(),
      },
    );
  }
}
