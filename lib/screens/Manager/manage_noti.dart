import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/promotion_model.dart';
import 'package:k6_app/screens/Manager/edit_promotion_manager.dart';
import 'package:k6_app/utility/my_constant.dart';

class ManagePromotion extends StatefulWidget {
  @override
  _ManagePromotionState createState() => _ManagePromotionState();
}

class _ManagePromotionState extends State<ManagePromotion> {
  @override
  void initState() {
    super.initState();
    getPromotion();
  }

  List<PromotionModel> promotionList = [];
  Future<Null> getPromotion() async {
    String api = '${MyConstant().domain}/api/getPromotion.php';

    await Dio().get(api).then((value) {
      //print(value);
      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          PromotionModel promotionModel = PromotionModel.fromMap(item);
          setState(() {
            promotionList.add(promotionModel);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขข่าวสารโปรโมชั่น'),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: promotionList.length,
            itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.all(8),
                  child: ListTile(
                    onTap: () {
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (value) => EditPromotion(
                                promotionModel: promotionList[index],
                              ));
                      Navigator.of(context).push(route);
                    },
                    leading: Image.network(
                      '${MyConstant().domain}/upload/promotion/${promotionList[index].imgUrl}',
                      fit: BoxFit.cover,
                      width: 50,
                    ),
                    title: Text(
                      'ประกาศข่าวสาร ${index + 1}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    trailing: Icon(
                      Icons.mode_edit,
                      size: 16,
                    ),
                  ),
                )),
      ),
    );
  }
}
