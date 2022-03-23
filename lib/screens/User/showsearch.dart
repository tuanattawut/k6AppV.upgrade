import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:k6_app/models/clickdata_model.dart';
import 'package:k6_app/models/product_models.dart';
import 'package:k6_app/models/user_models.dart';
import 'package:k6_app/screens/User/show_detail.dart';
import 'package:k6_app/utility/my_constant.dart';

class ShowSearch extends StatefulWidget {
  const ShowSearch({required this.userModel});
  final UserModel userModel;
  @override
  State createState() => _ShowSearchState();
}

class _ShowSearchState extends State<ShowSearch> {
  TextEditingController editingController = TextEditingController();
  bool? searching;
  var data;
  String? query;

  UserModel? userModel;

  var f = NumberFormat.currency(locale: "THB", symbol: "฿");
  @override
  void initState() {
    searching = false;
    super.initState();
    userModel = widget.userModel;
  }

  bool? loadStatus = true;
  bool? status = true;
  List<ProductModel> productList = [];
  Future<Null> getSearch() async {
    if (productList.length != 0) {
      loadStatus = true;
      status = true;
      productList.clear();
    }
    String api =
        '${MyConstant().domain}/api/search_product.php?isAdd=true&nameproduct=${editingController.text}';

    await Dio().get(api).then((value) {
      setState(() {
        loadStatus = false;
      });
      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          ProductModel productModel = ProductModel.fromMap(item);
          setState(() {
            productList.add(productModel);
          });
        }
      } else {
        setState(() {
          status = false;
          loadStatus = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: searching!
              ? IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      searching = false;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                ),
          title: searchField(),
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    searching = true;
                    print(editingController.text);
                    if (editingController.text.isNotEmpty) {
                      getSearch();
                      editingController.clear();
                    }
                  });
                }),
          ],
        ),
        body: showContent());
  }

  Widget searchField() {
    return Container(
        child: TextField(
      controller: editingController,
      autofocus: true,
      textInputAction: TextInputAction.search,
      onSubmitted: (value) {
        searching = true;
        print(editingController.text);
        if (editingController.text.isNotEmpty) {
          getSearch();
          editingController.clear();
        }
      },
      style: TextStyle(color: Colors.white, fontSize: 18),
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.white, fontSize: 18),
        hintText: "พิมพ์คำค้นหา",
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
      ),
    ));
  }

  Widget showContent() {
    return Center(
      child: loadStatus!
          ? Text(
              'ไม่พบการค้นหา ...',
              style: TextStyle(fontSize: 18),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.count(
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.2),
                      crossAxisCount: 2,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                        productList.length,
                        (index) {
                          return showAllview(index);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  String? clickid;

  Future<Null> addData(String clickid) async {
    String iduser = userModel!.idUser;
    String url =
        '${MyConstant().domain}/api/addactionClick.php?isAdd=true&id_user=$iduser&id_products=$clickid';
    try {
      Response response = await Dio().get(url);
      print('res = $response');
      if (response.toString() == 'true') {
      } else {
        // normalDialog(context, 'ผิดพลาดโปรดลองอีกครั้ง');
      }
    } catch (e) {
      ///
    }
  }

  ClickdataModel? clickdataModel;
  Future<Null> checkClickdata(String clickid) async {
    String iduser = userModel!.idUser;
    String url =
        '${MyConstant().domain}/api/checkDataclick.php?isAdd=true&id_user=$iduser&id_products=$clickid';
    await Dio().get(url).then((value) {
      print(value.toString());
      if (value.toString() != 'null') {
        print('DATA');
        for (var item in json.decode(value.data)) {
          clickdataModel = ClickdataModel.fromMap(item);
          print(clickdataModel!.view);
          var viewdataclick = int.parse((clickdataModel!.view.toString()));
          viewdataclick++;
          setState(() {
            updateViewClick(clickid, viewdataclick.toString());
          });
        }
      } else {
        print('NO DATA');
        addClickdata(clickid);
      }
    });
  }

  Future<Null> addClickdata(String clickid) async {
    String iduser = userModel!.idUser;
    String url =
        '${MyConstant().domain}/api/addDataclick.php?isAdd=true&id_user=$iduser&id_product=$clickid';
    try {
      Response response = await Dio().get(url);
      print('อยู่นี่ ${response.toString()}');
    } catch (e) {
      ///
    }
  }

  Future<Null> updateViewClick(String clickid, String view) async {
    String iduser = userModel!.idUser;
    String url =
        '${MyConstant().domain}/api/updateViewDataclick.php?isAdd=true&view=$view&id_user=$iduser&id_product=$clickid';
    try {
      Response response = await Dio().get(url);
      print('อัพเดท${response.toString()}');
    } catch (e) {
      ///
    }
  }

  Widget showAllview(int index) {
    String string = '${productList[index].nameproduct}';
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
            clickid = productList[index].id.toString();
            var view = int.parse(productList[index].view.toString());
            view++;
            String url =
                '${MyConstant().domain}/api/updateViewProduct.php?isAdd=true&view=$view&id=$clickid';
            await Dio().get(url).then((value) async {
              await addData(clickid.toString());
              await checkClickdata(clickid.toString());
              print(value);
              MaterialPageRoute route = MaterialPageRoute(
                builder: (value) => ShowDetail(
                  productModel: productList[index],
                  userModel: userModel!,
                ),
              );
              Navigator.of(context).push(route);
            });
          },
          child: Column(children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.height * 0.25,
              child: Image.network(
                '${MyConstant().domain}/images/products_seller/${productList[index].image}',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.height * 0.25,
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
                      f.format(
                          double.parse(productList[index].price.toString())),
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
