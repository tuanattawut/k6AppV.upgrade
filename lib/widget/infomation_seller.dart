import 'package:flutter/material.dart';
import 'package:k6_app/screens/add_info_seller.dart';
import 'package:k6_app/utility/my_style.dart';

class InformationSeller extends StatefulWidget {
  InformationSeller({Key key}) : super(key: key);

  @override
  _InformationSellerState createState() => _InformationSellerState();
}

class _InformationSellerState extends State<InformationSeller> {
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
        MyStyle().titleCenter(context, ' ยังไม่มี ข้อมูล กรุณาเพิ่มข้อมูล'),
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
                child: Icon(Icons.edit),
                onPressed: () => routeToAddInfo(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
