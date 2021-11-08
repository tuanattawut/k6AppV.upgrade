import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:k6_app/models/reserve_area_model.dart';
import 'package:k6_app/screens/Manager/manage_rentarea.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';
import 'package:k6_app/utility/normal_dialog.dart';

class ApproveAreaDetail extends StatefulWidget {
  ApproveAreaDetail({required this.researveAreaModel});
  final ResearveAreaModel researveAreaModel;
  @override
  _ApproveAreaDetailState createState() => _ApproveAreaDetailState();
}

class _ApproveAreaDetailState extends State<ApproveAreaDetail> {
  ResearveAreaModel? researveAreaModel;
  String? idSeller, idarea;
  void initState() {
    super.initState();
    researveAreaModel = widget.researveAreaModel;
    idSeller = researveAreaModel!.idSeller1;
    idarea = researveAreaModel!.idArea;
  }

  var f = NumberFormat.currency(locale: "THB", symbol: "฿");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดจองแผง คุณ${researveAreaModel!.firstname}'),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'ชื่อผู้จอง : ${researveAreaModel!.firstname}  '
              ' ${researveAreaModel!.lastname} ',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'เบอร์ติดต่อ : ${researveAreaModel!.phone}  ',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'อีเมล : ${researveAreaModel!.email}  ',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'เลขบัตรประชาชน : ${researveAreaModel!.idcard}  ',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'ชื่อแผงที่จอง : ${researveAreaModel!.namearea}  ',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'ขนาด : ${researveAreaModel!.scale}  ',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'รายละเอียด : ${researveAreaModel!.detail}  ',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'ค่าเช่า : ${f.format(int.parse(researveAreaModel!.rentalfee.toString()))}',
              style: Theme.of(context)
                  .textTheme
                  .button!
                  .copyWith(color: Colors.red, fontSize: 16),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'รูปแผง : ',
              style: TextStyle(fontSize: 16),
            ),
          ),
          showImage(),
          MyStyle().mySizebox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  editArea();
                },
                child: Text('อนุมัติ'),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                onPressed: () => deleteReserve(),
                child: Text('ไม่อนุมัติ'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget showImage() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Image.network(
          '${MyConstant().domain}/upload/area/${researveAreaModel!.image}',
          fit: BoxFit.contain,
        ));
  }

  Future<Null> editArea() async {
    String url =
        '${MyConstant().domain}/api/editAreaReserve.php?isAdd=true&id_seller=$idSeller&id_area=$idarea';
    await Dio().get(url).then((value) {
      if (value.toString() == 'true') {
        editShop();
      } else {
        normalDialog(context, 'กรุณาลองใหม่ มีอะไร ? ผิดพลาด');
      }
    });
  }

  Future<Null> editShop() async {
    String url =
        '${MyConstant().domain}/api/editShopReserve.php?isAdd=true&id_seller=$idSeller&id_area=$idarea';
    await Dio().get(url).then((value) {
      if (value.toString() == 'true') {
        normalDialog(context, 'อนุมัติสำเร็จแล้ว');
      } else {
        normalDialog(context, 'กรุณาลองใหม่ มีอะไร ? ผิดพลาด');
      }
    });
  }

  Future<Null> deleteReserve() async {
    String url =
        '${MyConstant().domain}/api/deleteReserve.php?isAdd=true&id_seller=$idSeller';
    await Dio().get(url).then((value) {
      if (value.toString() == 'true') {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (context) => ManageRentArea(),
        ));
      } else {
        normalDialog(context, 'กรุณาลองใหม่ มีอะไร ? ผิดพลาด');
      }
    });
  }
}
