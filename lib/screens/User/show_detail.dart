import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:k6_app/models/product_models.dart';
import 'package:k6_app/models/user_models.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';

class ShowDetail extends StatefulWidget {
  final ProductModel productModel;

  ShowDetail({this.productModel});
  @override
  _ShowDetailState createState() => _ShowDetailState();
}

class _ShowDetailState extends State<ShowDetail> {
  ProductModel productModel;
  UserModel userModels;

  String idShop;

  @override
  void initState() {
    super.initState();
    setState(() {
      productModel = widget.productModel;
      print('url ==> ${productModel.image}');
      readSeller();
    });
  }

  Future<Null> readSeller() async {
    idShop = productModel.idshop;

    String url =
        '${MyConstant().domain}/k6app/getproductWhereidShop.php?isAdd=true&id=$idShop';
    Response response = await Dio().get(url);

    var result = json.decode(response.data);
    print('result = $result');

    for (var map in result) {
      UserModel userModel = UserModel.fromJson(map);

      print('NameShop = ${userModel.nameshop}');
      setState(() {
        userModels = (userModel);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: productModel == null
              ? Text('รายละเอียด')
              : Text(productModel.nameproduct),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(5),
          child: Column(
            children: <Widget>[
              userModels == null
                  ? MyStyle().showLinearProgress()
                  : showDetailProduct(),
              MyStyle().mySizebox(),
              MyStyle().mySizebox(),
            ],
          ),
        ));
  }

  Widget showImage() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Image.network(
          '${MyConstant().domain}/${productModel.image}',
          fit: BoxFit.contain,
        ));
  }

  Widget showMap() {
    double lat = double.parse(userModels?.lat);
    double lng = double.parse(userModels?.lng);
    print('lat = $lat, lng = $lng');

    LatLng latLng = LatLng(lat, lng);
    CameraPosition position = CameraPosition(
      target: latLng,
      zoom: 16,
    );

    return Container(
      height: 250,
      child: GoogleMap(
        initialCameraPosition: position,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
        markers: shopMarker(),
      ),
    );
  }

  Set<Marker> shopMarker() {
    return <Marker>[
      Marker(
          markerId: MarkerId('shopID'),
          position: LatLng(
            double.parse(userModels?.lat),
            double.parse(userModels?.lng),
          ),
          infoWindow: InfoWindow(
              title: 'ตำแหน่งร้าน',
              snippet: 'ร้าน : ${userModels?.nameshop ?? 'กำลังโหลด'}'))
    ].toSet();
  }

  Widget showDetailProduct() => Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            showImage(),
            MyStyle().mySizebox(),
            MyStyle().showTitle(productModel.nameproduct),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    '${productModel.price} ฿',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            MyStyle().mySizebox(),
            Row(
              children: [
                MyStyle().showTitleH2('รายละเอียด: '),
              ],
            ),
            Text(
              productModel.detail,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            MyStyle().mySizebox(),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        MyStyle().showTitleH2('ร้าน: '),
                        Text(
                          '${userModels?.nameshop ?? 'กำลังโหลด'}',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        MyStyle().showTitleH2('เบอร์โทร: '),
                        Text(
                          '${userModels?.phone ?? 'กำลังโหลด'}',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                    height: 50, child: VerticalDivider(color: Colors.black)),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.chat,
                    size: 30,
                  ),
                ),
                MyStyle().mySizebox(),
                Text(
                  'แชท',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            MyStyle().mySizebox(),
            Row(
              children: [
                MyStyle().showTitleH2('ตำแหน่งร้าน: '),
              ],
            ),
            showMap(),
          ]));
}
