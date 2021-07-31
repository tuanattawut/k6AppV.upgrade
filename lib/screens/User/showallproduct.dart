import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/product_models.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';

class ProductAll extends StatefulWidget {
  @override
  _ProductAllState createState() => _ProductAllState();
}

class _ProductAllState extends State<ProductAll> {
  List<ProductModel> productModels = [];
  bool? loadStatus = true;
  bool? status = true;
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<Null> getData() async {
    if (productModels.length != 0) {
      loadStatus = true;
      status = true;
      productModels.clear();
    }

    String api = '${MyConstant().domain}/projectk6/getProduct.php';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('สินค้าทั้งหมด')),
      ),
      body: Stack(
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
    );
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
                '${MyConstant().domain}/${productModels[index].image}'),
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

  // Widget showDetail(int index) {
  //   String string = '_model.descriptions';
  //   if (string.length > 100) {
  //     string = string.substring(0, 99);
  //     string = '$string ...';
  //   }
  //   return Text(
  //     string,
  //     style: TextStyle(
  //       fontSize: 16,
  //       fontStyle: FontStyle.italic,
  //     ),
  //   );
  // }

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
            ' \฿ ${productModels[index].price}',
            style: Theme.of(context)
                .textTheme
                .button!
                .copyWith(color: Colors.red, fontSize: 20),
          )
        ],
      ),
    );
  }

  Widget showListView(int index) {
    return GestureDetector(
      onTap: () {
        print(index);
        // MaterialPageRoute route = MaterialPageRoute(
        //   builder: (value) => ShowDetail(productModel: ,),
        // );
        // Navigator.of(context).push(route);
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
