import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/category_model.dart';
import 'package:k6_app/models/product_models.dart';
import 'package:k6_app/screens/User/show_detail.dart';
import 'package:k6_app/utility/my_constant.dart';

class CategoryProduct extends StatefulWidget {
  CategoryProduct({required this.categoryModel});
  final CategoryModel categoryModel;
  @override
  _CategoryProductState createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  CategoryModel? categoryModels;
  String? idcategory, name, id;
  List<ProductModel> productModels = [];
  bool? check;
  @override
  void initState() {
    super.initState();
    categoryModels = widget.categoryModel;
    getProduct();
  }

  Future<Null> getProduct() async {
    idcategory = categoryModels?.idcategory;
    //print(idcategory);

    String api =
        '${MyConstant().domain}/projectk6/getProductWhereidCategory.php?isAdd=true&id_category=$idcategory';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: categoryModels == null
                ? Text('หมวดหมู่')
                : Text(categoryModels!.namecategory as String)),
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
                '${MyConstant().domain}/${productModels[index].image}',
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
                    color: Colors.blue.withOpacity(0.23),
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
