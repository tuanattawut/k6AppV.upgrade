import 'package:flutter/material.dart';
import 'package:k6_app/screens/Manager/main_manager.dart';
import 'package:k6_app/screens/login.dart';
import 'package:k6_app/screens/register.dart';
import 'package:k6_app/widget/User/search.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/dd': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/homemanager': (context) => Homemanager(),
        '/': (context) => SearchBar(),
      },
    );
  }
}
