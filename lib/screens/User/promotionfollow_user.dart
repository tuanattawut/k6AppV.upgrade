import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/promotionseller_model.dart';
import 'package:k6_app/models/user_models.dart';
import 'package:k6_app/screens/User/detailpromotion_user.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';

class PromotionFollow extends StatefulWidget {
  PromotionFollow({required this.userModel});
  final UserModel userModel;
  @override
  _PromotionFollowState createState() => _PromotionFollowState();
}

class _PromotionFollowState extends State<PromotionFollow> {
  bool? loadStatus = true;
  bool? status = true;

  List<PromotionsellerModel> promotionlist = [];
  UserModel? userModel;
  String? idUser;
  @override
  void initState() {
    super.initState();
    readPromotion();
    userModel = widget.userModel;
    idUser = userModel!.idUser;
  }

  Future<Null> readPromotion() async {
    if (promotionlist.length != 0) {
      loadStatus = true;
      status = true;
      promotionlist.clear();
    }

    String url =
        '${MyConstant().domain}/api/getPromotionfollow.php?isAdd=true&id_user=$idUser';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });

      if (value.toString() != 'null') {
        // print('value ==>> $value');

        var result = json.decode(value.data);
        //  print('result ==>> $result');

        for (var map in result) {
          PromotionsellerModel promotionsellerModel =
              PromotionsellerModel.fromMap(map);
          setState(() {
            if (promotionsellerModel.status == 'yes') {
              promotionlist.add(promotionsellerModel);
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
          title: Center(child: Text('โปรโมชั่นจากร้านค้า')),
        ),
        body: RefreshIndicator(
          child: loadStatus! ? MyStyle().showProgress() : showContent(),
          onRefresh: refreshList,
        ));
  }

  Widget showContent() {
    return status!
        ? showApprove()
        : Center(
            child: Text(
              'ไม่มีแจ้งเตือนขณะนี้',
              style: TextStyle(fontSize: 18),
            ),
          );
  }

  Widget showApprove() => Container(
      child: ListView.builder(
          itemCount: promotionlist.length,
          itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.all(8),
                child: ListTile(
                  onTap: () {
                    MaterialPageRoute route = MaterialPageRoute(
                        builder: (value) => DetailPromotionseller(
                            promotionsellerModel: promotionlist[index]));
                    Navigator.of(context).push(route);
                  },
                  leading: Image.network(
                    '${MyConstant().domain}/upload/promotion/${promotionlist[index].image}',
                    fit: BoxFit.cover,
                    width: 50,
                  ),
                  title: Text(
                    promotionlist[index].detailpromotion.toString(),
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                  ),
                ),
              )));
}
