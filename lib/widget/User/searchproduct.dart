import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/product_models.dart';
import 'package:k6_app/models/user_models.dart';
import 'package:k6_app/screens/User/show_detail.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({required this.idproduct, required this.userModel});
  final idproduct;
  final UserModel userModel;
  @override
  _SearchProductState createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  String? idproduct;
  bool? loadStatus = true;
  bool? status = true;
  List<ProductModel> productModels = [];
  UserModel? userModel;
  @override
  void initState() {
    super.initState();
    setState(() {
      userModel = widget.userModel;
      idproduct = widget.idproduct;
      //print(idproduct);
      getProduct();
    });
  }

  Future<Null> getProduct() async {
    String api =
        '${MyConstant().domain}/api/getproductfromidProduct.php?isAdd=true&id_products=$idproduct';
    //print(api);
    await Dio().get(api).then((value) {
      // print(value);
      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          ProductModel productModel = ProductModel.fromMap(item);
          setState(() {
            productModels.add(productModel);
          });
        }
      } else {
        //     print('Error getdataRecently');
        //     CircularProgressIndicator();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('ผลการค้นหา')),
      ),
      body: loadStatus == false
          ? MyStyle().showProgress()
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
            // addRecently();
            MaterialPageRoute route = MaterialPageRoute(
              builder: (value) => ShowDetail(
                productModel: productModels[index],
                userModel: userModel!,
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
                      ' ${productModels[index].price} \บาท',
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
