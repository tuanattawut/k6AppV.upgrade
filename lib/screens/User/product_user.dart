import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:k6_app/models/category_model.dart';
import 'package:k6_app/models/clickdata_model.dart';
import 'package:k6_app/models/product_models.dart';
import 'package:k6_app/models/promotionseller_model.dart';
import 'package:k6_app/models/user_models.dart';
import 'package:k6_app/screens/User/detailpromotion_user.dart';
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

  String? name, id, idproducts, idUser, clickid;
  List<CategoryModel> categoryList = [];

  var f = NumberFormat.currency(locale: "THB", symbol: "฿");

  @override
  void initState() {
    super.initState();
    userModel = widget.usermodel;
    //getData();
    getCategory();
    getPromotion();
    idUser = userModel!.idUser;
    //  getRecom();
    readPromotion();
    getProductRecs();
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

  // ProductModel? productRecList;
  // Future<Null> getRecom() async {
  //   String api =
  //       '${MyConstant().domain}/api/reC.php?isAdd=true&id_user=$idUser';
  //   await Dio().get(api).then((value) {
  //     //print(value.toString());
  //     if (value.toString() != 'null') {
  //       for (var item in json.decode(value.data)) {
  //         setState(() {
  //           productRecList = ProductModel.fromMap(item);
  //           getProductRecs();
  //         });
  //         break;
  //       }
  //     } else if (value.toString() == 'null') {
  //       getRecomALL();
  //       print('ไม่มีข้อมูลแนะนำ');
  //     }
  //   });
  // }

  // Future<Null> getRecomALL() async {
  //   String api = '${MyConstant().domain}/api/reCAll.php?isAdd=true';
  //   Dio().get(api).then((value) async {
  //     for (var item in json.decode(value.data)) {
  //       setState(() {
  //         productRecList = ProductModel.fromMap(item);
  //         getProductRecs();
  //       });
  //       break;
  //     }
  //   });
  // }

  // bool? loadStatusREC = true;
  // bool? statusREC = true;
  // List<ProductModel> allproductRec = [];
  // Future<Null> getProductRecs() async {
  //   if (allproductRec.length != 0) {
  //     loadStatusREC = true;
  //     statusREC = true;
  //     allproductRec.clear();
  //   }
  //   String? idsub = productRecList!.idSubcategory;
  //   String api =
  //       '${MyConstant().domain}/api/getproductfromidsubCategory.php?isAdd=true&id_subcategory=$idsub';
  //   await Dio().get(api).then((value) {
  //     setState(() {
  //       loadStatusREC = false;
  //     });
  //     if (value.toString() != 'null') {
  //       for (var item in json.decode(value.data)) {
  //         ProductModel productRecLists = ProductModel.fromMap(item);
  //         setState(() {
  //           allproductRec.add(productRecLists);
  //         });
  //       }
  //     } else {
  //       setState(() {
  //         statusREC = false;
  //       });
  //     }
  //   });
  // }

  Future<Null> getRecomALL() async {
    String api = '${MyConstant().domain}/api/relationshipproductusernull';
    Dio().get(api).then((value) async {
      for (var item in json.decode(value.data)) {
        ProductModel productRecLists = ProductModel.fromMap(item);
        setState(() {
          allproductRec.add(productRecLists);
        });
      }
    });
  }

  bool? loadStatusREC = true;
  bool? statusREC = true;
  List<ProductModel> allproductRec = [];
  Future<Null> getProductRecs() async {
    if (allproductRec.length != 0) {
      loadStatusREC = true;
      statusREC = true;
      allproductRec.clear();
    }
    String api =
        '${MyConstant().domain}/api/relationshipproductuser?user_id=$idUser';
    Response response = await Dio().get(api);
    var result = json.decode(response.data);
    setState(() {
      loadStatusREC = false;
    });

    if (result == false) {
      setState(() {
        getRecomALL();
        statusREC = false;
      });
    } else {
      for (var map in result) {
        ProductModel productRecLists = ProductModel.fromMap(map);
        setState(() {
          allproductRec.add(productRecLists);
        });
      }
    }
  }

//เพิ่มข้อมูลการคลิก
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

  bool? loadPro = true;
  bool? statusPro = true;
  List<PromotionsellerModel> promotionlist = [];
  Future<Null> readPromotion() async {
    if (promotionlist.length != 0) {
      loadPro = true;
      statusPro = true;
      promotionlist.clear();
    }
    String url = '${MyConstant().domain}/api/getAllpromotionseller.php';
    await Dio().get(url).then((value) {
      setState(() {
        loadPro = false;
      });
      if (value.toString() != 'null') {
        // print('value ==>> $value');
        var result = json.decode(value.data);
        //  print('result ==>> $result');
        for (var map in result) {
          PromotionsellerModel promotionsellerModel =
              PromotionsellerModel.fromMap(map);
          setState(() {
            if (promotionsellerModel.status == 'yes') {
              promotionlist.add(promotionsellerModel);
            }
          });
        }
      } else {
        setState(() {
          statusPro = false;
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
                        height: MediaQuery.of(context).size.height * 0.25,
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
                        'โปรโมชันร้านค้า',
                        () {
                          // MaterialPageRoute route = MaterialPageRoute(
                          //   builder: (value) => ProductAll(
                          //     userModel: userModel!,
                          //   ),
                          // );
                          // Navigator.of(context).push(route);
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: loadPro!
                            ? MyStyle().showProgress()
                            : ListView.builder(
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: promotionlist.length,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        showProView(index),
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
                            builder: (value) => ProductAll(
                              userModel: userModel!,
                            ),
                          );
                          Navigator.of(context).push(route);
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: loadStatusREC!
                            ? MyStyle().showProgress()
                            : ListView.builder(
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: allproductRec.length,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        showRecView(index),
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

  Widget showRecView(int index) {
    String string = '${allproductRec[index].nameproduct}';
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
            clickid = allproductRec[index].id.toString();
            var view = int.parse(allproductRec[index].view.toString());
            view++;
            String url =
                '${MyConstant().domain}/api/updateViewProduct.php?isAdd=true&view=$view&id=$clickid';
            await Dio().get(url).then((value) async {
              await addData(clickid.toString());
              await checkClickdata(clickid.toString());
              MaterialPageRoute route = MaterialPageRoute(
                builder: (value) => ShowDetail(
                  productModel: allproductRec[index],
                  userModel: userModel!,
                ),
              );
              Navigator.of(context)
                  .push(route)
                  .then((value) => getProductRecs());
            });
          },
          child: Column(children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.20,
              child: Image.network(
                '${MyConstant().domain}/images/products_seller/${allproductRec[index].image}',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.height * 0.25,
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
                          double.parse(allproductRec[index].price.toString())),
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

  Widget showProView(int index) {
    String string = '${promotionlist[index].detailpromotion}';
    if (string.length > 10) {
      string = string.substring(0, 10);
      string = '$string ...';
    }

    String nameshop = '${promotionlist[index].nameshop}';
    if (nameshop.length > 10) {
      nameshop = nameshop.substring(0, 10);
      nameshop = '$nameshop ...';
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
              MaterialPageRoute route = MaterialPageRoute(
                  builder: (value) => DetailPromotionseller(
                      promotionsellerModel: promotionlist[index]));
              Navigator.of(context).push(route);
            },
            child: Column(children: <Widget>[
              Container(
                height: 150,
                width: 150,
                child: Image.network(
                  '${MyConstant().domain}/images/promotionseller/${promotionlist[index].image}',
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
                        'ร้าน : $nameshop',
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
