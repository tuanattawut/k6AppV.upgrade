import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
import 'package:k6_app/screens/User/showsearch.dart';
import 'package:k6_app/screens/User/subcategory.dart';

class ProductListUser extends StatefulWidget {
  ProductListUser({required this.usermodel});
  final UserModel usermodel;
  @override
  _ProductListUserState createState() => _ProductListUserState();
}

class _ProductListUserState extends State<ProductListUser> {
  List<ProductModel> productModels = [];
  UserModel? userModel;

  String? name, id, idproducts, clickid, idUser;
  List<CategoryModel> categoryList = [];

  var f = NumberFormat.currency(locale: "THB", symbol: "฿");

  @override
  void initState() {
    super.initState();
    userModel = widget.usermodel;
    getData();
    getCategory();
    getPromotion();
    idUser = userModel!.idUser;
    //getRecom();
  }

  bool? loadStatus = true;
  bool? status = true;
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

  ProductModel? productRecList;
  Future<Null> getRecom() async {
    String api =
        '${MyConstant().domain}/api/reC.php?isAdd=true&id_user=$idUser';
    await Dio().get(api).then((value) {
      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          setState(() {
            productRecList = ProductModel.fromMap(item);

            getProductRecs();
          });
        }
      }
    });
  }

  bool? loadStatusREC = true;
  bool? statusREC = true;
  List<ProductModel> productRecLists = [];
  Future<Null> getProductRecs() async {
    if (productRecLists.length != 0) {
      loadStatusREC = true;
      statusREC = true;
      productRecLists.clear();
    }
    String? idsub = productRecList!.idSubcategory;
    String api =
        '${MyConstant().domain}/api/getproductfromidsubCategory.php?isAdd=true&id_subcategory=$idsub';

    await Dio().get(api).then((value) {
      setState(() {
        loadStatusREC = false;
      });
      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          ProductModel productRecLists2 = ProductModel.fromMap(item);
          setState(() {
            productRecLists.add(productRecLists2);
            // print(productRecLists2);
          });
        }
      } else {
        setState(() {
          statusREC = false;
        });
      }
    });
  }

//เพิ่มข้อมูลการคลิก
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
    } catch (e) {
      ///
    }
  }

  bool? loadCate = true;
  bool? statusCate = true;

  Future<Null> getCategory() async {
    if (categoryList.length != 0) {
      loadCate = true;
      statusCate = true;
      categoryList.clear();
    }

    String api = '${MyConstant().domain}/api/getCategory.php';

    await Dio().get(api).then((value) {
      //print(value);
      setState(() {
        loadCate = false;
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
        setState(() {
          statusCate = false;
        });
      }
    });
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      getProductRecs();
      getData();
    });

    return null;
  }

  var refreshKey = GlobalKey<RefreshIndicatorState>();
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                banner(context),
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(children: [
                      _buildSectiontitle(
                        'หมวดหมู่',
                        () {
                          MaterialPageRoute route = MaterialPageRoute(
                            builder: (value) => ShowallCategory(
                              userModel: userModel!,
                            ),
                          );
                          Navigator.of(context).push(route);
                        },
                      ),
                      SizedBox(
                        height: 200,
                        child: loadCate!
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
                            builder: (value) => PromoteUser(
                              userModel: userModel!,
                              productModel: productRecList!,
                            ),
                          );
                          Navigator.of(context).push(route);
                        },
                      ),
                      // SizedBox(
                      //   height: 260,
                      //   child: loadStatusREC!
                      //       ? MyStyle().showProgress()
                      //       : ListView.builder(
                      //           physics: ClampingScrollPhysics(),
                      //           shrinkWrap: true,
                      //           scrollDirection: Axis.horizontal,
                      //           itemCount: productRecLists.length,
                      //           itemBuilder:
                      //               (BuildContext context, int index) =>
                      //                   showListView(index),
                      //         ),
                      // ),
                    ])),
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(children: [
                      _buildSectiontitle(
                        'สินค้าทั้งหมด',
                        () {
                          MaterialPageRoute route = MaterialPageRoute(
                            builder: (value) => ProductAll(
                              userModel: userModel!,
                            ),
                          );
                          Navigator.of(context).push(route);
                        },
                      ),
                      loadStatus!
                          ? MyStyle().showProgress()
                          : GridView.count(
                              childAspectRatio: MediaQuery.of(context)
                                      .size
                                      .width /
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
          onRefresh: refreshList,
        ));
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
                builder: (value) => Subcategory(
                      categoryModel: categoryList[index],
                      userModel: userModel!,
                    ));
            Navigator.of(context).push(route);
          },
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
                width: 50,
                child: Image.network(
                  '${MyConstant().domain}/images/categories/${categoryList[index].image}',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                child: Text(
                  categoryList[index].namecategory.toString(),
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget showListView(int index) {
    String string = '${productRecLists[index].nameproduct}';
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
              clickid = productRecLists[index].id;
              addData();
              MaterialPageRoute route = MaterialPageRoute(
                builder: (value) => ShowDetail(
                  productModel: productRecLists[index],
                  userModel: userModel!,
                ),
              );
              Navigator.of(context).push(route);
            },
            child: Column(children: <Widget>[
              Container(
                height: 150,
                width: 150,
                child: Image.network(
                  '${MyConstant().domain}/images/products_seller/${productRecLists[index].image}',
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
                width: 200,
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
                        f.format(double.parse(
                            productRecLists[index].price.toString())),
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
            clickid = productModels[index].id;
            //addData();
            // print(clickid);
            var view = int.parse(productModels[index].view.toString());
            view++;
            print(view);
            // MaterialPageRoute route = MaterialPageRoute(
            //   builder: (value) => ShowDetail(
            //     productModel: productModels[index],
            //     userModel: userModel!,
            //   ),
            // );
            // Navigator.of(context).push(route);
          },
          child: Column(children: <Widget>[
            Container(
              height: 200,
              width: 200,
              child: Image.network(
                '${MyConstant().domain}/images/products_seller/${productModels[index].image}',
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
                      f.format(
                          double.parse(productModels[index].price.toString())),
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

  Future<Null> getPromotion() async {
    String api = '${MyConstant().domain}/api/getPromotion.php';

    await Dio().get(api).then((value) {
      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          pathImages.add(item);
          setState(() {
            pathImages.map((prolist) {
              promotion = prolist['image'];
            }).toList();
          });
          buildWidgets();
        }
      }
    });
  }

  int _current = 0;
  String? promotion;
  List<Widget> widgets = [];
  List pathImages = [];

  void buildWidgets() {
    widgets.add(
        Image.network('${MyConstant().domain}/images/promotionweb/$promotion'));
    //print(widgets);
  }

  Widget banner(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // print('คลิก $_current');
        },
        child: Column(
          children: [
            CarouselSlider(
              items: widgets,
              options: CarouselOptions(
                  autoPlay: true,
                  autoPlayAnimationDuration: Duration(seconds: 2),
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  pauseAutoPlayOnTouch: true,
                  height: MediaQuery.of(context).size.width * 0.45,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widgets.map((pathImages) {
                int index = widgets.indexOf(pathImages);

                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? Color.fromRGBO(0, 0, 0, 0.9)
                        : Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                );
              }).toList(),
            ),
          ],
        ));
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
