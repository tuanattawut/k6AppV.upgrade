import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:k6_app/models/product_models.dart';
import 'package:k6_app/models/user_models.dart';
import 'package:k6_app/screens/User/main_user.dart';
import 'package:k6_app/screens/User/show_detail.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';
import 'package:k6_app/utility/normal_dialog.dart';
import 'package:k6_app/screens/User/showsearch.dart';

class ProductAll extends StatefulWidget {
  const ProductAll({required this.userModel});
  final UserModel userModel;

  @override
  _ProductAllState createState() => _ProductAllState();
}

class _ProductAllState extends State<ProductAll> {
  UserModel? userModel;
  List<ProductModel> productModels = [];
  bool? loadStatus = true;
  bool? status = true;
  var f = NumberFormat.currency(locale: "THB", symbol: "฿");
  String? clickid;
  @override
  void initState() {
    super.initState();
    userModel = widget.userModel;
    getData();
  }

  Future<Null> getData() async {
    if (productModels.length != 0) {
      loadStatus = true;
      status = true;
      productModels.clear();
    }

    String api = '${MyConstant().domain}/api/getProduct.php';

    await Dio().get(api).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          ProductModel productModel = ProductModel.fromMap(item);
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

  Future<Null> addData() async {
    String iduser = userModel!.idUser;
    String url =
        '${MyConstant().domain}/api/addClick.php?isAdd=true&id_user=$iduser&id_products=$clickid';
    try {
      Response response = await Dio().get(url);
      // print('res = $response');
      if (response.toString() == 'true') {
      } else {
        normalDialog(context, 'ผิดพลาดโปรดลองอีกครั้ง');
      }
    } catch (e) {}
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      getData();
    });

    return null;
  }

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('สินค้าทั้งหมด')),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (value) => ShowSearch(
                    userModel: userModel!,
                  ),
                );
                Navigator.of(context).push(route);
              },
            )
          ],
          centerTitle: true,
        ),
        body: RefreshIndicator(
          child: Stack(
            children: [
              loadStatus!
                  ? MyStyle().showProgress()
                  : Container(
                      child: ListView.builder(
                        itemCount: productModels.length,
                        itemBuilder: (BuildContext buildContext, int index) {
                          return showListView(index);
                        },
                      ),
                    ),
            ],
          ),
          onRefresh: refreshList,
        ));
  }

  Widget showImage(int index) {
    return Container(
      padding: EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          image: DecorationImage(
            image: NetworkImage(
                '${MyConstant().domain}/upload/product/${productModels[index].image}'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget showName(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.5 - 35,
          child: Text(
            ' ${productModels[index].nameproduct}',
            style: Theme.of(context)
                .textTheme
                .button!
                .copyWith(color: Colors.black, fontSize: 20),
          ),
        ),
      ],
    );
  }

  Widget showText(int index) {
    return Container(
      padding: EdgeInsets.only(right: 20.0),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          showName(index),
          Text(
            f.format(int.parse(productModels[index].price)),
            style: Theme.of(context)
                .textTheme
                .button!
                .copyWith(color: Colors.red, fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget showListView(int index) {
    return GestureDetector(
      onTap: () {
        clickid = productModels[index].idProduct;
        addData();
        MaterialPageRoute route = MaterialPageRoute(
          builder: (value) => ShowDetail(
            productModel: productModels[index],
            userModel: userModel!,
          ),
        );
        Navigator.of(context).push(route);
      },
      child: Container(
        margin: EdgeInsets.only(
          top: 5,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 50,
              color: Colors.grey.withOpacity(0.23),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            showText(index),
            showImage(index),
          ],
        ),
      ),
    );
  }
}
