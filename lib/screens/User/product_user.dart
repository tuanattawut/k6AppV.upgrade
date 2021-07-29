import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/product_models.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:k6_app/models/user_models.dart';
import 'package:k6_app/screens/User/show_detail.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';
import 'package:k6_app/utility/normal_dialog.dart';
import 'package:k6_app/widget/User/banner.dart';

class ProductListUser extends StatefulWidget {
  ProductListUser({required this.usermodel});
  final UserModel usermodel;
  @override
  _ProductListUserState createState() => _ProductListUserState();
}

class _ProductListUserState extends State<ProductListUser> {
  List<ProductModel> productModels = [];
  UserModel? userModel;
  bool? loadStatus = true;
  bool? status = true;

  String? name, id;

  List dataId = [];
  List dataName = [];
  @override
  void initState() {
    super.initState();
    getData();
    userModel = widget.usermodel;
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
          });
        }
      } else {
        setState(() {
          status = false;
        });
      }
    });
  }

  Future<Null> addData() async {
    String iduser = userModel!.idUser;

    String url =
        '${MyConstant().domain}/projectk6/addData.php?isAdd=true&id_user=$iduser&id_product=$dataId&nameproduct=$dataName';

    try {
      Response response = await Dio().get(url);
      print('res = $response');

      if (response.toString() == 'true') {
      } else {
        normalDialog(context, 'ผิดพลาดโปรดลองอีกครั้ง');
      }
    } catch (e) {}
  }

  SearchBar? searchBar;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        title: Center(child: Text('หน้าหลัก')),
        actions: [searchBar!.getSearchAction(context)]);
  }

  void onSubmitted(String value) {
    setState(() => ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('คุณพิมพ์ว่า $value'))));
  }

  _ProductListUserState() {
    searchBar = SearchBar(
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted,
        onCleared: () {
          print("เครีย");
        },
        onClosed: () {
          print("ปิด");
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar!.build(context),
      key: _scaffoldKey,
      body: loadStatus!
          ? MyStyle().showProgress()
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        MakeBanner(),
                        MyStyle().mySizebox(),
                        _buildSectiontitle('สินค้าทั้งหมด', () {
                          final snackbar = SnackBar(
                            content: Text("คลิก"),
                            action: SnackBarAction(
                              label: "ok",
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        }),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: productModels.length,
                          itemBuilder: (BuildContext buildContext, int index) {
                            return showListView(index);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget showImage(int index) {
    return Container(
      padding: EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          image: DecorationImage(
            image: NetworkImage(
                '${MyConstant().domain}/${productModels[index].image}'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget showName(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.5 - 35,
          child: Text(
            '${productModels[index].nameproduct}',
            style: MyStyle().mainTitle,
          ),
        ),
      ],
    );
  }

  Widget showDetail(int index) {
    String string = '${productModels[index].detail}';
    if (string.length > 100) {
      string = string.substring(0, 99);
      string = '$string ...';
    }
    return Text(
      string,
      style: TextStyle(
        fontSize: 16,
      ),
    );
  }

  Widget showText(int index) {
    return Container(
      padding: EdgeInsets.only(right: 20.0),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          showName(index),
          showDetail(index),
          Text(
            '${productModels[index].price} บาท',
            style: TextStyle(fontSize: 25, color: Colors.red),
          )
        ],
      ),
    );
  }

  Widget showListView(int index) {
    return GestureDetector(
      onTap: () {
        name = productModels[index].nameproduct;
        id = productModels[index].idProduct;
        MaterialPageRoute route = MaterialPageRoute(
          builder: (value) => ShowDetail(
            productModel: productModels[index],
          ),
        );
        Navigator.of(context).push(route);
        dataId.add(id);
        dataName.add(name);

        if (dataName.length < 4) {
          print(dataName);
          if (dataName.length == 3) {
            addData();
            print(dataId);
          }
        } else {
          dataName.clear();
          dataId.clear();
        }
      },
      child: Row(
        children: <Widget>[
          showImage(index),
          showText(index),
        ],
      ),
    );
  }

//   Widget showRecomView(int index) {
//     return Container(
//       margin: EdgeInsets.only(
//         left: 20,
//         right: 20,
//         top: 10,
//         bottom: 10,
//       ),
//       child: Column(
//         children: <Widget>[
//           Image.network('${MyConstant().domain}/${productModels[index].image}'),
//           GestureDetector(
//             onTap: () {
//               print(index);
//             },
//             child: Container(
//               padding: EdgeInsets.all(20 / 2),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(10),
//                   bottomRight: Radius.circular(10),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     offset: Offset(0, 10),
//                     blurRadius: 50,
//                     color: Colors.grey.withOpacity(0.23),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: <Widget>[
//                   RichText(
//                     text: TextSpan(
//                       children: [
//                         TextSpan(
//                           text: "${productModels[index].nameproduct}\n"
//                               .toUpperCase(),
//                           style: Theme.of(context)
//                               .textTheme
//                               .button!
//                               .copyWith(fontSize: 20),
//                         ),
//                         TextSpan(
//                           text: "${productModels[index].detail}",
//                           style: TextStyle(
//                             color: Colors.black.withOpacity(0.5),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Spacer(),
//                   Text(
//                     '${productModels[index].price} \บาท',
//                     style: Theme.of(context)
//                         .textTheme
//                         .button!
//                         .copyWith(color: Colors.red, fontSize: 20),
//                   )
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
}

Widget _buildSectiontitle(String title, [Function()? onTap]) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        InkWell(
          onTap: onTap,
          child: Icon(
            Icons.keyboard_arrow_right,
            color: Colors.indigo,
            size: 30,
          ),
        ),
      ],
    ),
  );
}
