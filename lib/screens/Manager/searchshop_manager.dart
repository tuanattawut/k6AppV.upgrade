import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/shop_model.dart';
import 'package:k6_app/screens/Manager/showsearchshop.dart';
import 'package:k6_app/utility/my_constant.dart';

class SearchShop extends StatefulWidget {
  @override
  _SearchShopState createState() => _SearchShopState();
}

class _SearchShopState extends State<SearchShop> {
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ค้นหาร้านค้าที่ลงทะเบียน'),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Stack(
            children: <Widget>[
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        search(),
                        Row(
                          children: [
                            Text(
                              '*** พิมพ์ค้นหาด้วยชื่อร้านเท่านั้น ***',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        searchButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  TextField search() {
    return TextField(
      controller: editingController,
      decoration: InputDecoration(
          labelText: "ค้นหา",
          hintText: "พิมพ์ชื่อร้าน",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)))),
    );
  }

  ElevatedButton searchButton() {
    return ElevatedButton(
      child: Text('ค้นหา'),
      onPressed: () {
        MaterialPageRoute route = MaterialPageRoute(
            builder: (value) => ShowsearchShop(
                  nameshop: editingController.text,
                ));
        Navigator.of(context).push(route);
      },
    );
  }
}
