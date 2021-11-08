import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:k6_app/models/report_model.dart';
import 'package:k6_app/utility/my_style.dart';

class Chatreport extends StatefulWidget {
  Chatreport({required this.reportModel});
  final ReportModel reportModel;

  @override
  _ChatreportState createState() => _ChatreportState();
}

class _ChatreportState extends State<Chatreport> {
  ReportModel? reportModel;
  String? email, name, message, phone;
  final df = new DateFormat('dd/MM H:mm น.');
  @override
  void initState() {
    super.initState();
    reportModel = widget.reportModel;
    email = reportModel!.email;
    name = '${reportModel!.firstname}  ${reportModel!.lastname}';
    message = reportModel!.message;
    phone = reportModel!.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(name!)),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              behavior: HitTestBehavior.opaque,
              child: Column(
                children: <Widget>[
                  MyStyle().mySizebox(),
                  Row(
                    children: [
                      MyStyle().showTitleH2('ชื่อ'),
                      MyStyle().mySizebox(),
                      Text(
                        name!,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  MyStyle().mySizebox(),
                  Row(
                    children: [
                      MyStyle().showTitleH2('อีเมล'),
                      MyStyle().mySizebox(),
                      Text(
                        email!,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  MyStyle().mySizebox(),
                  Row(
                    children: [
                      MyStyle().showTitleH2('เบอร์โทร'),
                      MyStyle().mySizebox(),
                      Text(
                        phone!,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  MyStyle().mySizebox(),
                  Divider(),
                  MyStyle().mySizebox(),
                  Row(
                    children: [
                      MyStyle().showTitleH2('ข้อความ'),
                    ],
                  ),
                  MyStyle().mySizebox(),
                  Text(
                    message!,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  MyStyle().mySizebox(),
                  MyStyle().mySizebox(),
                  Row(
                    children: [
                      Text(
                        'วันและเวลาที่ส่ง',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      MyStyle().mySizebox(),
                      Text(
                        df.format(
                            DateTime.parse(reportModel!.regdate.toString())),
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )));
  }
}
