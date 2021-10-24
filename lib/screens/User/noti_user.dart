import 'package:flutter/material.dart';

class NotiUser extends StatefulWidget {
  @override
  _NotiUserState createState() => _NotiUserState();
}

class _NotiUserState extends State<NotiUser> {
  @override
  void initState() {
    super.initState();
  }

  // Future<Null> getData() async {
  //   var response =
  //       await http.get(Uri.parse('https://covid19.th-stat.com/api/open/today'));

  //   setState(() {
  //     dataFromApi = covidFromJson(response.body);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('ประกาศแจ้งเตือน')),
        ),
        body: Container(
          child: ListView(
            children: <Widget>[],
          ),
        ));
  }
}
