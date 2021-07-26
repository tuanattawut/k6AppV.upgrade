import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/seller_model.dart';
import 'package:k6_app/screens/Manager/detailapprove.dart';
import 'package:k6_app/utility/my_constant.dart';

class ApproveSeller extends StatefulWidget {
  @override
  _ApproveSellerState createState() => _ApproveSellerState();
}

class _ApproveSellerState extends State<ApproveSeller> {
  List<SellerModel> sellerModels = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<Null> getData() async {
    String api = '${MyConstant().domain}/projectk6/getSeller.php';
    await Dio().get(api).then((value) {
      for (var item in json.decode(value.data)) {
        SellerModel sellerModel = SellerModel.fromMap(item);
        setState(() {
          sellerModels.add(sellerModel);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('จัดการผู้ขาย'),
        ),
        body: SafeArea(
            child: ListView.builder(
          itemCount: sellerModels.length,
          itemBuilder: (context, index) => Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              onTap: () {
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (value) =>
                      DetailApprove(sellerModel: sellerModels[index]),
                );
                Navigator.of(context).push(route);
              },
              title: Text(
                sellerModels[index].name + ' ' + sellerModels[index].lastname,
                textScaleFactor: 1.5,
              ),
              trailing: Text(
                sellerModels[index].status == 'yes' ? 'อนุมัติ' : 'ไม่อนุมัติ',
                textScaleFactor: 1.5,
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
        )));
  }
}
