import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/seller_model.dart';
import 'package:k6_app/models/shop_model.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/widget/Seller/chat_seller.dart';
import 'package:k6_app/widget/Seller/infomation_shop.dart';
import 'package:k6_app/widget/Seller/product_list_seller.dart';
import 'package:k6_app/widget/Seller/rent_seller.dart';

class Homeseller extends StatefulWidget {
  Homeseller({this.sellerModel});
  final SellerModel sellerModel;
  @override
  _HomesellerState createState() => _HomesellerState();
}

class _HomesellerState extends State<Homeseller> {
  SellerModel sellerModel;
  String idseller;
  ShopModel shopModels;
  @override
  void initState() {
    super.initState();
    sellerModel = widget.sellerModel;
    readDataShop();
  }

  Future<Null> readDataShop() async {
    idseller = sellerModel.idSeller;

    String url =
        '${MyConstant().domain}/projectk6/getSellerwhereSHOP.php?isAdd=true&id_seller=$idseller';
    Response response = await Dio().get(url);

    var result = json.decode(response.data);
    print('result = $result');

    if (result != null) {
      for (var map in result) {
        setState(() {
          shopModels = ShopModel.fromJson(map);
        });
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("คุณ ${sellerModel.name} เข้าสู่ระบบ"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: GridView.count(
            crossAxisCount: 2,
            children: <Widget>[
              MyMenu(
                title: 'สินค้าของฉัน',
                icon: Icons.shopping_cart,
                color: Colors.blue,
                route: ProductListSeller(
                  shopModel: shopModels,
                ),
              ),
              MyMenu(
                  title: 'ข้อมูลร้านค้า',
                  icon: Icons.shop,
                  color: Colors.blue,
                  route: InformationShop(
                    sellerModel: sellerModel,
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
        ));
  }

  // Drawer showDrawer() => Drawer(
  //       child: Stack(
  //         children: <Widget>[
  //           Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: <Widget>[
  //               showHead(),
  //               productMenu(),
  //               infomationMenu(),
  //               rentMenu(),
  //               chatMenu(),
  //             ],
  //           ),
  //           Column(
  //             mainAxisAlignment: MainAxisAlignment.end,
  //             children: <Widget>[
  //               signOutMenu(),
  //             ],
  //           ),
  //         ],
  //       ),
  //     );

  // ListTile productMenu() => ListTile(
  //       leading: Icon(
  //         Icons.shopping_bag_outlined,
  //       ),
  //       title: Text('รายการสินค้า'),
  //       subtitle: Text('รายการสินค้าของร้าน'),
  //       onTap: () {
  //         setState(() {
  //           currentWidget = ProductListSeller();
  //         });
  //         Navigator.pop(context);
  //       },
  //     );

  // ListTile infomationMenu() => ListTile(
  //       leading: Icon(
  //         Icons.info_outline,
  //       ),
  //       title: Text('รายละเอียด ของผู้ขาย'),
  //       subtitle: Text('รายละเอียด ของผู้ขาย พร้อม แก้ไข'),
  //       onTap: () {
  //         setState(() {
  //           currentWidget = InformationSeller();
  //         });
  //         Navigator.pop(context);
  //       },
  //     );

  // ListTile rentMenu() => ListTile(
  //       leading: Icon(
  //         Icons.food_bank_outlined,
  //       ),
  //       title: Text('เช่า/จองพื้นที่'),
  //       subtitle: Text('เช่าหรือจองพื้นที่สำหรับขายสินค้า'),
  //       onTap: () {
  //         setState(() {
  //           currentWidget = RentSeller();
  //         });
  //         Navigator.pop(context);
  //       },
  //     );

  // ListTile chatMenu() => ListTile(
  //       leading: Icon(
  //         Icons.chat_bubble_outline,
  //       ),
  //       title: Text('แชท'),
  //       subtitle: Text('แชทกับผู้ซื้อ'),
  //       onTap: () {
  //         setState(() {
  //           currentWidget = ChatSeller();
  //         });
  //         Navigator.pop(context);
  //       },
  //     );

  // ListTile signOutMenu() => ListTile(
  //       leading: Icon(
  //         Icons.exit_to_app_outlined,
  //       ),
  //       title: Text('ออกจากระบบ'),
  //       subtitle: Text('ออกจากระบบ และ กลับไป หน้าแรก'),
  //       onTap: () {
  //         Navigator.pop(context);
  //       },
  //     );

  // UserAccountsDrawerHeader showHead() {
  //   return UserAccountsDrawerHeader(
  //     arrowColor: Colors.amber,
  //     currentAccountPicture: MyStyle().showLogo(),
  //     accountName: Text(sellerModel.name),
  //     accountEmail: Text('เข้าสู่ระบบ'),
  //   );
  // }
}

class MyMenu extends StatelessWidget {
  MyMenu({
    this.title,
    this.icon,
    this.color,
    this.route,
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
                size: 70,
                color: color,
              ),
              Text(title, style: TextStyle(fontSize: 20.0)),
            ],
          ),
        ),
      ),
    );
  }
}
