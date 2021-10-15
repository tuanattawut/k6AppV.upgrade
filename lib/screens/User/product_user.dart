import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/category_model.dart';
import 'package:k6_app/models/product_models.dart';
import 'package:k6_app/models/user_models.dart';
import 'package:k6_app/screens/User/promote_user.dart';
import 'package:k6_app/screens/User/show_detail.dart';
import 'package:k6_app/screens/User/showallcategory.dart';
import 'package:k6_app/screens/User/showallproduct.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';
import 'package:k6_app/utility/normal_dialog.dart';
import 'package:k6_app/widget/User/banner.dart';
import 'package:k6_app/widget/User/categoryproduct.dart';
import 'package:k6_app/widget/User/showsearch.dart';

class ProductListUser extends StatefulWidget {
  ProductListUser({required this.usermodel});
  final UserModel usermodel;
  @override
  _ProductListUserState createState() => _ProductListUserState();
}

class _ProductListUserState extends State<ProductListUser> {
  List<ProductModel> productModels = [];
  UserModel? userModel;
  bool? loadStatus = true;
  bool? status = true;
  bool? loadC = true;
  String? name, id, idproducts;
  List dataId = [];
  List dataName = [];
  List idproduct = [];
  List<ProductModel> recentlyModels = [];

  List<CategoryModel> categoryList = [];

  @override
  void initState() {
    super.initState();
    userModel = widget.usermodel;
    getData();
    // getRecently();
    getCategory();
  }

//เรียกข้อมูลสินค้าทั้งหมด
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

//เพิ่มข้อมูลการคลิก
  // Future<Null> addData() async {
  //   String iduser = userModel!.idUser;

  //   String url =
  //       '${MyConstant().domain}/api/addData.php?isAdd=true&id_user=$iduser&id_product=$dataId&nameproduct=$dataName';

  //   try {
  //     Response response = await Dio().get(url);
  //     // print('res = $response');

  //     if (response.toString() == 'true') {
  //     } else {
  //       normalDialog(context, 'ผิดพลาดโปรดลองอีกครั้ง');
  //     }
  //   } catch (e) {}
  // }

//เก็บข้อมูลการกดเข้าดู
  // Future<Null> addRecently() async {
  //   String iduser = userModel!.idUser;

  //   String url =
  //       '${MyConstant().domain}/api/addRecently.php?isAdd=true&id_user=$iduser&id_product=$id';

  //   try {
  //     Response response = await Dio().get(url);
  //     // print('res = $response');

  //     if (response.toString() == 'true') {
  //     } else {
  //       normalDialog(context, 'ผิดพลาดโปรดลองอีกครั้ง');
  //     }
  //   } catch (e) {}
  // }

//เรียกข้อมูลการดูล่าสุด
  // Future<Null> getRecently() async {
  //   String iduser = userModel!.idUser;
  //   String api =
  //       '${MyConstant().domain}/api/getDataRecently.php?isAdd=true&id_user=$iduser';

  //   await Dio().get(api).then((value) {
  //     if (value.toString() != 'null') {
  //       for (var item in json.decode(value.data)) {
  //         idproduct.add(item);
  //         setState(() {
  //           idproduct.map((list) {
  //             idproducts = list['id_product'];
  //           }).toList();
  //           // print(idproducts);
  //           getdataRecently();
  //         });
  //       }
  //     } else {
  //       //print('Error getRecently');
  //       CircularProgressIndicator();
  //     }
  //   });
  // }

//เก็บข้อมูลการดูล่าสุด
  // Future<Null> getdataRecently() async {
  //   String api =
  //       '${MyConstant().domain}/api/getProductWhereid.php?isAdd=true&id_product=$idproducts';

  //   // print(api);
  //   await Dio().get(api).then((value) {
  //     if (value.toString() != 'null') {
  //       for (var item in json.decode(value.data)) {
  //         ProductModel recentlyModel = ProductModel.fromMap(item);
  //         setState(() {
  //           recentlyModels.add(recentlyModel);
  //         });
  //       }
  //     } else {
  //       // print('Error getdataRecently');
  //       CircularProgressIndicator();
  //     }
  //   });
  // }

  Future<Null> getCategory() async {
    if (categoryList.length != 0) {
      loadC = true;
      categoryList.clear();
    }

    String api = '${MyConstant().domain}/api/getCategory.php';

    await Dio().get(api).then((value) {
      //print(value);
      setState(() {
        loadC = false;
      });
      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          CategoryModel categoryModel = CategoryModel.fromMap(item);
          setState(() {
            categoryList.add(categoryModel);
            // print(categoryList);
          });
        }
      } else {
        //print('Error getCategory');
        CircularProgressIndicator();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('หน้าแรก')),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              MaterialPageRoute route = MaterialPageRoute(
                builder: (value) => ShowSearch(),
              );
              Navigator.of(context).push(route);
            },
          )
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            MakeBanner(),
            Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(children: [
                  _buildSectiontitle(
                    'หมวดหมู่',
                    () {
                      MaterialPageRoute route = MaterialPageRoute(
                        builder: (value) => ShowallCategory(),
                      );
                      Navigator.of(context).push(route);
                    },
                  ),
                  SizedBox(
                    height: 200,
                    child: loadC!
                        ? MyStyle().showProgress()
                        : GridView.count(
                            crossAxisCount: 4,
                            children: List.generate(
                              8,
                              (index) => showCategory(index),
                            ),
                          ),
                  ),
                ])),
            Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(children: [
                  _buildSectiontitle(
                    'สินค้าแนะนำ',
                    () {
                      MaterialPageRoute route = MaterialPageRoute(
                        builder: (value) => PromoteUser(),
                      );
                      Navigator.of(context).push(route);
                    },
                  ),
                  // SizedBox(
                  //   height: 250,
                  //   child: ListView.builder(
                  //     physics: ClampingScrollPhysics(),
                  //     shrinkWrap: true,
                  //     scrollDirection: Axis.horizontal,
                  //     itemCount: productModels.length,
                  //     itemBuilder: (BuildContext context, int index) =>
                  //showListView(index),
                  //  ),
                  // ),
                ])),
            // Card(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(20),
            //     ),
            //     child: Column(children: [
            //       _buildSectiontitle(
            //         'ดูอีกครั้ง',
            //         () {},
            //       ),
            //       SizedBox(
            //         height: 250,
            //         child: ListView.builder(
            //           physics: ClampingScrollPhysics(),
            //           shrinkWrap: true,
            //           scrollDirection: Axis.horizontal,
            //           itemCount: recentlyModels.length,
            //           itemBuilder: (BuildContext context, int index) =>
            //               showRecentlyView(index),
            //         ),
            //       ),
            //     ])),
            Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(children: [
                  _buildSectiontitle(
                    'สินค้าทั้งหมด',
                    () {
                      MaterialPageRoute route = MaterialPageRoute(
                        builder: (value) => ProductAll(),
                      );
                      Navigator.of(context).push(route);
                    },
                  ),
                  loadStatus!
                      ? MyStyle().showProgress()
                      : GridView.count(
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 1.2),
                          crossAxisCount: 2,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(
                            productModels.length,
                            (index) {
                              return showAllview(index);
                            },
                          ),
                        ),
                ])),
          ],
        ),
      ),
    );
  }

  Widget showCategory(int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.0),
          bottomLeft: Radius.circular(30.0),
        ),
      ),
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
          onTap: () {
            MaterialPageRoute route = MaterialPageRoute(
                builder: (value) =>
                    CategoryProduct(categoryModel: categoryList[index]));
            Navigator.of(context).push(route);
          },
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                width: 50,
                child: Image.network(
                  '${MyConstant().domain}/upload/categorys/${categoryList[index].image}',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  categoryList[index].namecategory as String,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget showRecentlyView(int index) {
    String string = '${recentlyModels[index].nameproduct}';
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
              print(string);

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
                  '${MyConstant().domain}/upload/product/${recentlyModels[index].image}',
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
                        ' \฿ ${recentlyModels[index].price}',
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
                  '${MyConstant().domain}/upload/product/productModels[index].image',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
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
                width: 150,
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
                        ' \฿ ${productModels[index].price}',
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

  Widget showAllview(int index) {
    String string = '${productModels[index].nameproduct}';
    if (string.length > 10) {
      string = string.substring(0, 10);
      string = '$string ...';
    }
    return Container(
      margin: EdgeInsets.only(
        left: 5,
        right: 5,
        top: 5,
        bottom: 5,
      ),
      child: GestureDetector(
          onTap: () async {
            name = productModels[index].nameproduct;
            id = productModels[index].idProduct;
            // addRecently();
            MaterialPageRoute route = MaterialPageRoute(
              builder: (value) => ShowDetail(
                productModel: productModels[index],
              ),
            );
            Navigator.of(context).push(route);

            // dataId.add(id);
            // dataName.add(name);

            // if (dataName.length < 4) {
            //   print('data == >>> $dataName');
            //   if (dataName.length == 3) {
            //     //  addData();
            //     print('data add ===>> $dataId');
            //   }
            // } else {
            //   dataName.clear();
            //   dataId.clear();
            // }
          },
          child: Column(children: <Widget>[
            Container(
              height: 200,
              width: 200,
              child: Image.network(
                '${MyConstant().domain}/upload/product/${productModels[index].image}',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 200,
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
                      ' \฿ ${productModels[index].price}',
                      style: Theme.of(context)
                          .textTheme
                          .button!
                          .copyWith(color: Colors.red, fontSize: 20),
                    ),
                  ],
                ),
              ),
            )
          ])),
    );
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
