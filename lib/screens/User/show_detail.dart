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
    print('ทำตรงนี้ก่อน');
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
          padding: EdgeInsets.all(5),
          child: Column(
            children: <Widget>[
              showDetailProduct(),
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
          'https://food.mthai.com/app/uploads/2017/09/Grilled-Pork-Sticks.jpg'),
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

  Widget showDetailProduct() => Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(children: <Widget>[
        showImage(),
        MyStyle().mySizebox(),
        MyStyle().showTitle(
            'หมูปิ้งหมูปิ้งหมูปิ้งหมูปิ้งหมูปิ้งหมูปิ้งหมูปิ้งหมูปิ้งหมูปิ้งหมูปิ้งหมูปิ้งหมูปิ้งหมูปิ้งหมูปิ้งหมูปิ้งหมูปิ้งหมูปิ้งหมูปิ้ง'),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                '9,999,999 บาท',
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
          'ไปเก็บข้าวของที่มันจำเป็น แล้วรีบกระโดดขึ้นรถมา ออกจากเมืองฟ้า ไปอยู่บ้านนอกกับฉันไหม',
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
                      'MHOO PING SHOP',
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
                      '0912345678',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
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
