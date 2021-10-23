import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/product_models.dart';
import 'package:k6_app/models/subcategory_model.dart';
import 'package:k6_app/models/user_models.dart';
import 'package:k6_app/screens/User/show_detail.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';
import 'package:k6_app/utility/normal_dialog.dart';

class DetailProduct extends StatefulWidget {
  final ProductModel productModel;
  final UserModel userModel;
  const DetailProduct({required this.productModel, required this.userModel});

  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  ProductModel? productModel;
  List<ProductModel> productModels = [];
  bool? loadStatus = true;
  bool? status = true;
  String? name, id, idshop, clickid;
  SubcategoryModel? category;
  UserModel? userModel;
  @override
  void initState() {
    super.initState();
    setState(() {
      userModel = widget.userModel;
      productModel = widget.productModel;
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
        '${MyConstant().domain}/api/getproductIdShop.php?isAdd=true&id_shop=$idshop';
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
    String idsubcategory = productModel!.idSubcategory;
    //print(idcategory);
    String api =
        '${MyConstant().domain}/api/getSubcategoryfromidsubcategory.php?isAdd=true&id_subcategory=$idsubcategory';

    await Dio().get(api).then((value) {
      //print('===>$value');
      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          SubcategoryModel subcategoryModel = SubcategoryModel.fromMap(item);
          setState(() {
            category = subcategoryModel;
          });
        }
      } else {}
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
                      height: 260,
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
          '${MyConstant().domain}/upload/product/${productModel!.image}',
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
                    ' ${productModel?.price}\ บาท',
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
                        category!.namesubcategory as String,
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
            Row(
              children: [
                MyStyle().showTitleH2('วันที่โพสต์:  '),
                Text(
                  productModel!.regdate,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
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
            child: Column(children: <Widget>[
              Container(
                height: 150,
                width: 150,
                child: Image.network(
                  '${MyConstant().domain}/upload/product/${productModels[index].image}',
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
