import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/category_model.dart';
import 'package:k6_app/models/subcategory_model.dart';
import 'package:k6_app/models/user_models.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/widget/User/categoryproduct.dart';

class Subcategory extends StatefulWidget {
  Subcategory({required this.categoryModel, required this.userModel});
  final CategoryModel categoryModel;
  final UserModel userModel;
  @override
  _SubcategoryState createState() => _SubcategoryState();
}

class _SubcategoryState extends State<Subcategory> {
  CategoryModel? categoryModels;
  UserModel? userModel;
  @override
  void initState() {
    super.initState();
    userModel = widget.userModel;
    categoryModels = widget.categoryModel;
    readsubCategory();
  }

  List<SubcategoryModel> subcategoryItemList = [];

  Future<Null> readsubCategory() async {
    String api =
        '${MyConstant().domain}/api/getSubcategoryfromidCategory.php?isAdd=true&id_category=${categoryModels!.idcategory}';
    await Dio().get(api).then((value) {
      for (var item in json.decode(value.data)) {
        SubcategoryModel subcategoryModel = SubcategoryModel.fromMap(item);
        setState(() {
          subcategoryItemList.add(subcategoryModel);
          // print(categoryList);
        });
      }
    });
    //  print(subcategoryItemList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryModels!.namecategory.toString()),
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
                subcategoryItemList.length,
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
                builder: (value) => CategoryProduct(
                      subcategoryModel: subcategoryItemList[index],
                      userModel: userModel!,
                    ));
            Navigator.of(context).push(route);
          },
          child: Column(
            children: <Widget>[
              // Container(
              //   height: 60,
              //   width: 60,
              //   child: Image.network(
              //     '${MyConstant().domain}/upload/categories/${subcategoryItemList[index].image}',
              //     fit: BoxFit.cover,
              //   ),
              // ),
              Container(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  subcategoryItemList[index].namesubcategory.toString(),
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
