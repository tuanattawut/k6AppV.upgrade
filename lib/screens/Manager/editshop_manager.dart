import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/shop_model.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';
import 'package:k6_app/utility/normal_dialog.dart';

class EditShopSearch extends StatefulWidget {
  final ShopModel shopModel;
  EditShopSearch({required this.shopModel});

  @override
  _EditShopSearchState createState() => _EditShopSearchState();
}

class _EditShopSearchState extends State<EditShopSearch> {
  ShopModel? shopModel;
  String? nameShop, idShop;
  @override
  void initState() {
    super.initState();
    shopModel = widget.shopModel;
    nameShop = shopModel!.nameshop;
    idShop = shopModel!.id;
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
      initialValue: nameShop,
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
            child: Image.network(
              '${MyConstant().domain}/images/shops_seller/${shopModel?.image}',
              fit: BoxFit.contain,
            )),
      ],
    );
  }

  ElevatedButton saveButton() {
    return ElevatedButton(
      child: Text('แก้ไขข้อมูล'),
      onPressed: () {
        if (nameShop == null || nameShop!.isEmpty) {
          normalDialog(context, 'โปรดกรอกให้ครบทุกช่องด้วย');
        } else {
          confirmEdit();
        }
      },
    );
  }

  Future<Null> editValueOnMySQL() async {
    String url =
        '${MyConstant().domain}/api/editShopmanager.php?isAdd=true&nameshop=$nameShop&id_shop=$idShop';
    await Dio().get(url).then((value) {
      if (value.toString() == 'true') {
        Navigator.pop(context);
      } else {
        normalDialog(context, 'กรุณาลองใหม่ มีอะไร ? ผิดพลาด');
      }
    });
  }

  Future<Null> confirmEdit() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('คุณต้องการเปลี่ยนแปลงข้อมูล ?'),
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
}
