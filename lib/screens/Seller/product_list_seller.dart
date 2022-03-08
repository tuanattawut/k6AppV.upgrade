import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:k6_app/models/product_models.dart';
import 'package:k6_app/models/seller_model.dart';
import 'package:k6_app/models/shop_model.dart';
import 'package:k6_app/screens/Seller/add_product_seller.dart';
import 'package:k6_app/screens/Seller/edit_product_seller.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';

class ProductListSeller extends StatefulWidget {
  ProductListSeller({required this.shopModel});
  final ShopModel shopModel;
  @override
  _ProductListSellerState createState() => _ProductListSellerState();
}

class _ProductListSellerState extends State<ProductListSeller> {
  List<ProductModel> productModels = [];
  ShopModel? shopModel;
  bool? loadStatus = true;
  bool? status = true;
  SellerModel? sellerModel;
  String? idshop, idseller;
  var f = NumberFormat.currency(locale: "THB", symbol: "฿");
  @override
  void initState() {
    super.initState();
    shopModel = widget.shopModel;
    readProduct();
  }

  Future<Null> readProduct() async {
    if (productModels.length != 0) {
      loadStatus = true;
      status = true;
      productModels.clear();
    }

    idshop = shopModel?.id;

    String url =
        '${MyConstant().domain}/api/getproductIdShop.php?isAdd=true&id_shop=$idshop';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });

      if (value.toString() != 'null') {
        // print('value ==>> $value');

        var result = json.decode(value.data);
        //  print('result ==>> $result');

        for (var map in result) {
          ProductModel productModel = ProductModel.fromMap(map);
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

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      readProduct();
    });

    return null;
  }

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('สินค้าของฉัน'),
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
              'ยังไม่มีสินค้า',
              style: TextStyle(fontSize: 18),
            ),
          );
  }

  Widget addProductButton() => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 40, right: 20),
                child: FloatingActionButton(
                  onPressed: () {
                    MaterialPageRoute route = MaterialPageRoute(
                      builder: (context) => AddProduct(
                        shopModel: shopModel!,
                      ),
                    );
                    Navigator.push(context, route)
                        .then((value) => {Navigator.pop(context)});
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
        ],
      );

  Widget showListFood() => ListView.builder(
      itemCount: productModels.length,
      itemBuilder: (context, index) => Card(
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.4,
                  child: Image.network(
                    '${MyConstant().domain}/images/products_seller/${productModels[index].image}',
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
                          '${productModels[index].nameproduct}',
                          style: MyStyle().mainTitle,
                        ),
                        Text(
                          f.format(double.parse(
                              productModels[index].price.toString())),
                          style: Theme.of(context)
                              .textTheme
                              .button!
                              .copyWith(color: Colors.red, fontSize: 18),
                        ),
                        Text(
                          productModels[index].detail.toString(),
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
                              onPressed: () {
                                MaterialPageRoute route = MaterialPageRoute(
                                  builder: (value) => EditProduct(
                                    productModel: productModels[index],
                                  ),
                                );
                                Navigator.of(context).push(route);
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () =>
                                  deleteproduct(productModels[index]),
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

  Future<Null> deleteproduct(ProductModel productModel) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title:
            MyStyle().showTitleH2('คุณต้องการลบ ${productModel.nameproduct} ?'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  String url =
                      '${MyConstant().domain}/api/deletefromIdproduct.php?isAdd=true&id_products=${productModel.id}';
                  await Dio().get(url).then((value) => readProduct());
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
