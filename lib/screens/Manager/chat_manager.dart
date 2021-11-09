import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/manager_model.dart';
import 'package:k6_app/models/shop_model.dart';
import 'package:k6_app/screens/Manager/Chatpage_manager.dart';
import 'package:k6_app/utility/my_constant.dart';

class ChatManager extends StatefulWidget {
  ChatManager({required this.managerModel});
  final ManagerModel managerModel;

  @override
  _ChatManagerState createState() => _ChatManagerState();
}

class _ChatManagerState extends State<ChatManager> {
  ManagerModel? managerModel;
  String? idManager;
  List<ShopModel> shopModel = [];
  @override
  void initState() {
    super.initState();
    managerModel = widget.managerModel;
    getShopchat();
  }

  Future<Null> getShopchat() async {
    idManager = managerModel!.idmanager;
    String api =
        '${MyConstant().domain}/api/getManagerChat.php?isAdd=true&id_manager=$idManager';
    await Dio().get(api).then((value) {
      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          ShopModel shopmodels = ShopModel.fromMap(item);
          setState(() {
            shopModel.add(shopmodels);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แชทกับร้านค้า'),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: shopModel.length,
            itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.all(8),
                  child: ListTile(
                    onTap: () {
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (value) => ChatpageManager(
                              managerModel: managerModel!,
                              shopmodel: shopModel[index]));
                      Navigator.of(context).push(route);
                    },
                    leading: Image.network(
                      '${MyConstant().domain}/upload/shop/${shopModel[index].image}',
                      fit: BoxFit.cover,
                      width: 50,
                    ),
                    title: Text(
                      shopModel[index].nameshop,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                    ),
                  ),
                )),
      ),
    );
  }
}
