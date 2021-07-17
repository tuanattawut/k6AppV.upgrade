import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:k6_app/models/covid.dart';

class NotiUser extends StatefulWidget {
  NotiUser({Key key}) : super(key: key);

  @override
  _NotiUserState createState() => _NotiUserState();
}

class _NotiUserState extends State<NotiUser> {
  Covid dataFromApi;

  @override
  void initState() {
    super.initState();
  }

  Future<Null> getData() async {
    var response =
        await http.get(Uri.parse('https://covid19.th-stat.com/api/open/today'));

    setState(() {
      dataFromApi = covidFromJson(response.body);
    });
  }

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
                      subtitle:
                          Text('+ ${dataFromApi?.newConfirmed ?? 'กำลังโหลด'}'),
                    ),
                    ListTile(
                      title: Text('หายป่วยกลับบ้าน'),
                      subtitle:
                          Text('${dataFromApi?.newRecovered ?? 'กำลังโหลด'}'),
                    ),
                    ListTile(
                      title: Text('เสียชีวิต'),
                      subtitle:
                          Text('${dataFromApi?.newDeaths ?? 'กำลังโหลด'}'),
                    ),
                    ListTile(
                      title: Text('ข้อมูลวันที่'),
                      subtitle:
                          Text('${dataFromApi?.updateDate ?? 'กำลังโหลด'}'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
