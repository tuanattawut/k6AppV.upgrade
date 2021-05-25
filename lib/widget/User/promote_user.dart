import 'package:flutter/material.dart';
import 'package:k6_app/screens/User/show_detail.dart';

import 'package:k6_app/utility/normal_dialog.dart';

class PromoteUser extends StatefulWidget {
  PromoteUser({Key key}) : super(key: key);

  @override
  _PromoteUserState createState() => _PromoteUserState();
}

class _PromoteUserState extends State<PromoteUser> {
  @override
  void initState() {
    super.initState();
  }

  final List<Map> myProducts = List.generate(
      10,
      (index) => {
            "id": index,
            "name": "สินค้า $index",
            "price": "$index บาท",
          }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('สินค้าแนะนำ')),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              mainAxisSpacing: 10,
            ),
            itemCount: myProducts.length,
            itemBuilder: (BuildContext buildContext, int index) {
              return showListView(index);
            }),
      ),
    );
  }

  Widget showListView(int index) {
    return GestureDetector(
      onTap: () {
        normalDialog(context, 'กดเพื่อ !!');
        MaterialPageRoute route = MaterialPageRoute(
          builder: (value) => ShowDetail(),
        );
        Navigator.of(context).push(route);
      },
      child: GridTile(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.network(
              'https://mpics.mgronline.com/pics/Images/564000001107901.JPEG'),
        ),
        footer: GridTileBar(
          title: Text(
            myProducts[index]["name"],
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          subtitle: Text(
            myProducts[index]["price"],
            style: TextStyle(
                color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white70,
        ),
      ),
    );
  }
}
