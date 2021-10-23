import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/category_model.dart';
import 'package:k6_app/models/user_models.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/widget/User/subcategory.dart';

class ShowallCategory extends StatefulWidget {
  ShowallCategory({required this.userModel});

  final UserModel userModel;
  @override
  _ShowallCategoryState createState() => _ShowallCategoryState();
}

class _ShowallCategoryState extends State<ShowallCategory> {
  List<CategoryModel> categoryList = [];
  UserModel? userModel;
  @override
  void initState() {
    super.initState();
    userModel = widget.userModel;
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
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('หมวดหมู่')),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: categoryList.length,
            itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.all(8),
                  child: ListTile(
                    onTap: () {
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (value) => Subcategory(
                                categoryModel: categoryList[index],
                                userModel: userModel!,
                              ));
                      Navigator.of(context).push(route);
                    },
                    leading: Image.network(
                      '${MyConstant().domain}/upload/categories/${categoryList[index].image}',
                      fit: BoxFit.cover,
                      width: 50,
                    ),
                    title: Text(
                      categoryList[index].namecategory as String,
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
