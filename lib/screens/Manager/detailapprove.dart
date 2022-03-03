import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/seller_model.dart';
import 'package:k6_app/screens/Manager/approve_seller.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';
import 'package:k6_app/utility/normal_dialog.dart';

class DetailApprove extends StatefulWidget {
  DetailApprove({required this.sellerModel});
  final SellerModel sellerModel;
  @override
  _DetailApproveState createState() => _DetailApproveState();
}

class ListItem {
  String status;
  String name;
  ListItem(this.status, this.name);
}

class _DetailApproveState extends State<DetailApprove> {
  SellerModel? sellerModel;
  String? _value;
  List<ListItem> _dropdownItems = [
    ListItem('seller', 'อนุมัติ'),
    ListItem('noseller', 'ไม่อนุมัติ'),
  ];
  @override
  void initState() {
    super.initState();
    sellerModel = widget.sellerModel;
  }

  Future<Null> editSeller(SellerModel sellermodel) async {
    String id = sellermodel.idSeller;

    String url =
        '${MyConstant().domain}/api/editSeller.php?isAdd=true&id=$id&role=$_value';
    await Dio().get(url).then((value) async {
      if (value.toString() == 'true') {
        await normalDialog(context, 'สำเร็จ');
      } else {
        normalDialog(context, 'กรุณาลองใหม่ มีอะไร ? ผิดพลาด');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: sellerModel == null
            ? Text('รายละเอียด')
            : Text('รายละเอียดคุณ ${sellerModel!.firstname}'),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: CircleAvatar(
              radius: 100,
              child: ClipOval(
                  child: Image.network(
                '${MyConstant().domain}/images/profileseller/${sellerModel!.image}',
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              )),
              backgroundColor: Colors.transparent,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'ชื่อ : ${sellerModel!.firstname}  '
              ' ${sellerModel!.lastname} ',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'เพศ : ${sellerModel!.gender}  ',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'อีเมล : ${sellerModel!.email}  ',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'เลขบัตรประชาชน : ${sellerModel!.idcard}  ',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'วันเกิด : ${sellerModel!.birthday.day} /${sellerModel!.birthday.month} /${sellerModel!.birthday.year}  ',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: dropdownapprove(),
          ),
          MyStyle().mySizebox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () => editSeller(sellerModel!),
                child: Text('ยืนยัน'),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                onPressed: () {
                  confirmDelete();
                },
                child: Text('ลบผู้ขายรายนี้'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row dropdownapprove() {
    return Row(
      children: [
        Text(
          'อนุมัติผู้ขาย :   ',
          style: TextStyle(fontSize: 16),
        ),
        DropdownButton<String>(
          value: _value,
          items: _dropdownItems.map((ListItem item) {
            return DropdownMenuItem<String>(
              value: item.status,
              child: Text(item.name),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              _value = value;
            });
          },
        ),
      ],
    );
  }

  Future<Null> confirmDelete() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('คุณต้องการลบผู้ขายรายนี้ ?'),
        children: <Widget>[
          Row(
            children: <Widget>[
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.check,
                  color: Colors.red,
                ),
                label: Text('ยืนยัน', style: TextStyle(color: Colors.red)),
              ),
              TextButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.clear, color: Colors.blue),
                label: Text('ยกเลิก'),
              )
            ],
          )
        ],
      ),
    );
  }
}
