import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/seller_model.dart';
import 'package:k6_app/models/shop_model.dart';
import 'package:k6_app/screens/Seller/add_info_seller.dart';
import 'package:k6_app/screens/Seller/add_product_seller.dart';
import 'package:k6_app/screens/Seller/infomation_shop.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';
import 'package:k6_app/widget/Seller/chat_seller.dart';

import 'package:k6_app/screens/Seller/product_list_seller.dart';
import 'package:k6_app/widget/Seller/rent_seller.dart';

class Homeseller extends StatefulWidget {
  Homeseller({required this.sellerModel});
  final SellerModel sellerModel;
  @override
  _HomesellerState createState() => _HomesellerState();
}

class _HomesellerState extends State<Homeseller> {
  SellerModel? sellerModel;
  String? idseller;
  ShopModel? shopModels;
  @override
  void initState() {
    super.initState();
    sellerModel = widget.sellerModel;
    readDataShop();
  }

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<Null> readDataShop() async {
    idseller = sellerModel?.idSeller;
    String url =
        '${MyConstant().domain}/projectk6/getSellerwhereSHOP.php?isAdd=true&id_seller=$idseller';
    Response response = await Dio().get(url);

    var result = json.decode(response.data);
    print('result = $result');

    if (result != null) {
      for (var map in result) {
        setState(() {
          shopModels = ShopModel.fromMap(map);
        });
      }
    } else {
      routeToAddInfo();
    }
  }

  void routeToAddInfo() {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => AddInfoShop(
        sellerModel: sellerModel!,
      ),
    );
    Navigator.of(context).push(route).then((value) => setState(() => {
          readDataShop(),
        }));
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      readDataShop();
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("คุณ ${sellerModel?.name} เข้าสู่ระบบ"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
        body: RefreshIndicator(
          child: shopModels == null
              ? MyStyle().showProgress()
              : Container(
                  padding: EdgeInsets.all(20),
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: <Widget>[
                      MyMenu(
                        title: 'เพิ่มสินค้า',
                        icon: Icons.add,
                        color: Colors.blue,
                        route: AddProduct(
                          shopModel: shopModels!,
                        ),
                      ),
                      MyMenu(
                        title: 'สินค้าของฉัน',
                        icon: Icons.shopping_cart,
                        color: Colors.blue,
                        route: ProductListSeller(
                          shopModel: shopModels!,
                        ),
                      ),
                      MyMenu(
                          title: 'ข้อมูลร้านค้า',
                          icon: Icons.shop,
                          color: Colors.blue,
                          route: InformationShop(
                            sellerModel: sellerModel!,
                          )),
                      MyMenu(
                          title: 'เช่าแผงร้านค้า',
                          icon: Icons.maps_home_work_outlined,
                          color: Colors.blue,
                          route: RentSeller()),
                      MyMenu(
                          title: 'แชท',
                          icon: Icons.chat,
                          color: Colors.blue,
                          route: ChatSeller()),
                    ],
                  ),
                ),
          onRefresh: refreshList,
        ));
  }
}

class MyMenu extends StatelessWidget {
  MyMenu({
    required this.title,
    required this.icon,
    required this.color,
    required this.route,
  });

  final String title;
  final IconData icon;
  final MaterialColor color;
  final route;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => route),
          );
        },
        splashColor: Colors.deepPurple,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                icon,
                size: 50,
                color: color,
              ),
              Text(title, style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
