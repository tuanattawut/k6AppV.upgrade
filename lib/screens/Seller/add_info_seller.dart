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
  double? lat, lng;
  String? nameShop, image, idseller;
  File? file;
  List<Marker> myMarker = [];
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
      // print('Service Location Open');

      locationPermission = await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.deniedForever) {
          alertLocationService(
              context, 'ไม่อนุญาติแชร์ Location', 'โปรดแชร์ Location');
        } else {
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
      // print('Service Location Close');
      alertLocationService(context, 'Location Service ปิดอยู่ ?',
          'กรุณาเปิด Location Service ด้วยคะ');
    }
  }

  Future<Null> findLatLng() async {
    //print('findLatLan ==> Work');
    // Position? position = await findPostion();
    setState(() {
      // lat = position!.latitude;
      // lng = position.longitude;
      //print('lat = $lat, lng = $lng');
      lat = 14.028483806025148;
      lng = 100.7294029298289;
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
          title: Text('เพิ่มข้อมูลร้านค้า'),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                MyStyle().mySizebox(),
                groupImage(),
                MyStyle().mySizebox(),
                nameForm(),
                MyStyle().mySizebox(),
                Row(
                  children: [
                    Text(
                      '**เลือกตำแหน่งร้านค้าในแผนที่**',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ],
                ),
                buildMap(),
                MyStyle().mySizebox(),
                saveButton(),
                MyStyle().mySizebox(),
              ],
            ),
          ),
        ));
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
          width: 150,
          height: 150,
          child: file == null
              ? Image.asset('images/myshop.png')
              : Image.file(file!),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () => chooseImage(ImageSource.camera),
              label: Text('ถ่ายภาพ'),
            ),
            TextButton.icon(
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
        maxHeight: 800,
        maxWidth: 800,
      );

      setState(() {
        file = File(object!.path);
      });
    } catch (e) {
      print('ผิดพลาด >> {$e}');
    }
  }

  // Set<Marker> setMarker() => <Marker>[
  //       Marker(
  //         markerId: MarkerId('id'),
  //         position: LatLng(lat!, lng!),
  //         infoWindow: InfoWindow(
  //             title: 'ร้านของคุณ', snippet: 'Lat = $lat, lng = $lng'),
  //       ),
  //     ].toSet();

  Widget buildMap() => Container(
        width: double.infinity,
        height: 300,
        child: lat == null
            ? MyStyle().showProgress()
            : GoogleMap(
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat!, lng!),
                  zoom: 16,
                ),
                onMapCreated: (controller) {},
                markers: Set.from(myMarker),
                onTap: _handleTap,
              ),
      );

  _handleTap(LatLng tappedPoint) {
    lat = tappedPoint.latitude;
    lng = tappedPoint.longitude;

    print('Lat = $lat  lng = $lng');
    setState(() {
      myMarker = [];
      myMarker.add(
        Marker(markerId: MarkerId('mark'), position: tappedPoint),
      );
    });
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
          showLoade(context);
          uploadImage();
        }
      },
    );
  }

  Future<Null> uploadImage() async {
    Random random = Random();
    int i = random.nextInt(1000000);
    String nameImage = 'shop_$i.jpg';
    //print('nameImage = $nameImage, pathImage = ${file!.path}');

    String url = '${MyConstant().domain}/images/saveImageShop.php';

    try {
      Map<String, dynamic> map = Map();
      map['file'] =
          await MultipartFile.fromFile(file!.path, filename: nameImage);

      FormData formData = FormData.fromMap(map);
      await Dio().post(url, data: formData).then((value) async {
        // print('Response ===>>> $value');
        image = '$nameImage';
        //print('urlImage = $image');
        await addSHOP();
      });
    } catch (e) {
      //
    }
  }

  Future<Null> addSHOP() async {
    idseller = sellerModel?.idSeller;
    print(
        'idseller = $idseller + nameshop = $nameShop + image = $image + lat = $lat + lng = $lng');
    String url =
        '${MyConstant().domain}/api/addShop.php?isAdd=true&id_seller=$idseller&nameshop=$nameShop&image=$image&lat=$lat&lng=$lng';

    try {
      Response response = await Dio().get(url);
      // print('res = $response');
      Navigator.pop(context);
      if (response.toString() == 'true') {
        Navigator.pop(context);
      } else {
        normalDialog(context, 'ผิดพลาดโปรดลองอีกครั้ง');
      }
    } catch (e) {
      print('ผิดพลาด {$e}');
    }
  }
}
