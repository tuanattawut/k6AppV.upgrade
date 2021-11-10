import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/limitshop_model.dart';
import 'package:k6_app/utility/my_constant.dart';

class ShowNotimanager extends StatefulWidget {
  @override
  _ShowNotimanagerState createState() => _ShowNotimanagerState();
}

class _ShowNotimanagerState extends State<ShowNotimanager> {
  @override
  void initState() {
    super.initState();
    getNoti();
  }

  bool? loadStatus = true;
  bool? status = true;

  List<LimitshopModel> shopLimitshow = [];
  Future<Null> getNoti() async {
    if (shopLimitshow.length != 0) {
      loadStatus = true;
      status = true;
      shopLimitshow.clear();
    }
    String api = '${MyConstant().domain}/api/getProductLimit.php';

    await Dio().get(api).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          LimitshopModel limitshopModel = LimitshopModel.fromMap(item);
          setState(() {
            if (int.parse(limitshopModel.number.toString()) > 10) {
              shopLimitshow.add(limitshopModel);
              print(shopLimitshow);
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
      appBar: AppBar(
        title: Center(child: Text('การแจ้งเตือน')),
      ),
      body: loadStatus! ? showContent() : shownoti(),
    );
  }

  Widget showContent() {
    return status!
        ? shownoti()
        : Center(
            child: Text(
              'ไม่มีการแจ้งเตือน ...',
              style: TextStyle(fontSize: 18),
            ),
          );
  }

  Widget shownoti() => ListView.builder(
      itemCount: shopLimitshow.length,
      itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.all(8),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 150,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'แจ้งเตือน!!! ประเภทสินค้าชนิดเดียวกัน',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      Row(
                        children: [
                          Text(
                            'สินค้าประเภท: ${shopLimitshow[index].namesubcategory}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'มีจำนวน: ${shopLimitshow[index].number}  ชิ้น',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('โปรดตรวจสอบ!!!',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.red)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ));
}
