import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/area_model.dart';
import 'package:k6_app/models/seller_model.dart';
import 'package:k6_app/screens/Seller/areadetail_seller.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';

class RentSeller extends StatefulWidget {
  RentSeller({required this.sellerModel});
  final SellerModel sellerModel;
  @override
  _RentSellerState createState() => _RentSellerState();
}

class _RentSellerState extends State<RentSeller> {
  SellerModel? sellerModel;
  void initState() {
    super.initState();
    sellerModel = widget.sellerModel;
    readArea();
  }

  List<AreaModel> areaList = [];
  Future<Null> readArea() async {
    String url = '${MyConstant().domain}/api/getArea.php';
    await Dio().get(url).then((value) {
      if (value.toString() != 'null') {
        // print('value ==>> $value');

        var result = json.decode(value.data);
        //  print('result ==>> $result');

        for (var map in result) {
          AreaModel areaModel = AreaModel.fromMap(map);
          setState(() {
            areaList.add(areaModel);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เช่าจองแผงขายสินค้า'),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: areaList.length,
            itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  MaterialPageRoute route = MaterialPageRoute(
                      builder: (value) => DetailareaSeller(
                          areaModel: areaList[index],
                          sellerModel: sellerModel!));
                  Navigator.of(context).push(route);
                },
                child: Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.width * 0.4,
                        child: Image.network(
                          '${MyConstant().domain}/images/areasshop/${areaList[index].image}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.width * 0.4,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '${areaList[index].namearea}',
                                style: MyStyle().mainTitle,
                              ),
                              Text(
                                'ขนาด ${areaList[index].scale}',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                '${areaList[index].rentalfee} บาท',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                areaList[index].detail.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceAround,
                              //   children: <Widget>[
                              //     IconButton(
                              //       icon: Icon(
                              //         Icons.edit,
                              //         color: Colors.green,
                              //       ),
                              //       onPressed: () {
                              //         // MaterialPageRoute route =
                              //         //     MaterialPageRoute(
                              //         //   builder: (value) => EditProduct(
                              //         //     productModel:
                              //         //         productModels[index],
                              //         //   ),
                              //         // );
                              //         // Navigator.of(context).push(route);
                              //       },
                              //     ),
                              //     IconButton(
                              //         icon: Icon(
                              //           Icons.delete,
                              //           color: Colors.red,
                              //         ),
                              //         onPressed: () => {}),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
