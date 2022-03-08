import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/user_models.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';
import 'package:k6_app/utility/normal_dialog.dart';

class ChatmanaUser extends StatefulWidget {
  ChatmanaUser({required this.usermodel});
  final UserModel usermodel;

  @override
  _ChatmanaUserState createState() => _ChatmanaUserState();
}

class _ChatmanaUserState extends State<ChatmanaUser> {
  String? email, name, message, idUser;
  UserModel? userModel;

  @override
  void initState() {
    super.initState();
    userModel = widget.usermodel;
    email = userModel!.email;
    name = userModel!.firstname + ' ' + userModel!.lastname;
    idUser = userModel!.idUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ติดต่อผู้จัดการ'),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              behavior: HitTestBehavior.opaque,
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      MyStyle().showTitleH2('ชื่อ'),
                      Text(
                        ' *',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                  MyStyle().mySizebox(),
                  Text(
                    name!,
                    style: TextStyle(fontSize: 16),
                  ),
                  MyStyle().mySizebox(),
                  Row(
                    children: [
                      MyStyle().showTitleH2('อีเมล'),
                      Text(
                        ' *',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                  MyStyle().mySizebox(),
                  Text(
                    email!,
                    style: TextStyle(fontSize: 16),
                  ),
                  MyStyle().mySizebox(),
                  Row(
                    children: [
                      MyStyle().showTitleH2('รายละเอียด'),
                      Text(
                        ' *',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                  MyStyle().mySizebox(),
                  detail(),
                  MyStyle().mySizebox(),
                  saveButton()
                ],
              ),
            )));
  }

  TextFormField detail() {
    return TextFormField(
      onChanged: (value) => message = value.trim(),
      keyboardType: TextInputType.multiline,
      maxLines: 6,
      decoration: InputDecoration(
        hintText: 'พิมพ์ข้อความของคุณ',
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
    );
  }

  ElevatedButton saveButton() {
    return ElevatedButton(
      child: Text('ส่งข้อความ'),
      onPressed: () {
        sendMessage();
      },
    );
  }

  Future<Null> sendMessage() async {
    String url =
        '${MyConstant().domain}/api/addReport.php?isAdd=true&id_user=$idUser&message=$message';

    print(idUser);
    try {
      Response response = await Dio().get(url);
      print('res = $response');

      if (response.toString() == 'true') {
        // normalDialog(context, 'ส่งสำเร็จ');
        Navigator.pop(context);
      } else {
        normalDialog(context, 'ผิดผลาด กรุณาลองอีกครั้ง');
      }
    } catch (e) {
      normalDialog(context, 'ผิดผลาด ${e.toString()}');
    }
  }
}
