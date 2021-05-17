import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:k6_app/models/product_models.dart';
import 'package:k6_app/utility/my_style.dart';

class ShowDetail extends StatefulWidget {
  @override
  _ShowDetailState createState() => _ShowDetailState();
}

class _ShowDetailState extends State<ShowDetail> {
  ProductModels productModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: productModel == null
              ? Text('รายละเอียด')
              : Text('Show ${productModel.name}'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
              showDetailProduct(),
            ],
          ),
        ));
  }

  Widget showImage() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Image.network(
          'https://www.taokaecafe.com/asp-bin/pic_taokae/sh2308.jpg'),
    );
  }

  Widget showMap() {
    double lat = double.parse('14.036656358272781');
    double lng = double.parse('100.73584338182013');
    print('lat = $lat, lng = $lng');

    LatLng latLng = LatLng(lat, lng);
    CameraPosition position = CameraPosition(
      target: latLng,
      zoom: 15.0,
    );

    return Container(
      height: 300.0,
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
            double.parse('14.036656358272781'),
            double.parse('100.73584338182013'),
          ),
          infoWindow:
              InfoWindow(title: 'ตำแหน่งร้าน', snippet: 'ร้าน : แก๊งค์เหลือง'))
    ].toSet();
  }

  Widget showDetailProduct() => Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(children: <Widget>[
        showImage(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MyStyle().showTitle('หมูปิ้ง'),
            MyStyle().showTitle('ราคา 9,999,999 บาท'),
          ],
        ),
        MyStyle().mySizebox(),
        Row(
          children: [
            MyStyle().showTitleH2('รายละเอียด: '),
          ],
        ),
        MyStyle().showTitleH3(
            'ไปเก็บข้าวของที่มันจำเป็น แล้วรีบกระโดดขึ้นรถมา ออกจากเมืองฟ้า ไปอยู่บ้านนอกกับฉันไหม'),
        MyStyle().mySizebox(),
        Row(
          children: [
            MyStyle().showTitle('ร้าน:  '),
            MyStyle().showTitleH3('MHOO PING SHOP'),
          ],
        ),
        Row(
          children: [
            MyStyle().showTitle('เบอร์โทร:  '),
            MyStyle().showTitleH3('0912345678'),
          ],
        ),
        Row(
          children: [
            MyStyle().showTitle('ตำแหน่งร้าน'),
          ],
        ),
        showMap(),
      ]));
}
