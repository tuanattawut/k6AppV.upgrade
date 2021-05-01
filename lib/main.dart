import 'package:flutter/material.dart';
import 'package:k6_app/homemanager.dart';
import 'package:k6_app/homemerchant.dart';
import 'package:k6_app/homepage.dart';
import 'package:k6_app/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:k6_app/register.dart';

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
        '/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/homepage': (context) => Homepage(),
        '/homemerchant': (context) => Homemerchant(),
        '/homemanager': (context) => Homemanager(),
      },
    );
  }
}
