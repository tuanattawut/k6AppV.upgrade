import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:k6_app/models/chat_models.dart';
import 'package:k6_app/models/manager_model.dart';
import 'package:k6_app/models/seller_model.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';
import 'package:k6_app/utility/normal_dialog.dart';

class ChatmanagerPage extends StatefulWidget {
  ChatmanagerPage({required this.sellerModel});

  final SellerModel sellerModel;
  @override
  _ChatmanagerPageState createState() => _ChatmanagerPageState();
}

class _ChatmanagerPageState extends State<ChatmanagerPage> {
  SellerModel? sellerModel;

  String? idmanager, idSeller, message;
  bool? check;
  String? date(DateTime tm) {
    DateTime today = new DateTime.now();
    Duration oneDay = new Duration(days: 1);
    Duration twoDay = new Duration(days: 2);
    Duration oneWeek = new Duration(days: 7);
    String? month;
    switch (tm.month) {
      case 1:
        month = "มกราคม";
        break;
      case 2:
        month = "กุมภาพันธ์";
        break;
      case 3:
        month = "มีนาคม";
        break;
      case 4:
        month = "เมษายน";
        break;
      case 5:
        month = "พฤษภาคม";
        break;
      case 6:
        month = "มิถุนายน";
        break;
      case 7:
        month = "กรกฏาคม";
        break;
      case 8:
        month = "สิงหาคม";
        break;
      case 9:
        month = "กันยายน";
        break;
      case 10:
        month = "ตุลาคม";
        break;
      case 11:
        month = "พฤศจิกายน";
        break;
      case 12:
        month = "ธันวาคม";
        break;
    }

    Duration difference = today.difference(tm);

    if (difference.compareTo(oneDay) < 1) {
      return "วันนี้";
    } else if (difference.compareTo(twoDay) < 1) {
      return "เมื่อวานนี้";
    } else if (difference.compareTo(oneWeek) < 1) {
      switch (tm.weekday) {
        case 1:
          return "จันทร์";
        case 2:
          return "อังคาร";
        case 3:
          return "พุธ";
        case 4:
          return "พฤหัสบดี";
        case 5:
          return "ศุกร์";
        case 6:
          return "เสาร์";
        case 7:
          return "อาทิตย์";
      }
    } else if (tm.year == today.year) {
      return '${tm.day} $month ';
    } else {
      return '${tm.day} $month ${tm.year}';
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      sellerModel = widget.sellerModel;
      readChat();
    });
  }

  bool? loadStatus = true;
  bool? status = true;

  List<ChatModel> chatlist = [];
  Future<Null> readChat() async {
    if (chatlist.length != 0) {
      loadStatus = true;
      status = true;
      chatlist.clear();
    }
    idSeller = sellerModel!.idSeller;
    idmanager = '1';
    String url =
        '${MyConstant().domain}/api/getChatmanagerseller.php?isAdd=true&id_manager=$idmanager&id_seller=$idSeller';
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    setState(() {
      loadStatus = false;
    });
    if (result != null) {
      for (var map in result) {
        ChatModel chatlists = ChatModel.fromMap(map);
        setState(() {
          chatlist.add(chatlists);
        });
      }
    } else {
      setState(() {
        status = false;
      });
    }
  }

  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        body: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            behavior: HitTestBehavior.opaque,
            child: Column(
              children: [
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: loadStatus!
                            ? MyStyle().showProgress()
                            : showNotMessage())),
                chatInputField(),
              ],
            )));
  }

  Widget showNotMessage() {
    return status!
        ? chat()
        : Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                ),
              ),
            ],
          );
  }

  Widget chat() => ListView.builder(
        itemCount: chatlist.length,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 10, bottom: 10),
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
            child: Align(
              alignment: (chatlist[index].status == 'manager'
                  ? Alignment.topLeft
                  : Alignment.topRight),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: (chatlist[index].status == 'manager'
                      ? Colors.grey.shade200
                      : Colors.blue[200]),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chatlist[index].message,
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      date(DateTime.parse(chatlist[index].regdate)).toString(),
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          BackButton(),
          SizedBox(width: 20 * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sellerModel!.firstname + '  ' + sellerModel!.lastname,
                style: TextStyle(fontSize: 16),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget chatInputField() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20 / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 6),
            blurRadius: 8,
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            SizedBox(width: 20),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20 * 0.75,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      onChanged: (value) => message,
                      textInputAction: TextInputAction.done,
                      controller: _controller,
                      autofocus: true,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "ส่งข้อความ ...",
                        border: InputBorder.none,
                        filled: true,
                      ),
                    )),
                    IconButton(
                        onPressed: () {
                          message = _controller.text;
                          sendChat();
                          showSend(context);
                        },
                        icon: Icon(
                          Icons.send,
                          color: Colors.blue,
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> sendChat() async {
    idSeller = sellerModel!.idSeller;
    idmanager = '1';
    String status = 'seller';
    String url =
        '${MyConstant().domain}/api/addChatmanager.php?isAdd=true&message=$message&id_manager=$idmanager&id_seller=$idSeller&status=$status';

    try {
      Response response = await Dio().get(url);
      //print('res = $response');

      if (response.toString() == 'true') {
        Navigator.pop(context);
        setState(() {
          _controller.clear();
          sendChat();
        });
      } else {
        normalDialog(context, 'ส่งข้อความล้มเหลว ลองอีกครั้ง');
      }
    } catch (e) {}
  }
}
