import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/product_models.dart';
import 'package:k6_app/screens/User/show_detail.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:k6_app/utility/my_style.dart';
import 'package:k6_app/widget/User/banner.dart';

class ProductListUser extends StatefulWidget {
  @override
  _ProductListUserState createState() => _ProductListUserState();
}

class _ProductListUserState extends State<ProductListUser> {
  List<ProductModel> productModels = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<Null> getData() async {
    String api = 'https://956cb6dd125b.jp.ngrok.io/k6app/getProduct.php';
    await Dio().get(api).then((value) {
      for (var item in json.decode(value.data)) {
        ProductModel model = ProductModel.fromJson(item);
        setState(() {
          productModels.add(model);
        });
      }
    });
  }

  SearchBar searchBar;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        title: Center(child: Text('หน้าหลัก')),
        actions: [searchBar.getSearchAction(context)]);
  }

  void onSubmitted(String value) {
    setState(() => ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('คุณพิมพ์ว่า $value'))));
  }

  _ProductListUserState() {
    searchBar = SearchBar(
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted,
        onCleared: () {
          print("เครีย");
        },
        onClosed: () {
          print("ปิด");
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar.build(context),
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10, left: 10),
              child: Row(
                children: [
                  Text('โปรโมชั่น', style: MyStyle().mainTitle),
                ],
              ),
            ),
            MakeBanner(),
            MyStyle().mySizebox(),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text('สินค้าทั้งหมด', style: MyStyle().mainTitle),
                ],
              ),
            ),
            MyStyle().mySizebox(),
            productModels.length == 0
                ? MyStyle().showProgress()
                : GridView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: (3 / 2),
                    ),
                    itemCount: productModels.length,
                    itemBuilder: (BuildContext buildContext, int index) {
                      return showListView(index);
                    }),
          ],
        ),
      ),
    );
  }

  Widget showListView(int index) {
    return GestureDetector(
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(
          builder: (value) => ShowDetail(),
        );
        Navigator.of(context).push(route);
      },
      child: GridTile(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Image.network(
              'http://956cb6dd125b.jp.ngrok.io/${productModels[index].image}'),
        ),
        footer: GridTileBar(
          title: Text(
            productModels[index].nameproduct,
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            '${productModels[index].price} ฿',
            style: TextStyle(
              color: Colors.red,
              fontSize: 18,
            ),
          ),
          backgroundColor: Colors.white60,
        ),
      ),
    );
  }
}
