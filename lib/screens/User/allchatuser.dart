import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/seller_model.dart';
import 'package:k6_app/models/user_models.dart';
import 'package:k6_app/screens/User/chatpage.dart';
import 'package:k6_app/utility/my_constant.dart';

class AllchatUser extends StatefulWidget {
  AllchatUser({required this.userModel});
  final UserModel userModel;

  @override
  State<AllchatUser> createState() => _AllchatUserState();
}

class _AllchatUserState extends State<AllchatUser> {
  UserModel? userModel;

  String? idUser, idSeller;
  List<SellerModel> sellerModel = [];
  bool? check;

  @override
  void initState() {
    super.initState();
    userModel = widget.userModel;
    getSellerchat();
  }

  Future<Null> getSellerchat() async {
    idUser = userModel!.idUser;
    String api =
        '${MyConstant().domain}/api/getSellerChat.php?isAdd=true&id_user=$idUser';
    await Dio().get(api).then((value) {
      print(value.toString());
      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          SellerModel sellerModels = SellerModel.fromMap(item);
          setState(() {
            sellerModel.add(sellerModels);
            // print(sellerModel);
          });
        }
      } else {
        setState(() {
          check = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข้อความ'),
      ),
      body: check == false
          ? showNotProduct()
          : Container(
              child: ListView.builder(
                  itemCount: sellerModel.length,
                  itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.all(8),
                        child: ListTile(
                          onTap: () {
                            MaterialPageRoute route = MaterialPageRoute(
                                builder: (value) => ChatPage(
                                    sellerModel: sellerModel[index],
                                    userModel: userModel!));
                            Navigator.of(context).push(route);
                          },
                          leading:
                              // Icon(
                              //   Icons.person,
                              //   size: 30,
                              //   color: Colors.blue,
                              // ),
                              Image.network(
                            '${MyConstant().domain}/images/profileseller/${sellerModel[index].image}',
                            fit: BoxFit.cover,
                            width: 50,
                          ),
                          title: Text(
                            sellerModel[index].firstname +
                                '  ' +
                                sellerModel[index].lastname,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: Colors.blue,
                          ),
                        ),
                      )),
            ),
    );
  }

  Widget showNotProduct() {
    return Center(
      child: Text(
        'ยังไม่มีแชทในตอนนี้',
        style: Theme.of(context)
            .textTheme
            .button!
            .copyWith(color: Colors.black, fontSize: 20),
      ),
    );
  }
}
