import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/category_model.dart';
import 'package:k6_app/models/product_models.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';

class DetailProduct extends StatefulWidget {
  final ProductModel productModel;
  const DetailProduct({required this.productModel});

  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  ProductModel? productModel;
  List<ProductModel> productModels = [];
  bool? loadStatus = true;
  bool? status = true;
  String? name, id, idshop;
  CategoryModel? category;
  @override
  void initState() {
    super.initState();
    setState(() {
      productModel = widget.productModel;
      // print('มั่วไหม ==> ${productModel?.idCategory}');
      readProduct();
      getCategory();
    });
  }

  Future<Null> readProduct() async {
    if (productModels.length != 0) {
      loadStatus = true;
      status = true;
      productModels.clear();
    }

    idshop = productModel?.idShop;

    String url =
        '${MyConstant().domain}/projectk6/getproductWhereidShop.php?isAdd=true&id_shop=$idshop';
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

  Future<Null> getCategory() async {
    String idcategory = productModel!.idCategory;
    String api =
        '${MyConstant().domain}/projectk6/getCategoryWhereid.php?isAdd=true&id_category=$idcategory';

    await Dio().get(api).then((value) {
      print(value);
      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          CategoryModel categoryModel = CategoryModel.fromMap(item);
          setState(() {
            category = categoryModel;
          });
        }
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: productModel == null
          ? MyStyle().showProgress()
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    showDetailProduct(),
                    MyStyle().mySizebox(),
                    _buildSectiontitle('สินค้าจากร้านเดียวกัน', () {}),
                    SizedBox(
                      height: 250,
                      child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: productModels.length,
                        itemBuilder: (BuildContext context, int index) =>
                            showListView(index),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget showImage() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Image.network(
          '${MyConstant().domain}/${productModel?.image}',
          fit: BoxFit.contain,
        ));
  }

  Widget showDetailProduct() => Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            showImage(),
            MyStyle().mySizebox(),
            Text(
              productModel!.nameproduct,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(25),
                  child: Text(
                    ' \฿${productModel?.price}',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            MyStyle().mySizebox(),
            Row(
              children: [
                MyStyle().showTitleH2('ประเภทสินค้า:  '),
                category == null
                    ? Text('.. .')
                    : Text(
                        category!.namecategory as String,
                        style: Theme.of(context)
                            .textTheme
                            .button!
                            .copyWith(color: Colors.black, fontSize: 16),
                      ),
              ],
            ),
            MyStyle().mySizebox(),
            Row(
              children: [
                MyStyle().showTitleH2('รายละเอียด: '),
              ],
            ),
            Text(
              productModel!.detail,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ]));

  Widget showListView(int index) {
    String string = '${productModels[index].nameproduct}';
    if (string.length > 10) {
      string = string.substring(0, 10);
      string = '$string ...';
    }
    return Container(
        margin: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
          bottom: 10,
        ),
        child: GestureDetector(
            onTap: () {
              name = productModels[index].nameproduct;
              id = productModels[index].idProduct;
              print(name);
              // MaterialPageRoute route = MaterialPageRoute(
              //   builder: (value) => ShowDetail(
              //     productModel: productModels[index],
              //   ),
              // );
              // Navigator.of(context).push(route);
              // dataId.add(id);
              // dataName.add(name);

              // if (dataName.length < 4) {
              //   print(dataName);
              //   if (dataName.length == 3) {
              //     addData();
              //     print(dataId);
              //   }
              // } else {
              //   dataName.clear();
              //   dataId.clear();
              // }
            },
            child: Column(children: <Widget>[
              Container(
                height: 150,
                width: 150,
                child: Image.network(
                  '${MyConstant().domain}/${productModels[index].image}',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        string,
                        style: Theme.of(context)
                            .textTheme
                            .button!
                            .copyWith(color: Colors.black, fontSize: 20),
                      ),
                      Text(
                        ' \฿ ${productModel!.price}',
                        style: Theme.of(context)
                            .textTheme
                            .button!
                            .copyWith(color: Colors.red, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              )
            ])));
  }
}

Widget _buildSectiontitle(String title, [Function()? onTap]) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        InkWell(
          onTap: onTap,
          child: Row(
            children: [
              Text('ดูเพิ่มเติม'),
              Icon(
                Icons.keyboard_arrow_right,
                color: Colors.blue,
                size: 30,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
