import 'package:flutter/material.dart';
import 'package:k6_app/screens/User/show_detail.dart';
import 'package:k6_app/utility/my_style.dart';

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
            "detail":
                "$index ตัวอย่างรายละเอียด ตัวอย่างรายละเอียด ตัวอย่างรายละเอียด ตัวอย่างรายละเอียด ตัวอย่างรายละเอียด ตัวอย่างรายละเอียด",
          }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('สินค้าแนะนำ')),
      ),
      body: Stack(
        children: [
          Container(
            child: ListView.builder(
              itemCount: myProducts.length,
              itemBuilder: (BuildContext buildContext, int index) {
                return showListView(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget showImage(int index) {
    return Container(
      padding: EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          image: DecorationImage(
            image: NetworkImage('${image[index]}'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget showName(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.5 - 35,
          child: Text(
            myProducts[index]["name"],
            style: MyStyle().mainTitle,
          ),
        ),
      ],
    );
  }

  Widget showDetail(int index) {
    String string = myProducts[index]["detail"];
    if (string.length > 100) {
      string = string.substring(0, 99);
      string = '$string ...';
    }
    return Text(
      string,
      style: TextStyle(
        fontSize: 16,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Widget showText(int index) {
    return Container(
      padding: EdgeInsets.only(right: 20.0),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          showName(index),
          showDetail(index),
          Text(
            myProducts[index]["price"],
            style: TextStyle(fontSize: 18, color: Colors.red),
          )
        ],
      ),
    );
  }

  Widget showListView(int index) {
    return GestureDetector(
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(
          builder: (value) => ShowDetail(),
        );
        Navigator.of(context).push(route);
      },
      child: Row(
        children: <Widget>[
          showImage(index),
          showText(index),
        ],
      ),
    );
  }

  final List<String> image = <String>[
    'https://food.mthai.com/app/uploads/2017/09/Grilled-Pork-Sticks.jpg',
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
