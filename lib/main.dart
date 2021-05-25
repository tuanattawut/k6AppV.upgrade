import 'package:flutter/material.dart';
import 'package:k6_app/screens/Manager/main_manager.dart';
import 'package:k6_app/screens/Seller/main_seller.dart';
import 'package:k6_app/screens/User/main_user.dart';
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
      title: 'K6 E-App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/',
      routes: {
        '/loginpage': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/homepage': (context) => Homepage(),
        '/homeseller': (context) => Homeseller(),
        '/': (context) => Homemanager(),
      },
    );
  }
}
