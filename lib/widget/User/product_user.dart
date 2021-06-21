import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/product_models.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:k6_app/screens/User/show_detail.dart';
import 'package:k6_app/utility/my_constant.dart';
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
    String api = '${MyConstant().domain}/k6app/getProduct.php';
    await Dio().get(api).then((value) {
      for (var item in json.decode(value.data)) {
        ProductModel productModel = ProductModel.fromJson(item);
        setState(() {
          productModels.add(productModel);
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
      body: ListView(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MakeBanner(),
                MyStyle().mySizebox(),
                _buildSectiontitle('สินค้าทั้งหมด', () {
                  final snackbar = SnackBar(
                    content: Text("คลิก"),
                    action: SnackBarAction(
                      label: "ok",
                      onPressed: () {},
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                }),
                Column(
                  children: [
                    GridView.builder(
                        padding: EdgeInsets.all(6),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.75,
                          crossAxisCount: 2,
                          mainAxisSpacing: 6,
                          crossAxisSpacing: 6,
                        ),
                        itemCount: productModels.length,
                        itemBuilder: (BuildContext buildContext, int index) {
                          return showListView(index);
                        }),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget showListView(int index) {
    return Card(
      child: InkWell(
        onTap: () {
          MaterialPageRoute route = MaterialPageRoute(
            builder: (value) => ShowDetail(
              productModel: productModels[index],
            ),
          );
          Navigator.of(context).push(route);
        },
        child: GridTile(
            child: Image.network(
              '${MyConstant().domain}/${productModels[index].image}',
              fit: BoxFit.cover,
            ),
            footer: GridTileBar(
              title: Text(
                productModels[index].nameproduct,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              subtitle: Text(
                '${productModels[index].price} ฿',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                ),
              ),
              backgroundColor: Colors.white60,
            )),
      ),
    );
  }

  Widget _buildSectiontitle(String title, [Function onTap]) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          InkWell(
            onTap: onTap ?? () {},
            child: Text(
              'ดูทั้งหมด',
              style: new TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
