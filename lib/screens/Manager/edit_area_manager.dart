import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:k6_app/models/area_model.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';
import 'package:k6_app/utility/normal_dialog.dart';

class Editarea extends StatefulWidget {
  final AreaModel areaModel;
  Editarea({required this.areaModel});

  @override
  _EditareaState createState() => _EditareaState();
}

class _EditareaState extends State<Editarea> {
  AreaModel? areaModel;
  File? file;
  String? namearea, image, detail, scale, rentalfee, idArea;
  List<Marker> myMarker = [];
  double? lat, lng;
  @override
  void initState() {
    super.initState();
    areaModel = widget.areaModel;
    namearea = areaModel!.namearea;
    image = areaModel!.image;
    detail = areaModel!.detail;
    scale = areaModel!.scale;
    rentalfee = areaModel!.rentalfee;
    idArea = areaModel!.idArea;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('แก้ไขแผง $namearea'),
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
                detailForm(),
                MyStyle().mySizebox(),
                scaleForm(),
                MyStyle().mySizebox(),
                priceForm(),
                MyStyle().mySizebox(),
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
      onChanged: (value) => namearea = value.trim(),
      initialValue: namearea,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'ชื่อแผงร้านค้า',
      ),
    );
  }

  TextFormField detailForm() {
    return TextFormField(
      onChanged: (value) => detail = value.trim(),
      initialValue: detail,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'รายละเอียดแผงร้านค้า',
      ),
    );
  }

  TextFormField scaleForm() {
    return TextFormField(
      onChanged: (value) => scale = value.trim(),
      initialValue: scale,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'ขนาดแผงร้านค้า',
      ),
    );
  }

  TextFormField priceForm() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onChanged: (value) => rentalfee = value.trim(),
      initialValue: rentalfee,
      decoration: InputDecoration(
        labelText: 'ราคาค่าเช่าเเผงร้านค้า :',
        suffixText: 'บาท',
      ),
    );
  }

  Column groupImage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          child: file == null
              ? Image.network(
                  '${MyConstant().domain}/images/areasshop/$image',
                  fit: BoxFit.cover,
                )
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
        maxHeight: 800,
        maxWidth: 800,
      );

      setState(() {
        file = File(object!.path);
      });
    } catch (e) {}
  }

  ElevatedButton saveButton() {
    return ElevatedButton(
      child: Text('แก้ไขข้อมูล'),
      onPressed: () {
        if (namearea == null ||
            namearea!.isEmpty ||
            detail == null ||
            detail!.isEmpty ||
            scale == null ||
            scale!.isEmpty ||
            rentalfee == null ||
            rentalfee!.isEmpty) {
          normalDialog(context, 'โปรดกรอกให้ครบทุกช่องด้วย');
        } else {
          confirmEdit();
        }
      },
    );
  }

  Future<Null> confirmEdit() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('คุณต้องการเปลี่ยนแปลงข้อมูลสินค้า ?'),
        children: <Widget>[
          Row(
            children: <Widget>[
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  uploadImage();
                },
                icon: Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                label: Text('เปลี่ยนแปลง'),
              ),
              TextButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.clear,
                  color: Colors.red,
                ),
                label: Text('ไม่เปลี่ยนแปลง'),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<Null> editValueOnMySQL() async {
    String url =
        '${MyConstant().domain}/api/editArea.php?isAdd=true&namearea=$namearea&image=$image&detail=$detail&scale=$scale&rentalfee=$rentalfee&id_area=$idArea';
    await Dio().get(url).then((value) {
      if (value.toString() == 'true') {
        Navigator.pop(context);
      } else {
        normalDialog(context, 'กรุณาลองใหม่ มีอะไร ? ผิดพลาด');
      }
    });
  }

  Future<Null> uploadImage() async {
    Random random = Random();
    int i = random.nextInt(1000000);
    String nameImage = 'area_$i.jpg';
    //print('nameImage = $nameImage, pathImage = ${file!.path}');

    String url = '${MyConstant().domain}/upload/saveImageArea.php';

    try {
      Map<String, dynamic> map = Map();
      map['file'] =
          await MultipartFile.fromFile(file!.path, filename: nameImage);

      FormData formData = FormData.fromMap(map);
      await Dio().post(url, data: formData).then((value) async {
        // print('Response ===>>> $value');
        image = '$nameImage';
        //print('urlImage = $image');
        await editValueOnMySQL();
      });
    } catch (e) {}
  }
}
