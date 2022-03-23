import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:k6_app/models/clickdata_model.dart';
import 'package:k6_app/models/product_models.dart';
import 'package:k6_app/models/user_models.dart';
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

  Future<Null> addData(String clickid) async {
    String iduser = userModel!.idUser;
    String url =
        '${MyConstant().domain}/api/addactionClick.php?isAdd=true&id_user=$iduser&id_products=$clickid';
    try {
      Response response = await Dio().get(url);
      // print('res = $response');
      if (response.toString() == 'true') {
      } else {
        normalDialog(context, 'ผิดพลาดโปรดลองอีกครั้ง');
      }
    } catch (e) {
      ///
    }
  }

  ClickdataModel? clickdataModel;
  Future<Null> checkClickdata(String clickid) async {
    String iduser = userModel!.idUser;
    String url =
        '${MyConstant().domain}/api/checkDataclick.php?isAdd=true&id_user=$iduser&id_products=$clickid';
    await Dio().get(url).then((value) {
      // print(value.toString());
      if (value.toString() != 'null') {
        //  print('มีข้อมูล');
        for (var item in json.decode(value.data)) {
          clickdataModel = ClickdataModel.fromMap(item);
          //    print(clickdataModel!.view);
          var viewdataclick = int.parse((clickdataModel!.view.toString()));
          viewdataclick++;
          setState(() {
            updateViewClick(clickid, viewdataclick.toString());
          });
        }
      } else {
        //  print('NO DATA');
        addClickdata(clickid);
      }
    });
  }

  Future<Null> updateViewClick(String clickid, String view) async {
    String iduser = userModel!.idUser;
    String url =
        '${MyConstant().domain}/api/updateViewDataclick.php?isAdd=true&view=$view&id_user=$iduser&id_product=$clickid';
    try {
      Response response = await Dio().get(url);
      print('อัพเดท${response.toString()}');
    } catch (e) {
      ///
    }
  }

  Future<Null> addClickdata(String clickid) async {
    String iduser = userModel!.idUser;
    String url =
        '${MyConstant().domain}/api/addDataclick.php?isAdd=true&id_user=$iduser&id_product=$clickid';
    try {
      Response response = await Dio().get(url);
      print('อยู่นี่ ${response.toString()}');
    } catch (e) {
      ///
    }
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
                '${MyConstant().domain}/images/products_seller/${productModels[index].image}'),
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
            f.format(double.parse(productModels[index].price.toString())),
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
      onTap: () async {
        clickid = productModels[index].id.toString();
        var view = int.parse(productModels[index].view.toString());
        view++;
        String url =
            '${MyConstant().domain}/api/updateViewProduct.php?isAdd=true&view=$view&id=$clickid';
        await Dio().get(url).then((value) async {
          await addData(clickid.toString());
          await checkClickdata(clickid.toString());
          MaterialPageRoute route = MaterialPageRoute(
            builder: (value) => ShowDetail(
              productModel: productModels[index],
              userModel: userModel!,
            ),
          );
          Navigator.of(context).push(route).then((value) => getData());
        });
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
            showImage(index),
            showText(index),
          ],
        ),
      ),
    );
  }
}
