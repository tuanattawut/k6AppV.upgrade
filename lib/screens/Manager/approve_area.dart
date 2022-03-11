import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/reserve_area_model.dart';
import 'package:k6_app/screens/Manager/approve_detail.dart';
import 'package:k6_app/utility/my_constant.dart';

class ApproveArea extends StatefulWidget {
  @override
  _ApproveAreaState createState() => _ApproveAreaState();
}

class _ApproveAreaState extends State<ApproveArea> {
  @override
  void initState() {
    super.initState();
    reserveArea();
  }

  bool? status = true;
  List<ResearveAreaModel> reserveList = [];
  Future<Null> reserveArea() async {
    String url = '${MyConstant().domain}/api/getReservearea.php';
    await Dio().get(url).then((value) {
      if (value.toString() != 'null') {
        // print('value ==>> $value');

        var result = json.decode(value.data);
        // print('result ==>> $result');

        for (var map in result) {
          ResearveAreaModel researveAreaModel = ResearveAreaModel.fromMap(map);
          setState(() {
            if (researveAreaModel.idSeller == '0') {
              reserveList.add(researveAreaModel);
            }
          });
        }
      } else {
        setState(() {
          status = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('อนุมัติแผง')),
      body: Container(
        child: showContent(),
      ),
    );
  }

  ListView showApprove() {
    return ListView.builder(
        itemCount: reserveList.length,
        itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.all(8),
              child: ListTile(
                onTap: () {
                  MaterialPageRoute route = MaterialPageRoute(
                      builder: (value) => ApproveAreaDetail(
                          researveAreaModel: reserveList[index]));
                  Navigator.of(context).push(route);
                },
                leading: Image.network(
                  '${MyConstant().domain}/images/areasshop/${reserveList[index].image}',
                  fit: BoxFit.cover,
                  width: 50,
                ),
                title: Text(
                  reserveList[index].firstname.toString(),
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                ),
              ),
            ));
  }

  Widget showContent() {
    return status!
        ? showApprove()
        : Center(
            child: Text(
              'ไม่มีการเช่าจองขณะนี้',
              style: TextStyle(fontSize: 18),
            ),
          );
  }
}
