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
      body: Container(
        child: ListView.builder(
            itemCount: subcategoryItemList.length,
            itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.all(8),
                  child: ListTile(
                    onTap: () {
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (value) => CategoryProduct(
                                subcategoryModel: subcategoryItemList[index],
                                userModel: userModel!,
                              ));
                      Navigator.of(context).push(route);
                    },
                    title: Text(
                      subcategoryItemList[index].namesubcategory.toString(),
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                    ),
                  ),
                )),
      ),
    );
  }
}
