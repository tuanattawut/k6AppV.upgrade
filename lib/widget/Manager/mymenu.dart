import 'package:flutter/material.dart';

class MyMenu extends StatelessWidget {
  MyMenu({
    required this.title,
    required this.icon,
    required this.color,
    required this.route,
  });

  final String title;
  final IconData icon;
  final MaterialColor color;
  final route;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => route),
          );
        },
        splashColor: Colors.deepPurple,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                icon,
                size: 70,
                color: color,
              ),
              Text(title, style: TextStyle(fontSize: 20.0)),
            ],
          ),
        ),
      ),
    );
  }
}
