import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/covid_models.dart';
import 'package:k6_app/screens/add_info_seller.dart';
import 'package:k6_app/utility/my_style.dart';

class InformationSeller extends StatefulWidget {
  InformationSeller({Key key}) : super(key: key);

  @override
  _InformationSellerState createState() => _InformationSellerState();
}

class _InformationSellerState extends State<InformationSeller> {
  Covid covid;

  @override
  void initState() {
    super.initState();
    readDataUser();
  }

  Future<Null> readDataUser() async {
    print('ดึงข้อมูลมาใช้งาน');
    String url = 'https://covid19.th-stat.com/api/open/today';
    Dio().get(url).then((value) {
      print('value = $value');
    });
  }

  void routeToAddInfo() {
    MaterialPageRoute materialPageRoute = MaterialPageRoute(
      builder: (context) => AddInfoSeller(),
    );
    Navigator.push(context, materialPageRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        MyStyle().showProgress(),
        addAndEditButton(),
      ],
    );
  }

  Row addAndEditButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 50.0),
              child: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () => routeToAddInfo(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
