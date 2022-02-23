import 'package:flutter/material.dart';

class MyStyle {
  Color primaryColor = Colors.deepPurple;
  Color lightColor = Colors.deepPurple.shade200;
  Color darkColor = Colors.deepPurple.shade800;

  TextStyle mainTitle = TextStyle(
    fontSize: 20,
  );

  TextStyle mainH2Title = TextStyle(
    fontSize: 18,
  );

  SizedBox mySizebox() => SizedBox(
        width: 8.0,
        height: 16.0,
      );

  Text showTitle(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 20,
        ),
      );

  Text showTitleH2(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 18,
        ),
      );

  Text showTitleH3(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
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

  Widget showLinearProgress() {
    return Center(
      child: LinearProgressIndicator(),
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

  MyStyle();
}
