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
    getSearch();
  }

  bool? loadStatus = true;
  bool? status = true;

  LimitshopModel? shopLimit;
  List<LimitshopModel> shopLimitshow = [];
  Future<Null> getSearch() async {
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
            shopLimitshow.add(limitshopModel);
            shopLimit = limitshopModel;
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
      body: loadStatus!
          ? showContent()
          : Column(
              children: [
                Center(
                  child: Text(
                    'สินค้าประเภท ${shopLimit!.namesubcategory} มีจำนวน : ${shopLimitshow.length} ชิ้น',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
              ],
            ),
    );
  }

  Widget showContent() {
    return Center(
      child: Text(
        'ไม่มีการแจ้งเตือน ...',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
