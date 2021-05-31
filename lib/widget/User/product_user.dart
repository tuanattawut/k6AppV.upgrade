import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/screens/User/show_detail.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:k6_app/utility/my_style.dart';

class ProductListUser extends StatefulWidget {
  @override
  _ProductListUserState createState() => _ProductListUserState();
}

class _ProductListUserState extends State<ProductListUser> {
  int _current = 0;

  List<Widget> widgets = [];
  List<String> pathImages = [
    'images/banner1.png',
    'images/banner2.png',
    'images/banner3.png',
  ];

  @override
  void initState() {
    super.initState();
    buildWidgets();
  }

  void buildWidgets() {
    for (var item in pathImages) {
      widgets.add(Image.asset(item));
    }
  }

  SearchBar searchBar;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        title: Center(child: Text('หน้าหลัก')),
        actions: [searchBar.getSearchAction(context)]);
  }

  void onSubmitted(String value) {
    setState(() => ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('คุณพิมพ์ว่า $value'))));
  }

  _ProductListUserState() {
    searchBar = SearchBar(
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted,
        onCleared: () {
          print("เครีย");
        },
        onClosed: () {
          print("ปิด");
        });
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
      appBar: searchBar.build(context),
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildCarouselSlider(),
            MyStyle().mySizebox(),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text('สินค้าทั้งหมด', style: MyStyle().mainTitle),
                ],
              ),
            ),
            MyStyle().mySizebox(),
            GridView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: (3 / 2),
                ),
                itemCount: myProducts.length,
                itemBuilder: (BuildContext buildContext, int index) {
                  return showListView(index);
                }),
          ],
        ),
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
      child: GridTile(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Image.network('${image[index]}'),
        ),
        footer: GridTileBar(
          title: Text(
            myProducts[index]["name"],
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            myProducts[index]["price"],
            style: TextStyle(
              color: Colors.red,
              fontSize: 18,
            ),
          ),
          backgroundColor: Colors.white54,
        ),
      ),
    );
  }

  Column buildCarouselSlider() {
    return Column(
      children: [
        CarouselSlider(
          items: widgets,
          options: CarouselOptions(
              autoPlay: true,
              autoPlayAnimationDuration: Duration(seconds: 2),
              aspectRatio: 16 / 9,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widgets.map((pathImages) {
            int index = widgets.indexOf(pathImages);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                    ? Color.fromRGBO(0, 0, 0, 0.9)
                    : Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        ),
      ],
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
