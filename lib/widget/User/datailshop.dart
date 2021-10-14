import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/seller_model.dart';
import 'package:k6_app/models/shop_model.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';

class DetailShop extends StatefulWidget {
  final ShopModel shopModel;
  DetailShop({required this.shopModel});

  @override
  _DetailShopState createState() => _DetailShopState();
}

class _DetailShopState extends State<DetailShop> {
  ShopModel? shopModels;
  String? idSeller;
  SellerModel? sellerModel;
  @override
  void initState() {
    super.initState();
    setState(() {
      // shopModels = widget.shopModel;
      //print('url ==> ${productModel?.image}');
      //readSeller();
    });
  }

  // Future<Null> readSeller() async {
  //   idSeller = shopModels?.idSeller;
  //   // print(idSeller);
  //   String url =
  //       '${MyConstant().domain}/api/getSellerfromidSeller.php?isAdd=true&id_seller=$idSeller';
  //   Response response = await Dio().get(url);

  //   //print(response);
  //   var result = json.decode(response.data);
  //   //print('result = $result');

  //   for (var map in result) {
  //     setState(() {
  //       sellerModel = SellerModel.fromMap(map);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: sellerModel == null
          ? MyStyle().showProgress()
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8),
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  // Center(
                  //   child: SizedBox(
                  //     height: 300,
                  //     width: 300,
                  //     child: showImage(),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.all(8),
                  //   child: Row(
                  //     children: [
                  //       MyStyle().showTitleH2('ร้าน: '),
                  //       Text(
                  //         shopModels!.nameshop,
                  //         style: TextStyle(
                  //           fontSize: 18,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.all(8),
                  //   child: Row(
                  //     children: [
                  //       MyStyle().showTitleH2('โทร: '),
                  //       Text(
                  //         sellerModel!.phone,
                  //         style: TextStyle(
                  //           fontSize: 18,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ]),
              ),
            ),
    );
  }

  Widget showImage() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Image.network(
          '${MyConstant().domain}/upload/shop/${shopModels!.image}',
          fit: BoxFit.contain,
        ));
  }
}
