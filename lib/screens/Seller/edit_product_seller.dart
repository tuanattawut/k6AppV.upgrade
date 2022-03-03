import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:k6_app/models/product_models.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';
import 'package:k6_app/utility/normal_dialog.dart';

class EditProduct extends StatefulWidget {
  final ProductModel productModel;
  EditProduct({required this.productModel});

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  ProductModel? productModel;
  File? file;
  String? nameProduct, price, detail, image, idcategory;

  @override
  void initState() {
    super.initState();
    productModel = widget.productModel;
    nameProduct = productModel!.nameproduct;
    price = productModel!.price;
    detail = productModel!.detail;
    image = productModel!.image;
    idcategory = productModel!.idSubcategory;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขสินค้า ${productModel!.nameproduct}'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Column(
            children: <Widget>[
              showTitleFood('รูปสินค้า'),
              groupImage(),
              showTitleFood('รายละเอียดสินค้า'),
              nameForm(),
              MyStyle().mySizebox(),
              detailForm(),
              MyStyle().mySizebox(),
              priceForm(),
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
        if (nameProduct!.isEmpty || price!.isEmpty || detail!.isEmpty) {
          normalDialog(context, 'กรุณากรอกให้ครบ ทุกช่อง');
        } else {
          confirmEdit();
        }
      },
      child: Icon(Icons.save),
    );
  }

  // Future<Null> uploadImage() async {
  //   Random random = Random();
  //   int i = random.nextInt(1000000);
  //   String nameImage = 'product_$i.jpg';
  //   //print('nameImage = $nameImage, pathImage = ${file!.path}');

  //   String url = '${MyConstant().domain}/upload/saveImageProduct.php';

  //   try {
  //     Map<String, dynamic> map = Map();
  //     map['file'] =
  //         await MultipartFile.fromFile(file!.path, filename: nameImage);

  //     FormData formData = FormData.fromMap(map);
  //     await Dio().post(url, data: formData).then((value) async {
  //       // print('Response ===>>> $value');
  //       image = '$nameImage';
  //       // print('urlImage = $image');
  //       await editValueOnMySQL();
  //     });
  //   } catch (e) {}
  // }

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
                  editValueOnMySQL();
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
    String id = productModel!.id.toString();
    String url =
        '${MyConstant().domain}/api/editProduct.php?isAdd=true&nameproduct=$nameProduct&detail=$detail&price=$price&id_products=$id';
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
                  '${MyConstant().domain}/images/products_seller/$image',
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

  TextFormField nameForm() {
    return TextFormField(
      onChanged: (value) => nameProduct = value.trim(),
      initialValue: nameProduct,
      decoration: InputDecoration(
        labelText: 'ชื่อสินค้า :',
      ),
    );
  }

  TextFormField priceForm() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onChanged: (value) => price = value.trim(),
      initialValue: price,
      decoration: InputDecoration(
        labelText: 'ราคาสินค้า :',
        suffixText: 'บาท',
      ),
    );
  }

  TextFormField detailForm() {
    return TextFormField(
      onChanged: (value) => detail = value.trim(),
      keyboardType: TextInputType.multiline,
      maxLines: 3,
      initialValue: detail,
      decoration: InputDecoration(
        labelText: 'รายละเอียดสินค้า :',
      ),
    );
  }
}
