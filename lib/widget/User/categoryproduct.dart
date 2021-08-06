import 'package:flutter/material.dart';
import 'package:k6_app/models/category_model.dart';

class CategoryProduct extends StatefulWidget {
  CategoryProduct({required this.categoryModel});
  final CategoryModel categoryModel;
  @override
  _CategoryProductState createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  CategoryModel? categoryModels;

  @override
  void initState() {
    super.initState();
    categoryModels = widget.categoryModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(categoryModels!.namecategory as String)),
      ),
      // body: Stack(
      //   children: [
      //   //   loadStatus!
      //   //       ? MyStyle().showProgress()
      //   //       : Container(
      //   //           child: ListView.builder(
      //   //             itemCount: productModels.length,
      //   //             itemBuilder: (BuildContext buildContext, int index) {
      //   //               return showListView(index);
      //   //             },
      //   //           ),
      //   //         ),
      //   // ],
      // ),
    );
  }
}
