import 'package:flutter/material.dart';
import 'package:k6_app/models/promotionseller_model.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';

class DetailPromotionseller extends StatefulWidget {
  DetailPromotionseller({required this.promotionsellerModel});
  final PromotionsellerModel promotionsellerModel;

  @override
  _DetailPromotionsellerState createState() => _DetailPromotionsellerState();
}

class _DetailPromotionsellerState extends State<DetailPromotionseller> {
  PromotionsellerModel? promotionlist;
  String? idPro, status = 'yes', nameshop;
  @override
  void initState() {
    super.initState();
    promotionlist = widget.promotionsellerModel;
    idPro = promotionlist!.idPromotionseller;
    nameshop = promotionlist!.nameshop;
  }

  dynamic date(DateTime tm) {
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
      return '${tm.day} $month';
    } else {
      return '${tm.day} $month ${tm.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('รายละเอียดประกาศ'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              MyStyle().mySizebox(),
              showImage(),
              Divider(),
              MyStyle().mySizebox(),
              Text(
                promotionlist!.detailpromotion.toString(),
                style: TextStyle(fontSize: 18),
              ),
              MyStyle().mySizebox(),
              Row(
                children: [
                  MyStyle().showTitleH2('จากร้าน:  '),
                  Text(
                    nameshop.toString(),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              MyStyle().mySizebox(),
              Row(
                children: [
                  MyStyle().showTitleH2('วันที่ลง:  '),
                  Text(
                    date(DateTime.parse(promotionlist!.regdate.toString()))
                        .toString(),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget showImage() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Image.network(
          '${MyConstant().domain}/upload/promotionseller/${promotionlist?.image}',
          fit: BoxFit.contain,
        ));
  }
}
