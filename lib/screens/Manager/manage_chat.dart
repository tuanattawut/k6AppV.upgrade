import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:k6_app/models/report_model.dart';
import 'package:k6_app/screens/Manager/chatreport_manager.dart';
import 'package:k6_app/utility/my_constant.dart';

class ManageChats extends StatefulWidget {
  @override
  _ManageChatsState createState() => _ManageChatsState();
}

class _ManageChatsState extends State<ManageChats> {
  @override
  void initState() {
    super.initState();
    getReport();
  }

  final df = new DateFormat('dd/MM H:mm น.');
  List<ReportModel> reportList = [];
  Future<Null> getReport() async {
    String api = '${MyConstant().domain}/api/getReport.php';

    await Dio().get(api).then((value) {
      //print(value);
      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          ReportModel reportModel = ReportModel.fromMap(item);
          setState(() {
            reportList.add(reportModel);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แจ้งปัญหา'),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: reportList.length,
            itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.all(8),
                  child: ListTile(
                    onTap: () {
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (value) =>
                              Chatreport(reportModel: reportList[index]));
                      Navigator.of(context).push(route);
                    },
                    leading: Image.network(
                      '${MyConstant().domain}/upload/user/${reportList[index].image}',
                      fit: BoxFit.cover,
                      width: 50,
                    ),
                    title: Text(
                      '${reportList[index].firstname} ${reportList[index].lastname}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    trailing: Text(
                      df.format(
                          DateTime.parse(reportList[index].regdate.toString())),
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                )),
      ),
    );
  }
}
