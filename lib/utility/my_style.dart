import 'dart:ui';

import 'package:flutter/material.dart';

class MyStyle {
  Color tealColor = Colors.teal.shade500;
  Color primaryColor = Color(0xff03ffb4);
  Color lightColor = Color(0xff6dffe6);
  Color darkColor = Color(0xff00cb84);

  TextStyle mainTitle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: Colors.teal.shade700,
  );

  TextStyle mainH2Title = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: Colors.red.shade700,
  );

  SizedBox mySizebox() => SizedBox(
        width: 8.0,
        height: 16.0,
      );

  Text showTitle(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 25, color: Colors.teal, fontWeight: FontWeight.bold),
      );

  Text showTitleH2(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 18, color: Colors.teal, fontWeight: FontWeight.bold),
      );

  Text showTitleH3(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.teal,
          fontWeight: FontWeight.w500,
        ),
      );

  Text showTitleH3White(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      );

  Text showTitleH3Red(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.red.shade900,
          fontWeight: FontWeight.w500,
        ),
      );

  Text showTitleH3Purple(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.purple.shade700,
          fontWeight: FontWeight.w500,
        ),
      );

  Container showLogo() {
    return Container(
      child: Image.asset(
        'images/logo.png',
        height: 150,
        width: 150,
      ),
    );
  }

  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  BoxDecoration myBoxDecoration(String namePic) {
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage('images/$namePic'),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget titleCenter(BuildContext context, String string) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Text(
          string,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Container buildBackground(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image(
              image: AssetImage('images/top1.png'),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Image(
              image: AssetImage('images/top2.png'),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image(
              image: AssetImage('images/bottom1.png'),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image(
              image: AssetImage('images/bottom2.png'),
            ),
          ),
        ],
      ),
    );
  }

  MyStyle();
}
