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
            MyStyle().showTitle('รายละเอียดผู้ขาย '),
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
                  'TEST SELLER SHOP',
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
                  '0000000000',
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
      );

  Widget showImage() {
    return Center(
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(
            "https://image.shutterstock.com/image-vector/fruit-seller-selling-apples-oranges-600w-795476500.jpg"),
        radius: 70,
      ),
    );
  }

  Widget showMap() {
    double lat = double.parse('14.036656358272781');
    double lng = double.parse('100.73584338182013');
    print('lat = $lat, lng = $lng');

    LatLng latLng = LatLng(lat, lng);
    CameraPosition position = CameraPosition(target: latLng, zoom: 15.0);

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
