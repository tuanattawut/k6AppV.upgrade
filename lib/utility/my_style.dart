import 'dart:ui';

import 'package:flutter/material.dart';

class MyStyle {
  Color primaryColor = Color(0xff00b8d4);
  Color lightColor = Color(0xff62ebff);
  Color darkColor = Color(0xff0088a3);

  TextStyle mainTitle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  );

  TextStyle mainH2Title = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
  );

  SizedBox mySizebox() => SizedBox(
        width: 8.0,
        height: 16.0,
      );

  Text showTitle(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      );

  Text showTitleH2(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      );

  Text showTitleH3(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
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
