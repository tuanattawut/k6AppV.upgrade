import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/seller_model.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';
import 'package:k6_app/utility/normal_dialog.dart';

class ApproveSeller extends StatefulWidget {
  @override
  _ApproveSellerState createState() => _ApproveSellerState();
}

class ListItem {
  String status;
  String name;
  ListItem(this.status, this.name);
}

class _ApproveSellerState extends State<ApproveSeller> {
  List<SellerModel> sellerModels = [];
  String? _value;
  List<ListItem> _dropdownItems = [
    ListItem('yes', 'อนุมัติ'),
    ListItem('no', 'ไม่อนุมัติ'),
  ];

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

  Future<Null> editSeller(SellerModel sellermodel) async {
    String id = sellermodel.idSeller;

    String url =
        '${MyConstant().domain}/projectk6/editSeller.php?isAdd=true&id_seller=$id&status=$_value';
    await Dio().get(url).then((value) async {
      if (value.toString() == 'true') {
        await normalDialog(context, 'สำเร็จ');
      } else {
        normalDialog(context, 'กรุณาลองใหม่ มีอะไร ? ผิดพลาด');
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
                showDetailDialog(sellerModels[index]);
              },
              title: Text(
                sellerModels[index].name + ' ' + sellerModels[index].lastname,
                textScaleFactor: 1.5,
              ),
              trailing: Icon(Icons.edit),
            ),
          ),
        )));
  }

  Future<Null> showDetailDialog(SellerModel sellermodel) async {
    showDialog(
        context: context,
        builder: (context) {
          return GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              behavior: HitTestBehavior.opaque,
              child: StatefulBuilder(
                builder: (context, index) => SimpleDialog(
                  title: ListTile(
                    title: Center(
                        child:
                            Text('ข้อมูลผู้ขาย', style: MyStyle().mainH2Title)),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(
                            '${MyConstant().domain}/${sellermodel.image}'),
                        radius: 65,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'ชื่อ : ${sellermodel.name}  '
                        ' ${sellermodel.lastname} ',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'เพศ : ${sellermodel.gender}  ',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'อีเมล : ${sellermodel.email}  ',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'เลขบัตรประชาชน : ${sellermodel.idcard}  ',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'วันเกิด : ${sellermodel.birthday.day} /${sellermodel.birthday.month} /${sellermodel.birthday.year}  ',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: dropdownapprove(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            editSeller(sellermodel);
                          },
                          child: Text('ยืนยัน'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('ยกเลิก'),
                        ),
                      ],
                    ),
                  ],
                ),
              ));
        });
  }

  Row dropdownapprove() {
    return Row(
      children: [
        Text('อนุมัติผู้ขาย: '),
        DropdownButton<String>(
          value: _value,
          items: _dropdownItems.map((ListItem item) {
            return DropdownMenuItem<String>(
              value: item.status,
              child: Text(item.name),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              _value = value;
            });
          },
        ),
      ],
    );
  }
}
