import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/shop_model.dart';
import 'package:k6_app/screens/Manager/detailshopsearch.dart';
import 'package:k6_app/utility/my_constant.dart';

class ShowsearchShop extends StatefulWidget {
  final String nameshop;
  const ShowsearchShop({required this.nameshop});

  @override
  _ShowsearchShopState createState() => _ShowsearchShopState();
}

class _ShowsearchShopState extends State<ShowsearchShop> {
  String? nameshop;
  bool? loadStatus = true;
  bool? status = true;
  @override
  void initState() {
    super.initState();
    nameshop = widget.nameshop;
    getSearch();
  }

  List<ShopModel> shopList = [];
  Future<Null> getSearch() async {
    if (shopList.length != 0) {
      loadStatus = true;
      status = true;
      shopList.clear();
    }
    String api =
        '${MyConstant().domain}/api/search_shop.php?isAdd=true&nameshop=$nameshop';

    await Dio().get(api).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          ShopModel shopModel = ShopModel.fromMap(item);
          setState(() {
            shopList.add(shopModel);
            print(shopList);
          });
          break;
        }
      } else {
        setState(() {
          status = false;
        });
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('ผลการค้นหา')),
      ),
      body: loadStatus!
          ? showContent()
          : Container(
              child: ListView.builder(
                  itemCount: shopList.length,
                  itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.all(8),
                        child: ListTile(
                          onTap: () {
                            MaterialPageRoute route = MaterialPageRoute(
                                builder: (value) => DetailshopSearch(
                                    shopModel: shopList[index]));
                            Navigator.of(context).push(route);
                          },
                          leading: Image.network(
                            '${MyConstant().domain}/upload/shop/${shopList[index].image}',
                            fit: BoxFit.cover,
                            width: 50,
                          ),
                          title: Text(
                            shopList[index].nameshop,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          trailing: Icon(
                            Icons.navigate_next,
                            size: 14,
                          ),
                        ),
                      )),
            ),
    );
  }

  Widget showContent() {
    return Center(
      child: Text(
        'ไม่พบการค้นหา ...',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
