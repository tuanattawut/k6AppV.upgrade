import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/product_models.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar.build(context),
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10, left: 10),
              child: Row(
                children: [
                  Text('โปรโมชั่น', style: MyStyle().mainTitle),
                ],
              ),
            ),
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
                itemCount: ProductModels.testData.length,
                itemBuilder: (BuildContext buildContext, int index) {
                  return showListView(index);
                }),
          ],
        ),
      ),
    );
  }

  Widget showListView(int index) {
    ProductModels _model = ProductModels.testData[index];
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
          child: Image.network('${_model.imgUrl}'),
        ),
        footer: GridTileBar(
          title: Text(
            _model.name,
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            '${_model.price} ฿',
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
              pauseAutoPlayOnTouch: true,
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
}
