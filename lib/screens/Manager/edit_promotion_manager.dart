import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:k6_app/models/product_models.dart';
import 'package:k6_app/models/promotion_model.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';
import 'package:k6_app/utility/normal_dialog.dart';

class EditPromotion extends StatefulWidget {
  final PromotionModel promotionModel;
  EditPromotion({required this.promotionModel});

  @override
  _EditPromotionState createState() => _EditPromotionState();
}

class _EditPromotionState extends State<EditPromotion> {
  PromotionModel? promotionModel;
  File? file;
  String? idPromotion, image;

  @override
  void initState() {
    super.initState();
    promotionModel = widget.promotionModel;
    idPromotion = promotionModel!.idPromotion;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขประกาศข่าวสาร'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Column(
            children: <Widget>[
              groupImage(),
              MyStyle().mySizebox(),
              MyStyle().mySizebox(),
              uploadButton(),
              MyStyle().mySizebox(),
            ],
          ),
        ),
      ),
    );
  }

  FloatingActionButton uploadButton() {
    return FloatingActionButton(
      onPressed: () {
        if (file == null) {
          normalDialog(context, 'ไม่ได้เลือกรูปภาพ');
        } else {
          confirmEdit();
        }
      },
      child: Icon(Icons.save),
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
        await editValueOnMySQL();
      });
    } catch (e) {}
  }

  Future<Null> confirmEdit() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('คุณต้องการเปลี่ยนแปลงข้อมูลข่าวสาร ?'),
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
        '${MyConstant().domain}/api/editPromotion.php?isAdd=true&imgUrl=$image&id_promotion=$idPromotion';
    await Dio().get(url).then((value) {
      if (value.toString() == 'true') {
        Navigator.pop(context);
      } else {
        normalDialog(context, 'กรุณาลองใหม่ มีอะไร ? ผิดพลาด');
      }
    });
  }

  Column groupImage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 200,
          height: 200,
          child: file == null
              ? Image.network(
                  '${MyConstant().domain}/upload/promotion/${promotionModel!.imgUrl}',
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
              label: Text('เลือกรูปภาพ'),
            ),
          ],
        ),
      ],
    );
  }

  Future<Null> chooseImage(ImageSource source) async {
    try {
      var object = await ImagePicker().pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );

      setState(() {
        file = File(object!.path);
      });
    } catch (e) {}
  }

  Widget showTitleFood(String string) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          MyStyle().showTitleH2(string),
        ],
      ),
    );
  }
}
