import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:k6_app/models/seller_model.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';
import 'package:k6_app/utility/normal_dialog.dart';

class AddPromotionSeller extends StatefulWidget {
  AddPromotionSeller({required this.sellerModel});
  final SellerModel sellerModel;
  @override
  _AddPromotionSellerState createState() => _AddPromotionSellerState();
}

class _AddPromotionSellerState extends State<AddPromotionSeller> {
  SellerModel? sellerModel;
  String? idSeller, detailpromotion, image, status = 'no';
  File? file;
  @override
  void initState() {
    super.initState();
    sellerModel = widget.sellerModel;
    idSeller = sellerModel!.idSeller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มโปรโมชั่น'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Column(
            children: <Widget>[
              MyStyle().mySizebox(),
              groupImage(),
              MyStyle().mySizebox(),
              nameForm(),
              MyStyle().mySizebox(),
              saveButton(),
              MyStyle().mySizebox(),
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> uploadImage() async {
    Random random = Random();
    int i = random.nextInt(1000000);
    String nameImage = 'Promotion_$i.jpg';
    //print('nameImage = $nameImage, pathImage = ${file!.path}');

    String url = '${MyConstant().domain}/upload/savePromotion.php';

    try {
      Map<String, dynamic> map = Map();
      map['file'] =
          await MultipartFile.fromFile(file!.path, filename: nameImage);

      FormData formData = FormData.fromMap(map);
      await Dio().post(url, data: formData).then((value) async {
        // print('Response ===>>> $value');
        image = '$nameImage';
        // print('urlImage = $image');
        await addPromotion();
      });
    } catch (e) {}
  }

  Future<Null> addPromotion() async {
    String url =
        '${MyConstant().domain}/api/addPromotionseller.php?isAdd=true&detailpromotion=$detailpromotion&image=$image&status=$status&id_seller=$idSeller';
    await Dio().get(url).then((value) {
      if (value.toString() == 'true') {
        Navigator.pop(context);
      } else {
        normalDialog(context, 'กรุณาลองใหม่ มีอะไร ? ผิดพลาด');
      }
    });
  }

  ElevatedButton saveButton() {
    return ElevatedButton(
      child: Text('บันทึกข้อมูล'),
      onPressed: () {
        if (detailpromotion == null || detailpromotion!.isEmpty) {
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

  TextFormField nameForm() {
    return TextFormField(
      onChanged: (value) => detailpromotion = value.trim(),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'รายละเอียดโปรโมชั่น',
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
          child:
              file == null ? Image.asset('images/sale.png') : Image.file(file!),
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
}
