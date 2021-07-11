import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/product_models.dart';
import 'package:k6_app/models/seller_model.dart';
import 'package:k6_app/screens/Seller/add_product_seller.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';

class ProductListSeller extends StatefulWidget {
  ProductListSeller({this.sellerModel});
  final SellerModel sellerModel;
  @override
  _ProductListSellerState createState() => _ProductListSellerState();
}

class _ProductListSellerState extends State<ProductListSeller> {
  List<ProductModel> productModels = [];
  bool loadStatus = true; //  โหลดจากเจซัน
  bool status = true; // มีข้อมูล

  String idseller; // id คนขาย
  @override
  void initState() {
    super.initState();
  }

  Future<Null> readProduct() async {
    if (productModels.length != 0) {
      loadStatus = true;
      status = true;
      productModels.clear();
    }
    String url =
        '${MyConstant().domain}/projectk6/getproductWhereidShop.php?isAdd=true&id_seller=$idseller';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });

      if (value.toString() != 'null') {
        // print('value ==>> $value');

        var result = json.decode(value.data);
        // print('result ==>> $result');

        for (var map in result) {
          ProductModel productModel = ProductModel.fromJson(map);
          setState(() {
            productModels.add(productModel);
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
          title: Text('สินค้าของคุณ'),
        ),
        body: Stack(
          children: <Widget>[
            showListFood(),
            addProductButton(),
          ],
        ));
  }

  Widget addProductButton() => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 40, right: 20),
                child: FloatingActionButton(
                  onPressed: () {
                    MaterialPageRoute route = MaterialPageRoute(
                      builder: (context) => AddProduct(),
                    );
                    Navigator.push(context, route).then((value) => {});
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
        ],
      );

  Widget showListFood() => ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) => Card(
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.4,
                  child: Image.network(
                    '${image[index]}',
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
                          'สินค้า ${data[index]}',
                          style: MyStyle().mainTitle,
                        ),
                        Text(
                          ' 99999 - 99999 บาท',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'รายละเอียด รายละเอียด รายละเอียด รายละเอียด ..  ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.green,
                              ),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () => {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ));

  final List<String> data = <String>['1', '2'];
  final List<String> image = <String>[
    'https://food.mthai.com/app/uploads/2017/09/Grilled-Pork-Sticks.jpg',
    'https://th.louisvuitton.com/images/is/image/lv/1/PP_VP_L/%E0%B8%AB%E0%B8%A5%E0%B8%B8%E0%B8%A2%E0%B8%AA%E0%B9%8C-%E0%B8%A7%E0%B8%B4%E0%B8%95%E0%B8%95%E0%B8%AD%E0%B8%87-%E0%B8%81%E0%B8%A3%E0%B8%B0%E0%B9%80%E0%B8%9B%E0%B9%8B%E0%B8%B2%E0%B8%A3%E0%B8%B8%E0%B9%88%E0%B8%99-multi-pochette-accessoires-monogram-%E0%B8%81%E0%B8%A3%E0%B8%B0%E0%B9%80%E0%B8%9B%E0%B9%8B%E0%B8%B2%E0%B8%96%E0%B8%B7%E0%B8%AD--M44813_PM1_Side%20view.jpg',
    'https://i.ytimg.com/vi/WZVGW5DiYlY/maxresdefault.jpg',
    'https://www.greenery.org/wp-content/uploads/2018/10/PC-01.jpg',
  ];
}
