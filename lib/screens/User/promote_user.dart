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

class PromoteUser extends StatefulWidget {
  const PromoteUser({required this.userModel, required this.productModel});
  final UserModel userModel;
  final ProductModel productModel;

  @override
  _PromoteUserState createState() => _PromoteUserState();
}

class _PromoteUserState extends State<PromoteUser> {
  UserModel? userModel;
  ProductModel? productModel;
  var f = NumberFormat.currency(locale: "THB", symbol: "฿");
  String? clickid;
  bool? loadStatus = true;
  bool? status = true;
  @override
  void initState() {
    super.initState();
    userModel = widget.userModel;
    productModel = widget.productModel;
    getProductRecs();
    //print(productModel!.idSubcategory);
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

  List<ProductModel> productRecList = [];
  Future<Null> getProductRecs() async {
    if (productRecList.length != 0) {
      loadStatus = true;
      status = true;
      productRecList.clear();
    }
    String? idsub = productModel!.idSubcategory;
    String api =
        '${MyConstant().domain}/api/getproductfromidsubCategory.php?isAdd=true&id_subcategory=$idsub';

    await Dio().get(api).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          ProductModel productRecLists2 = ProductModel.fromMap(item);
          setState(() {
            productRecList.add(productRecLists2);
            //print(productRecList);
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
          title: Center(child: Text('สินค้าแนะนำ')),
        ),
        body: RefreshIndicator(
          child: loadStatus!
              ? MyStyle().showProgress()
              : Stack(
                  children: [
                    Container(
                      child: ListView.builder(
                        itemCount: productRecList.length,
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

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      getProductRecs();
    });

    return null;
  }

  var refreshKey = GlobalKey<RefreshIndicatorState>();

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
                '${MyConstant().domain}/upload/product/${productRecList[index].image}'),
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
            productRecList[index].nameproduct,
            style: MyStyle().mainTitle,
          ),
        ),
      ],
    );
  }

  Widget showDetail(int index) {
    String string = productRecList[index].detail;
    if (string.length > 100) {
      string = string.substring(0, 99);
      string = '$string ...';
    }
    return Text(
      string,
      style: TextStyle(
        fontSize: 16,
        fontStyle: FontStyle.italic,
      ),
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
          // showDetail(index),
          Text(
            f.format(int.parse(productRecList[index].price)),
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
        clickid = productRecList[index].idProduct;
        addData();

        MaterialPageRoute route = MaterialPageRoute(
          builder: (value) => ShowDetail(
            productModel: productRecList[index],
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
