import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:k6_app/utility/my_style.dart';
import 'package:k6_app/utility/normal_dialog.dart';

class AddProduct extends StatefulWidget {
  AddProduct({Key key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String nameProduct, price, detail;
  File file;
  double screen;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มรายการสินค้า'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
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
            saveButton(),
            MyStyle().mySizebox(),
          ],
        ),
      ),
    );
  }

  ElevatedButton saveButton() {
    return ElevatedButton(
      child: Text('บันทึกข้อมูล'),
      onPressed: () {
        if (nameProduct == null ||
            nameProduct.isEmpty ||
            price == null ||
            price.isEmpty ||
            detail == null ||
            detail.isEmpty) {
          normalDialog(context, 'โปรดกรอกให้ครบทุกช่องด้วย');
        } else if (file == null) {
          normalDialog(context, 'โปรดเลือกรูปภาพด้วย');
        } else {
          print('nameproduct : $nameProduct, price : $price, detail : $detail');
        }
      },
    );
  }

  TextFormField nameForm() {
    return TextFormField(
      onChanged: (value) => nameProduct = value.trim(),
      decoration: InputDecoration(
        icon: Icon(
          Icons.shopping_bag_outlined,
          color: Colors.teal.shade500,
        ),
        labelText: 'ชื่อสินค้า :',
        labelStyle: TextStyle(color: MyStyle().tealColor),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyStyle().tealColor),
        ),
      ),
    );
  }

  TextFormField priceForm() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onChanged: (value) => price = value.trim(),
      decoration: InputDecoration(
        icon: Icon(
          Icons.attach_money,
          color: Colors.teal.shade500,
        ),
        labelText: 'ราคาสินค้า :',
        labelStyle: TextStyle(color: MyStyle().tealColor),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyStyle().tealColor),
        ),
      ),
    );
  }

  TextFormField detailForm() {
    return TextFormField(
      onChanged: (value) => detail = value.trim(),
      keyboardType: TextInputType.multiline,
      maxLines: 3,
      decoration: InputDecoration(
        icon: Icon(
          Icons.details,
          color: Colors.teal.shade500,
        ),
        labelText: 'รายละเอียดสินค้า :',
        labelStyle: TextStyle(color: MyStyle().tealColor),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyStyle().tealColor),
        ),
      ),
    );
  }

  Column groupImage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 500.0,
          height: 200.0,
          child: file == null
              ? Image.asset('images/productmenu.png')
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
            ),
          ],
        ),
      ],
    );
  }

  Future<Null> chooseImage(ImageSource source) async {
    try {
      var object = await ImagePicker().getImage(
        source: source,
        maxWidth: 800.0,
        maxHeight: 800.0,
      );
      setState(() {
        file = File(object.path);
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
