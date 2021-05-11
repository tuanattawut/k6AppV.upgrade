import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:k6_app/utility/my_style.dart';
import 'package:k6_app/utility/normal_dialog.dart';
import 'package:location/location.dart';

class AddInfoSeller extends StatefulWidget {
  @override
  _AddInfoSellerState createState() => _AddInfoSellerState();
}

class _AddInfoSellerState extends State<AddInfoSeller> {
  double lat, lng;
  String nameShop, phonenumber, urlImage;
  File file;

  @override
  void initState() {
    super.initState();
    findLatLng();
  }

  Future<Null> findLatLng() async {
    LocationData locationData = await findLocationData();
    setState(() {
      lat = locationData.latitude;
      lng = locationData.longitude;
    });
    print('lat = $lat, lng = $lng');
  }

  Future<LocationData> findLocationData() async {
    Location location = Location();
    try {
      return location.getLocation();
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มข้อมูลร้านผู้ขาย'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            MyStyle().mySizebox(),
            groupImage(),
            MyStyle().mySizebox(),
            nameForm(),
            MyStyle().mySizebox(),
            phoneForm(),
            MyStyle().mySizebox(),
            lat == null ? MyStyle().showProgress() : showMap(),
            MyStyle().mySizebox(),
            saveButton(),
            MyStyle().mySizebox(),
          ],
        ),
      ),
    );
  }

  TextFormField nameForm() {
    return TextFormField(
      onChanged: (value) => nameShop = value.trim(),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'ชื่อร้านค้า',
        icon: Icon(Icons.shopping_bag),
      ),
    );
  }

  TextFormField phoneForm() {
    return TextFormField(
        onChanged: (value) => phonenumber = value.trim(),
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            labelText: 'เบอร์โทรศัพท์', icon: Icon(Icons.phone)));
  }

  Column groupImage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 250.0,
          child: file == null
              ? Image.asset('images/myimage.png')
              : Image.file(file),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(
                Icons.add_a_photo,
                size: 40.0,
                color: Colors.teal.shade500,
              ),
              onPressed: () => chooseImage(ImageSource.camera),
            ),
            IconButton(
              icon: Icon(
                Icons.add_photo_alternate,
                size: 40.0,
                color: Colors.teal.shade500,
              ),
              onPressed: () => chooseImage(ImageSource.gallery),
            )
          ],
        ),
      ],
    );
  }

  Future<Null> chooseImage(ImageSource imageSource) async {
    try {
      var object = await ImagePicker().getImage(
        source: imageSource,
        maxHeight: 800.0,
        maxWidth: 800.0,
      );

      setState(() {
        file = File(object.path);
      });
    } catch (e) {}
  }

  Set<Marker> myMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId('myShop'),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(
          title: 'ร้านของคุณ',
          snippet: 'ละติจูด = $lat, ลองติจูต = $lng',
        ),
      )
    ].toSet();
  }

  Container showMap() {
    LatLng latLng = LatLng(lat, lng);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 15.0,
    );
    return Container(
        height: 300.0,
        child: GoogleMap(
          initialCameraPosition: cameraPosition,
          mapType: MapType.normal,
          onMapCreated: (controller) {},
          markers: myMarker(),
        ));
  }

  ElevatedButton saveButton() {
    return ElevatedButton(
      child: Text('บันทึกข้อมูล'),
      onPressed: () {
        if (nameShop == null ||
            nameShop.isEmpty ||
            phonenumber == null ||
            phonenumber.isEmpty) {
          normalDialog(context, 'โปรดกรอกให้ครบทุกช่องด้วย');
        } else if (file == null) {
          normalDialog(context, 'โปรดเลือกรูปภาพด้วย');
        } else {}
      },
    );
  }

  Future<Null> uploadImage() async {
    Random random = Random();
    int i = random.nextInt(1000000);
    String nameImage = 'shop$i.jpg';
    print('nameImage = $nameImage, pathImage = ${file.path}');

    String url = 'ลิงค์ API';

    try {
      Map<String, dynamic> map = Map();
      map['file'] =
          await MultipartFile.fromFile(file.path, filename: nameImage);

      FormData formData = FormData.fromMap(map);
      await Dio().post(url, data: formData).then((value) {
        print('Response ===>>> $value');
        urlImage = 'ลิงค์ดึงมาทำ URL';
        print('urlImage = $urlImage');
        // editUserShop();
      });
    } catch (e) {}
  }
}
