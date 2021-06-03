import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MakeBanner extends StatefulWidget {
  @override
  _MakeBannerState createState() => _MakeBannerState();
}

class _MakeBannerState extends State<MakeBanner> {
  int _current = 0;

  List<Widget> widgets = [];
  List<String> pathImages = [
    'images/banner1.png',
    'images/banner2.png',
    'images/banner3.png',
  ];

  void initState() {
    super.initState();
    buildWidgets();
  }

  void buildWidgets() {
    for (var item in pathImages) {
      widgets.add(Image.asset(item));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: widgets,
          options: CarouselOptions(
              autoPlay: true,
              autoPlayAnimationDuration: Duration(seconds: 2),
              aspectRatio: 16 / 9,
              viewportFraction: 1,
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
