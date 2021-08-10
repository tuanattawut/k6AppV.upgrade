import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/category_model.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/widget/User/categoryproduct.dart';

class ShowallCategory extends StatefulWidget {
  @override
  _ShowallCategoryState createState() => _ShowallCategoryState();
}

class _ShowallCategoryState extends State<ShowallCategory> {
  List<CategoryModel> categoryList = [];
  @override
  void initState() {
    super.initState();
    getCategory();
  }

  Future<Null> getCategory() async {
    String api = '${MyConstant().domain}/projectk6/getCategory.php';

    await Dio().get(api).then((value) {
      //print(value);
      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          CategoryModel categoryModel = CategoryModel.fromMap(item);
          setState(() {
            categoryList.add(categoryModel);
            // print(categoryList);
          });
        }
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('หมวดหมู่ทั้งหมด')),
      ),
      body: GridView.count(
        crossAxisCount: 4,
        children: List.generate(
          categoryList.length,
          (index) => showCategory(index),
        ),
      ),
    );
  }

  Widget showCategory(int index) {
    String string = '${categoryList[index].namecategory}';
    if (string.length > 10) {
      string = string.substring(0, 10);
      string = '$string...';
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.0),
          bottomLeft: Radius.circular(30.0),
        ),
      ),
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
        bottom: 10,
      ),
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
                  '${MyConstant().domain}/${categoryList[index].image}',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  string,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
