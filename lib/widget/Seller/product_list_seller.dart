import 'package:flutter/material.dart';
import 'package:k6_app/screens/Seller/add_product_seller.dart';
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 40, right: 20),
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
      itemCount: data.length,
      itemBuilder: (context, index) => Card(
            shadowColor: Colors.red.shade500,
            elevation: 3,
            clipBehavior: Clip.antiAlias,
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.4,
                  child: Image.network(
                    '${image[index]}',
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
                          'สินค้า ${data[index]}',
                          style: MyStyle().mainTitle,
                        ),
                        Text(
                          ' 99999 - 99999 บาท',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'ตัวอย่าง ตัวอย่าง  ตัวอย่าง  ตัวอย่าง  ตัวอย่าง  ตัวอย่าง  ตัวอย่าง  ตัวอย่าง  ตัวอย่าง  ตัวอย่าง  ตัวอย่าง  ตัวอย่าง  ตัวอย่าง  ตัวอย่าง ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.green,
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
          ));

  final List<String> data = <String>['1', '2', '3', '4'];
  final List<String> image = <String>[
    'https://food.mthai.com/app/uploads/2017/09/Grilled-Pork-Sticks.jpg',
    'https://th.louisvuitton.com/images/is/image/lv/1/PP_VP_L/%E0%B8%AB%E0%B8%A5%E0%B8%B8%E0%B8%A2%E0%B8%AA%E0%B9%8C-%E0%B8%A7%E0%B8%B4%E0%B8%95%E0%B8%95%E0%B8%AD%E0%B8%87-%E0%B8%81%E0%B8%A3%E0%B8%B0%E0%B9%80%E0%B8%9B%E0%B9%8B%E0%B8%B2%E0%B8%A3%E0%B8%B8%E0%B9%88%E0%B8%99-multi-pochette-accessoires-monogram-%E0%B8%81%E0%B8%A3%E0%B8%B0%E0%B9%80%E0%B8%9B%E0%B9%8B%E0%B8%B2%E0%B8%96%E0%B8%B7%E0%B8%AD--M44813_PM1_Side%20view.jpg',
    'https://i.ytimg.com/vi/WZVGW5DiYlY/maxresdefault.jpg',
    'https://www.greenery.org/wp-content/uploads/2018/10/PC-01.jpg',
    'https://static.thairath.co.th/media/dFQROr7oWzulq5FZUEh1bGHbkAlMP6YU69FzlfmtDtIvKULTA65Qg2Y02blCtbVGNLp.jpg',
    'https://www.livingpop.com/wp-content/uploads/2019/11/3-1200x960.jpg',
    'https://imgcp.aacdn.jp/img-a/1200/900/global-aaj-front/article/2016/11/582922b20dfbd_582922a622783_178712518.jpg',
    'https://www.prachachat.net/wp-content/uploads/2019/03/S__21585924-728x546.jpg',
    'https://img-global.cpcdn.com/recipes/052796c4ff9d3068/751x532cq70/%E0%B8%A3%E0%B8%B9%E0%B8%9B-%E0%B8%AB%E0%B8%A5%E0%B8%B1%E0%B8%81-%E0%B8%82%E0%B8%AD%E0%B8%87-%E0%B8%AA%E0%B8%B9%E0%B8%95%E0%B8%A3-%E0%B9%82%E0%B8%88%E0%B9%8A%E0%B8%81%E0%B8%AB%E0%B8%A1%E0%B8%B9%E0%B8%81%E0%B9%89%E0%B8%AD%E0%B8%99%E0%B8%81%E0%B8%A5%E0%B8%A1.jpg',
    'https://www.bongkoch.com/shop/image/catalog/products/magazine/renlub/renlub513.jpg',
    'https://static.bigc.co.th/media/catalog/product/8/8/8850127010213.jpg'
  ];
}
