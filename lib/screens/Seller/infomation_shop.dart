import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:k6_app/models/seller_model.dart';
import 'package:k6_app/models/shop_model.dart';
import 'package:k6_app/screens/Seller/add_info_seller.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';

class InformationShop extends StatefulWidget {
  InformationShop({required this.sellerModel});
  final SellerModel sellerModel;
  @override
  _InformationShopState createState() => _InformationShopState();
}

class _InformationShopState extends State<InformationShop> {
  SellerModel? sellerModel;
  ShopModel? shopModels;

  String? idseller;
  @override
  void initState() {
    super.initState();
    sellerModel = widget.sellerModel;
    readDataShop();
  }

  Future<Null> readDataShop() async {
    idseller = sellerModel?.idSeller;

    String url =
        '${MyConstant().domain}/api/getShopfromidSeller.php?isAdd=true&id_seller=$idseller';
    Response response = await Dio().get(url);

    var result = json.decode(response.data);
    // print('result = $result');

    if (result != null) {
      for (var map in result) {
        setState(() {
          shopModels = ShopModel.fromMap(map);
        });
      }
    } else {
      routeToAddInfo();
    }
  }

  void routeToAddInfo() {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => AddInfoShop(
        sellerModel: sellerModel!,
      ),
    );
    Navigator.of(context).pushReplacement(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข้อมูลร้านค้า'),
      ),
      body: shopModels == null ? MyStyle().showProgress() : showListInfoShop(),
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
                  shopModels!.nameshop,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                MyStyle().showTitle('เบอร์โทร'),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  sellerModel!.phone,
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
    print(shopModels?.image);
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Image.network(
          '${MyConstant().domain}/upload/shop/${shopModels?.image}',
          fit: BoxFit.contain,
        ));
  }

  Widget showMap() {
    double lat = double.parse('${shopModels?.lat ?? '0'}');
    double lng = double.parse('${shopModels?.lng ?? '0'}');
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
            double.parse('${shopModels?.lat ?? '0'}'),
            double.parse('${shopModels?.lng ?? '0'}'),
          ),
          infoWindow: InfoWindow(
              title: 'ตำแหน่งร้าน', snippet: 'ร้าน : ${shopModels?.nameshop}'))
    ].toSet();
  }

  Row addAndEditButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 280, right: 20),
              child: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () => routeToAddInfo(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
