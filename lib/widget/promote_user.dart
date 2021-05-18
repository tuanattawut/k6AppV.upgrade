import 'package:flutter/material.dart';
import 'package:k6_app/models/covid.dart';

import 'package:http/http.dart' as http;

class PromoteUser extends StatefulWidget {
  PromoteUser({Key key}) : super(key: key);

  @override
  _PromoteUserState createState() => _PromoteUserState();
}

class _PromoteUserState extends State<PromoteUser> {
  Covid dataFromApi;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    var response = await http.get('https://covid19.th-stat.com/api/open/today');

    setState(() {
      dataFromApi = covidFromJson(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('ข้อมูลโควิด')),
        ),
        body: Container(
          child: ListView(
            padding: EdgeInsets.all(20),
            children: <Widget>[
              Column(
                children: [
                  ListTile(
                    title: Text('ผู้ติดเชื้อใหม่'),
                    subtitle: Text('${dataFromApi?.newConfirmed}'),
                  ),
                  ListTile(
                    title: Text('หายป่วยกลับบ้าน'),
                    subtitle: Text('${dataFromApi?.newRecovered}'),
                  ),
                  ListTile(
                    title: Text('เสียชีวิต'),
                    subtitle: Text('${dataFromApi?.newDeaths ?? "..."}'),
                  ),
                  ListTile(
                    title: Text('ข้อมูลวันที่'),
                    subtitle: Text('${dataFromApi?.updateDate ?? "..."}'),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
