import 'package:flutter/material.dart';
import 'package:k6_app/screens/login.dart';
import 'package:k6_app/screens/register.dart';
import 'package:splashscreen/splashscreen.dart';

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
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Kanit',
      ),
      home: new SplashScreen(
          seconds: 4,
          navigateAfterSeconds: LoginPage(),
          title: new Text('ยินดีต้อนรับ',
              style: TextStyle(color: Colors.blue, fontSize: 30)),
          image: new Image.asset('images/logo.png'),
          backgroundColor: Color.fromARGB(255, 204, 255, 230),
          styleTextUnderTheLoader: new TextStyle(),
          photoSize: 50,
          loaderColor: Colors.blue),
      initialRoute: '/',
      routes: {
        //'/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
      },
    );
  }
}
