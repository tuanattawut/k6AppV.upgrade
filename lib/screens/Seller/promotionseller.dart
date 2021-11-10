import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/promotionseller_model.dart';
import 'package:k6_app/models/seller_model.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';

class PromotionSeller extends StatefulWidget {
  PromotionSeller({required this.sellerModel});
  final SellerModel sellerModel;

  @override
  _PromotionSellerState createState() => _PromotionSellerState();
}

class _PromotionSellerState extends State<PromotionSeller> {
  SellerModel? sellerModel;
  String? idSeller;
  @override
  void initState() {
    super.initState();
    sellerModel = widget.sellerModel;
    idSeller = sellerModel!.idSeller;
    readPromotion();
  }

  bool? loadStatus = true;
  bool? status = true;
  List<PromotionsellerModel> promotionlist = [];

  Future<Null> readPromotion() async {
    if (promotionlist.length != 0) {
      loadStatus = true;
      status = true;
      promotionlist.clear();
    }

    String url =
        '${MyConstant().domain}/api/getPromotionSeller.php?isAdd=true&id_seller=$idSeller';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });

      if (value.toString() != 'null') {
        // print('value ==>> $value');

        var result = json.decode(value.data);
        //  print('result ==>> $result');

        for (var map in result) {
          PromotionsellerModel promotionSellerModel =
              PromotionsellerModel.fromMap(map);
          setState(() {
            promotionlist.add(promotionSellerModel);
          });
        }
      } else {
        setState(() {
          status = false;
        });
      }
    });
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      readPromotion();
    });

    return null;
  }

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('โปรโมชั่นทั้งหมด'),
        ),
        body: RefreshIndicator(
          child: Stack(
            children: <Widget>[
              loadStatus! ? MyStyle().showProgress() : showContent(),
            ],
          ),
          onRefresh: refreshList,
        ));
  }

  Widget showContent() {
    return status!
        ? showListFood()
        : Center(
            child: Text(
              'ยังไม่ได้ลงโปรโมชั่น',
              style: TextStyle(fontSize: 18),
            ),
          );
  }

  Widget showListFood() => ListView.builder(
      itemCount: promotionlist.length,
      itemBuilder: (context, index) => Card(
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.4,
                  child: Image.network(
                    '${MyConstant().domain}/upload/promotion/${promotionlist[index].image}',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.width * 0.4,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '${promotionlist[index].detailpromotion}',
                          style: MyStyle().mainTitle,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () => deleteproduct(promotionlist[index]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ));

  Future<Null> deleteproduct(PromotionsellerModel promotionsellerModel) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: MyStyle().showTitleH2('คุณต้องการลบ?'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                child: Text('ยืนยัน'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('ยกเลิก'),
              )
            ],
          )
        ],
      ),
    );
  }
}
