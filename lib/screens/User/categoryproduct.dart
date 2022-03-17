import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:k6_app/models/clickdata_model.dart';
import 'package:k6_app/models/product_models.dart';
import 'package:k6_app/models/subcategory_model.dart';
import 'package:k6_app/models/user_models.dart';
import 'package:k6_app/screens/User/show_detail.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/normal_dialog.dart';

class CategoryProduct extends StatefulWidget {
  CategoryProduct({required this.subcategoryModel, required this.userModel});
  final SubcategoryModel subcategoryModel;
  final UserModel userModel;
  @override
  _CategoryProductState createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  SubcategoryModel? subcategoryModels;
  String? idsubcategory, name, id, clickid;
  List<ProductModel> productModels = [];
  bool? check;
  UserModel? userModel;
  var f = NumberFormat.currency(locale: "THB", symbol: "฿");
  @override
  void initState() {
    super.initState();
    userModel = widget.userModel;
    subcategoryModels = widget.subcategoryModel;
    getProduct();
    //print(categoryModels!.idcategory);
  }

  Future<Null> getProduct() async {
    idsubcategory = subcategoryModels?.idsubcategory;
    // print(idcategory);
    String api =
        '${MyConstant().domain}/api/getproductfromidsubCategory.php?isAdd=true&id_subcategory=$idsubcategory';
    Response response = await Dio().get(api);
    var result = json.decode(response.data);
    if (result != null) {
      for (var map in result) {
        setState(() {
          ProductModel productModel = ProductModel.fromMap(map);
          setState(() {
            productModels.add(productModel);
          });
        });
      }
    } else {
      setState(() {
        check = false;
      });
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: subcategoryModels == null
                ? Text('หมวดหมู่')
                : Text(subcategoryModels!.namesubcategory.toString())),
      ),
      body: check == false
          ? showNotProduct()
          : SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GridView.count(
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
                ],
              ),
            ),
    );
  }

  Widget showNotProduct() {
    return Center(
      child: Text(
        'ไม่พบสินค้าในหมวดหมู่นี้',
        style: Theme.of(context)
            .textTheme
            .button!
            .copyWith(color: Colors.black, fontSize: 20),
      ),
    );
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
            clickid = productModels[index].id.toString();
            var view = int.parse(productModels[index].view.toString());
            view++;
            String url =
                '${MyConstant().domain}/api/updateViewProduct.php?isAdd=true&view=$view&id=$clickid';
            await Dio().get(url).then((value) {
              print(value);
            });
            print('view ปัจจุบัน = $view');
            addData(clickid.toString());
            checkClickdata(clickid.toString());
            MaterialPageRoute route = MaterialPageRoute(
              builder: (value) => ShowDetail(
                productModel: productModels[index],
                userModel: userModel!,
              ),
            );
            Navigator.of(context).push(route);
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
}
