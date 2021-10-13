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
    String api = '${MyConstant().domain}/api/getCategory.php';

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
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20, bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              children: List.generate(
                categoryList.length,
                (index) => showCategory(index),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showCategory(int index) {
    // String string = '${categoryList[index].namecategory}';
    // if (string.length > 10) {
    //   string = string.substring(0, 10);
    //   string = '$string...';
    // }

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
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
                height: 60,
                width: 60,
                child: Image.network(
                  '${MyConstant().domain}/upload/img/${categoryList[index].image}',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  categoryList[index].namecategory as String,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
