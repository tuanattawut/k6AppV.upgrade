import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:k6_app/screens/Seller/add_info_seller.dart';
import 'package:k6_app/utility/my_style.dart';

class InformationSeller extends StatefulWidget {
  InformationSeller({Key key}) : super(key: key);

  @override
  _InformationSellerState createState() => _InformationSellerState();
}

class _InformationSellerState extends State<InformationSeller> {
  @override
  void initState() {
    super.initState();
  }

  Future<Null> readDataUser() async {
    print('ดึงข้อมูลมาใช้งาน');
  }

  void routeToAddInfo() {
    MaterialPageRoute materialPageRoute = MaterialPageRoute(
      builder: (context) => AddInfoSeller(),
    );
    Navigator.push(context, materialPageRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        showListInfoShop(),
        addAndEditButton(),
      ],
    );
  }

  Widget showListInfoShop() => Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            MyStyle().showTitleH2('รายละเอียดผู้ขาย '),
            showImage(),
            Row(
              children: <Widget>[
                MyStyle().showTitleH2('ชื่อร้าน'),
              ],
            ),
            Row(
              children: <Widget>[
                Text('จารย์ แดง Shop'),
              ],
            ),
            Row(
              children: <Widget>[
                MyStyle().showTitleH2('เบอร์โทร'),
              ],
            ),
            Row(
              children: <Widget>[
                Text('0123456789'),
              ],
            ),
            MyStyle().mySizebox(),
            showMap(),
          ],
        ),
      );

  Container showImage() {
    return Container(
      width: 200.0,
      height: 200.0,
      child: Image.network(
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdSLfLgOudHj-ezyrcSxCgSUlw-uUz4qaYZg&usqp=CAU'),
    );
  }

  Widget showMap() {
    double lat = double.parse('14.036656358272781');
    double lng = double.parse('100.73584338182013');
    print('lat = $lat, lng = $lng');

    LatLng latLng = LatLng(lat, lng);
    CameraPosition position = CameraPosition(target: latLng, zoom: 15.0);

    return Expanded(
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

  Row addAndEditButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
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
