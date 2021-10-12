import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
            children: <Widget>[
              Card(
                margin: EdgeInsets.all(20),
                shadowColor: Colors.red,
                elevation: 15,
                child: Column(
                  children: [
                    ListTile(
                      title: Text('ผู้ติดเชื้อใหม่'),
                      subtitle: Text('+ ${'dataFromApi?.newConfirmed'}'),
                    ),
                    ListTile(
                      title: Text('หายป่วยกลับบ้าน'),
                      subtitle: Text('${'dataFromApi?.newRecovered'}'),
                    ),
                    ListTile(
                      title: Text('เสียชีวิต'),
                      subtitle: Text('${'dataFromApi?.newDeaths'}'),
                    ),
                    ListTile(
                      title: Text('ข้อมูลวันที่'),
                      subtitle: Text('${'dataFromApi?.updateDate'}'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
