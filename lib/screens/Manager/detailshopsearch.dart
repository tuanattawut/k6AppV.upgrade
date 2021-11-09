import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:k6_app/models/shop_model.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';

class DetailshopSearch extends StatefulWidget {
  DetailshopSearch({required this.shopModel});
  final ShopModel shopModel;
  @override
  _DetailshopSearchState createState() => _DetailshopSearchState();
}

class _DetailshopSearchState extends State<DetailshopSearch> {
  ShopModel? shopModel;

  String? idseller;
  @override
  void initState() {
    super.initState();
    shopModel = widget.shopModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข้อมูลร้านค้า'),
      ),
      body: showListInfoShop(),
    );
  }

  Widget showListInfoShop() => Padding(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                MyStyle().showTitle('รูปร้าน'),
              ],
            ),
            MyStyle().mySizebox(),
            showImage(),
            Row(
              children: <Widget>[
                MyStyle().showTitle('ชื่อร้าน'),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  shopModel!.nameshop,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            MyStyle().mySizebox(),
            Row(
              children: [
                MyStyle().showTitle('ตำแหน่งร้าน: '),
              ],
            ),
            showMap(),
          ],
        ),
      ));

  Widget showImage() {
    print(shopModel?.image);
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Image.network(
          '${MyConstant().domain}/upload/shop/${shopModel?.image}',
          fit: BoxFit.contain,
        ));
  }

  Widget showMap() {
    double lat = double.parse('${shopModel?.lat ?? '0'}');
    double lng = double.parse('${shopModel?.lng ?? '0'}');
    //print('lat = $lat, lng = $long');

    LatLng latLng = LatLng(lat, lng);
    CameraPosition position = CameraPosition(target: latLng, zoom: 19);

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
            double.parse('${shopModel?.lat ?? '0'}'),
            double.parse('${shopModel?.lng ?? '0'}'),
          ),
          infoWindow: InfoWindow(
              title: 'ตำแหน่งร้าน', snippet: 'ร้าน : ${shopModel?.nameshop}'))
    ].toSet();
  }
}
