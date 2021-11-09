import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/seller_model.dart';
import 'package:k6_app/models/user_models.dart';
import 'package:k6_app/screens/Seller/chatpage_seller.dart';
import 'package:k6_app/utility/my_constant.dart';

class ChatSeller extends StatefulWidget {
  ChatSeller({required this.sellerModel});
  final SellerModel sellerModel;

  @override
  _ChatSellerState createState() => _ChatSellerState();
}

class _ChatSellerState extends State<ChatSeller> {
  SellerModel? sellerModel;
  String? idUser, idSeller;
  List<UserModel> userModel = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      sellerModel = widget.sellerModel;
      getUserchat();
    });
  }

  Future<Null> getUserchat() async {
    idSeller = sellerModel!.idSeller;
    String api =
        '${MyConstant().domain}/api/getUserChat.php?isAdd=true&id_seller=$idSeller';
    await Dio().get(api).then((value) {
      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          UserModel userModels = UserModel.fromMap(item);
          setState(() {
            userModel.add(userModels);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แชท'),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: userModel.length,
            itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.all(8),
                  child: ListTile(
                    onTap: () {
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (value) => ChatpageSeller(
                              userModel: userModel[index],
                              sellerModel: sellerModel!));
                      Navigator.of(context).push(route);
                    },
                    leading: Image.network(
                      '${MyConstant().domain}/upload/user/${userModel[index].image}',
                      fit: BoxFit.cover,
                      width: 50,
                    ),
                    title: Text(
                      userModel[index].firstname +
                          '  ' +
                          userModel[index].lastname,
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
