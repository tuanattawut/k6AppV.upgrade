import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/category_model.dart';
import 'package:k6_app/models/product_models.dart';
import 'package:k6_app/models/seller_model.dart';
import 'package:k6_app/models/shop_model.dart';
import 'package:k6_app/models/user_models.dart';
import 'package:k6_app/utility/my_constant.dart';

class ManageReport extends StatefulWidget {
  @override
  _ManageReportState createState() => _ManageReportState();
}

class _ManageReportState extends State<ManageReport> {
  List<ProductModel> productModels = [];
  List<SellerModel> sellerModels = [];
  List<ShopModel> shopModels = [];
  List<CategoryModel> categoryModels = [];
  List<UserModel> userModels = [];
  @override
  void initState() {
    super.initState();
    getUser();
    getData();
    getSeller();
    getShop();
    getCategory();
  }

  Future<Null> getUser() async {
    String api = '${MyConstant().domain}/api/getUser.php';

    await Dio().get(api).then((value) {
      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          UserModel userModel = UserModel.fromMap(item);
          setState(() {
            userModels.add(userModel);
          });
        }
      }
    });
  }

  Future<Null> getData() async {
    String api = '${MyConstant().domain}/api/getProduct.php';

    await Dio().get(api).then((value) {
      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          ProductModel productModel = ProductModel.fromMap(item);
          setState(() {
            productModels.add(productModel);
          });
        }
      }
    });
  }

  Future<Null> getSeller() async {
    String api = '${MyConstant().domain}/api/getSeller.php';

    await Dio().get(api).then((value) {
      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          SellerModel sellerModel = SellerModel.fromMap(item);
          setState(() {
            sellerModels.add(sellerModel);
          });
        }
      }
    });
  }

  Future<Null> getShop() async {
    String api = '${MyConstant().domain}/api/getShop.php';

    await Dio().get(api).then((value) {
      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          ShopModel shopModel = ShopModel.fromMap(item);
          setState(() {
            shopModels.add(shopModel);
          });
        }
      }
    });
  }

  Future<Null> getCategory() async {
    String api = '${MyConstant().domain}/api/getCategory.php';

    await Dio().get(api).then((value) {
      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          CategoryModel categoryModel = CategoryModel.fromMap(item);
          setState(() {
            categoryModels.add(categoryModel);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายงานผู้ใช้งาน'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 25),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                          child: Card(
                              child: _buildGender(
                                  Icons.people,
                                  Colors.blue,
                                  "จำนวนผู้ใช้งานในระบบ",
                                  '${userModels.length} คน ')),
                          onTap: () {
                            print('ddddd');
                          }),
                      Card(
                          child: _buildGender(
                              Icons.shopping_bag,
                              Colors.blue,
                              "จำนวนสินค้าในระบบ",
                              '${productModels.length} ชิ้น')),
                      Card(
                          child: _buildGender(
                              Icons.people,
                              Colors.blue,
                              "จำนวนผู้ขายในระบบ",
                              '${sellerModels.length} คน')),
                      Card(
                          child: _buildGender(
                              Icons.storefront,
                              Colors.blue,
                              "จำนวนร้านค้าในระบบ",
                              '${shopModels.length} ร้าน')),
                      Card(
                          child: _buildGender(
                              Icons.category,
                              Colors.blue,
                              "จำนวนประเภทสินค้า \nในระบบ",
                              "${categoryModels.length} ประเภท")),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGender(IconData icon, Color color, String title, String value) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        border: Border.all(color: Colors.white),
      ),
      padding: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                icon,
                size: 60,
                color: color,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 24,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '$value',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
        ],
      ),
    );
  }
}
