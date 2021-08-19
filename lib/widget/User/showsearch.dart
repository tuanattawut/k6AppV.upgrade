import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/product_models.dart';
import 'package:k6_app/screens/User/show_detail.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';

class ShowSearch extends StatefulWidget {
  @override
  _ShowSearchState createState() => _ShowSearchState();
}

class _ShowSearchState extends State<ShowSearch> {
  List<String>? foodListSearch;
  final FocusNode _textFocusNode = FocusNode();
  TextEditingController? _textEditingController = TextEditingController();
  @override
  void dispose() {
    _textFocusNode.dispose();
    _textEditingController!.dispose();
    super.dispose();
  }

  List<ProductModel> productModels = [];
  List<String>? product = [];
  bool? loadStatus = true;
  bool? status = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<Null> getData() async {
    if (productModels.length != 0) {
      loadStatus = true;
      status = true;
      productModels.clear();
    }

    String api = '${MyConstant().domain}/projectk6/getProduct.php';

    await Dio().get(api).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          ProductModel productModel = ProductModel.fromMap(item);
          setState(() {
            productModels.add(productModel);
            product = productModels
                .map((productModels) => productModels.nameproduct)
                .toList();
          });
        }
      } else {
        setState(() {
          status = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: _textEditingController,
              focusNode: _textFocusNode,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: 'ค้นหา',
                  contentPadding: EdgeInsets.all(8)),
              onChanged: (value) {
                setState(() {
                  print(foodListSearch);
                  print('Search $product');
                  foodListSearch = product!
                      .where((element) => element.contains(value.toLowerCase()))
                      .toList();

                  if (_textEditingController!.text.isNotEmpty &&
                      foodListSearch!.length == 0) {
                    print('foodListSearch length ${foodListSearch!.length}');
                  }
                });
              },
            ),
          )),
      body: loadStatus!
          ? MyStyle().showProgress()
          : _textEditingController!.text.isNotEmpty &&
                  foodListSearch!.length == 0
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.search_off,
                            size: 50,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'ไม่พบสิ่งที่คุณค้นหา,\nลองเปลี่ยนคำค้นหา',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: _textEditingController!.text.isNotEmpty
                      ? foodListSearch!.length
                      : 0,
                  itemBuilder: (BuildContext buildContext, int index) {
                    return ListTile(
                      onTap: () {
                        MaterialPageRoute route = MaterialPageRoute(
                          builder: (value) =>
                              ShowDetail(productModel: productModels[index]),
                        );
                        Navigator.of(context).push(route);
                      },
                      title: Text(_textEditingController!.text.isNotEmpty
                          ? foodListSearch![index]
                          : ' ${productModels[index].nameproduct}'),
                    );
                  }),
    );
  }
}
