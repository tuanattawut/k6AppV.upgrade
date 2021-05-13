import 'package:flutter/material.dart';
import 'package:k6_app/screens/add_product_seller.dart';
import 'package:k6_app/utility/my_style.dart';

class ProductListSeller extends StatefulWidget {
  ProductListSeller({Key key}) : super(key: key);

  @override
  _ProductListSellerState createState() => _ProductListSellerState();
}

class _ProductListSellerState extends State<ProductListSeller> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        showListFood(),
        addProductButton(),
      ],
    );
  }

  Widget addProductButton() => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 20.0),
                child: FloatingActionButton(
                  onPressed: () {
                    MaterialPageRoute route = MaterialPageRoute(
                      builder: (context) => AddProduct(),
                    );
                    Navigator.push(context, route).then((value) => {});
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
        ],
      );

  Widget showListFood() => ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) => Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.4,
              child: Image.network(
                'https://th.louisvuitton.com/images/is/image/lv/1/PP_VP_L/%E0%B8%AB%E0%B8%A5%E0%B8%B8%E0%B8%A2%E0%B8%AA%E0%B9%8C-%E0%B8%A7%E0%B8%B4%E0%B8%95%E0%B8%95%E0%B8%AD%E0%B8%87-%E0%B8%81%E0%B8%A3%E0%B8%B0%E0%B9%80%E0%B8%9B%E0%B9%8B%E0%B8%B2%E0%B8%A3%E0%B8%B8%E0%B9%88%E0%B8%99-multi-pochette-accessoires-monogram-%E0%B8%81%E0%B8%A3%E0%B8%B0%E0%B9%80%E0%B8%9B%E0%B9%8B%E0%B8%B2%E0%B8%96%E0%B8%B7%E0%B8%AD--M44813_PM1_Side%20view.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.4,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'น้องไม่ชอบคนทะเล้นเเต่เธอบอกชอบคนเต้นระบำ บำ บำ บำ บำ บำ',
                      style: MyStyle().mainTitle,
                    ),
                    Text(
                      'ราคา: 99999 - 99999 บาท',
                      style: MyStyle().mainH2Title,
                    ),
                    Text(
                        'พี่ไม่มี Louis Vuitton มีแต่หนี้ก้อนโต  นวลน้องคงน้ำตานอง เพราะต้องช่วยพี่ออกค่าคอนโด'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () => {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
