import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:k6_app/models/seller_model.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';
import 'package:k6_app/utility/normal_dialog.dart';

class AddInfoShop extends StatefulWidget {
  AddInfoShop({required this.sellerModel});
  final SellerModel sellerModel;
  @override
  _AddInfoShopState createState() => _AddInfoShopState();
}

class _AddInfoShopState extends State<AddInfoShop> {
  SellerModel? sellerModel;
  double? lat, long;
  String? nameShop, image, idseller;
  File? file;

  @override
  void initState() {
    super.initState();
    checkPermission();
    sellerModel = widget.sellerModel;
  }

  Future<Null> checkPermission() async {
    bool locationService;
    LocationPermission locationPermission;

    locationService = await Geolocator.isLocationServiceEnabled();
    if (locationService) {
      print('Service Location Open');

      locationPermission = await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.deniedForever) {
          alertLocationService(
              context, 'ไม่อนุญาติแชร์ Location', 'โปรดแชร์ Location');
        } else {
          // Find LatLang
          findLatLng();
        }
      } else {
        if (locationPermission == LocationPermission.deniedForever) {
          alertLocationService(
              context, 'ไม่อนุญาติแชร์ Location', 'โปรดแชร์ Location');
        } else {
          findLatLng();
        }
      }
    } else {
      print('Service Location Close');
      alertLocationService(context, 'Location Service ปิดอยู่ ?',
          'กรุณาเปิด Location Service ด้วยคะ');
    }
  }

  Future<Null> findLatLng() async {
    print('findLatLan ==> Work');
    Position? position = await findPostion();
    setState(() {
      lat = position!.latitude;
      long = position.longitude;
      print('lat = $lat, lng = $long');
    });
  }

  Future<Position?> findPostion() async {
    Position position;
    try {
      position = await Geolocator.getCurrentPosition();
      return position;
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
            lat == null ? MyStyle().showProgress() : showMap(),
            Text(lat.toString()),
            Text(long.toString()),
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
        labelText: 'ชื่อร้าน',
      ),
    );
  }

  Column groupImage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 200,
          height: 200,
          child: file == null
              ? Image.asset('images/myshop.png')
              : Image.file(file!),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () => chooseImage(ImageSource.camera),
              label: Text('ถ่ายภาพ'),
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.image),
              onPressed: () => chooseImage(ImageSource.gallery),
              label: Text('เลือกจากคลัง'),
            ),
          ],
        ),
      ],
    );
  }

  Future<Null> chooseImage(ImageSource imageSource) async {
    try {
      var object = await ImagePicker().pickImage(
        source: imageSource,
        maxHeight: 800.0,
        maxWidth: 800.0,
      );

      setState(() {
        file = File(object!.path);
      });
    } catch (e) {}
  }

  Set<Marker> myMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId('myShop'),
        position: LatLng(lat!, long!),
        infoWindow: InfoWindow(
          title: 'ร้านของคุณ',
          snippet: 'ละติจูด = $lat, ลองติจูต = $long',
        ),
      )
    ].toSet();
  }

  Container showMap() {
    LatLng latLng = LatLng(lat!, long!);
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
        if (nameShop == null || nameShop!.isEmpty) {
          normalDialog(context, 'โปรดกรอกให้ครบทุกช่องด้วย');
        } else if (file == null) {
          normalDialog(context, 'โปรดเลือกรูปภาพด้วย');
        } else {
          uploadImage();
        }
      },
    );
  }

  Future<Null> uploadImage() async {
    Random random = Random();
    int i = random.nextInt(1000000);
    String nameImage = 'shop$i.jpg';
    print('nameImage = $nameImage, pathImage = ${file!.path}');

    String url = '${MyConstant().domain}/projectk6/saveshop.php';

    try {
      Map<String, dynamic> map = Map();
      map['file'] =
          await MultipartFile.fromFile(file!.path, filename: nameImage);

      FormData formData = FormData.fromMap(map);
      await Dio().post(url, data: formData).then((value) {
        print('Response ===>>> $value');
        image = '/projectk6/Image/shop/$nameImage';
        print('urlImage = $image');
        addSHOP();
      });
    } catch (e) {}
  }

  Future<Null> addSHOP() async {
    idseller = sellerModel?.idSeller;

    String url =
        '${MyConstant().domain}/projectk6/addShop.php?isAdd=true&id_seller=$idseller&nameshop=$nameShop&image=$image&lat=$lat&long=$long';

    try {
      Response response = await Dio().get(url);
      print('res = $response');

      if (response.toString() == 'true') {
        Navigator.pop(context);
      } else {
        normalDialog(context, 'ผิดพลาดโปรดลองอีกครั้ง');
      }
    } catch (e) {}
  }
}
