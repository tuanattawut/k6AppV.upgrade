import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:k6_app/utility/my_style.dart';

class AddProduct extends StatefulWidget {
  AddProduct({Key key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String nameFood, price, detail;
  File file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มรายการสินค้า'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            showTitleFood('รูปสินค้า'),
            groupImage(),
            showTitleFood('รายละเอียดสินค้า'),
            nameForm(),
            MyStyle().mySizebox(),
            priceForm(),
            MyStyle().mySizebox(),
            detailForm(),
            MyStyle().mySizebox(),
          ],
        ),
      ),
    );
  }

  TextFormField nameForm() {
    return TextFormField(
      onChanged: (value) => nameFood = value.trim(),
      decoration: InputDecoration(
        icon: Icon(Icons.fastfood),
        labelText: 'ชื่อสินค้า',
      ),
    );
  }

  TextFormField priceForm() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onChanged: (value) => price = value.trim(),
      decoration: InputDecoration(
        icon: Icon(Icons.attach_money),
        labelText: 'ราคาสินค้า',
      ),
    );
  }

  TextFormField detailForm() {
    return TextFormField(
      onChanged: (value) => detail = value.trim(),
      keyboardType: TextInputType.multiline,
      maxLines: 3,
      decoration: InputDecoration(
        icon: Icon(Icons.details),
        labelText: 'รายละเอียดสินค้า',
      ),
    );
  }

  Row groupImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.add_a_photo),
          onPressed: () => chooseImage(ImageSource.camera),
        ),
        Container(
          width: 250.0,
          height: 250.0,
          child: file == null
              ? Image.asset('images/productmenu.png')
              : Image.file(file),
        ),
        IconButton(
          icon: Icon(Icons.add_photo_alternate),
          onPressed: () => chooseImage(ImageSource.gallery),
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
