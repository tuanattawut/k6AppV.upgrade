import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:k6_app/models/product_models.dart';
import 'package:k6_app/models/seller_model.dart';
import 'package:k6_app/models/shop_model.dart';
import 'package:k6_app/models/user_models.dart';
import 'package:k6_app/screens/User/main_user.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';
import 'package:k6_app/screens/User/datailshop.dart';
import 'package:k6_app/screens/User/detailproduct.dart';

class ShowDetail extends StatefulWidget {
  final ProductModel productModel;
  final UserModel userModel;

  ShowDetail({required this.productModel, required this.userModel});
  @override
  _ShowDetailState createState() => _ShowDetailState();
}

class _ShowDetailState extends State<ShowDetail> {
  ProductModel? productModel;
  SellerModel? sellerModel;
  ShopModel? shopModels;
  UserModel? userModel;
  String? idShop, idSeller;

  @override
  void initState() {
    super.initState();
    setState(() {
      userModel = widget.userModel;
      productModel = widget.productModel;
      //print('url ==> ${productModel?.image}');
      readShop();
    });
  }

  Future<Null> readShop() async {
    idShop = productModel!.idShop;
    //print('==>$idShop');
    String url =
        '${MyConstant().domain}/api/getShopfromidShop.php?isAdd=true&id_shop=$idShop';
    Response response = await Dio().get(url);

    //print(response);
    var result = json.decode(response.data);
    // print('result = $result');

    for (var map in result) {
      setState(() {
        shopModels = ShopModel.fromMap(map);
        readSeller();
      });
    }
  }

  Future<Null> readSeller() async {
    idSeller = shopModels!.idSeller;
    String url =
        '${MyConstant().domain}/api/getSellerfromidSeller.php?isAdd=true&id_seller=$idSeller';
    Response response = await Dio().get(url);

    //print(response);
    var result = json.decode(response.data);
    // print('result = $result');

    for (var map in result) {
      setState(() {
        sellerModel = SellerModel.fromMap(map);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: productModel == null
                ? Text('รายละเอียด')
                : Text(productModel!.nameproduct),
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(new MaterialPageRoute(
                    builder: (context) => Homepage(
                      usermodel: userModel!,
                    ),
                  ));
                },
                icon: Icon(Icons.home)),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'สินค้า'),
                Tab(text: 'ร้าน'),
                Tab(text: 'แผนที่'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              DetailProduct(
                productModel: productModel!,
                userModel: userModel!,
              ),
              shopModels == null
                  ? MyStyle().showProgress()
                  : DetailShop(
                      shopModel: shopModels!,
                      userModel: userModel!,
                    ),
              shopModels == null
                  ? MyStyle().showProgress()
                  : Padding(
                      padding: EdgeInsets.all(30),
                      child: showMap(),
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
          '${MyConstant().domain}/upload/product/${productModel!.image}',
          fit: BoxFit.contain,
        ));
  }

  Widget showMap() {
    double lat = double.parse(shopModels!.lat);
    double long = double.parse(shopModels!.lng);
    //print('lat = $lat, long = $long');

    LatLng latLong = LatLng(lat, long);
    CameraPosition position = CameraPosition(
      target: latLong,
      zoom: 18,
    );

    return Container(
      height: 250,
      child: GoogleMap(
        initialCameraPosition: position,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
        markers: shopMarker(),
      ),
    );
  }

  Set<Marker> shopMarker() {
    return <Marker>[
      Marker(
          markerId: MarkerId('shopID'),
          position: LatLng(
              double.parse(shopModels!.lat), double.parse(shopModels!.lng)),
          infoWindow: InfoWindow(
              title: 'ตำแหน่งร้าน', snippet: 'ร้าน :  ${shopModels!.nameshop}'))
    ].toSet();
  }

  Widget showDetailProduct() => Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            showImage(),
            MyStyle().mySizebox(),
            Text(
              productModel!.nameproduct,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    '${productModel?.price} ฿',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            MyStyle().mySizebox(),
            Row(
              children: [
                MyStyle().showTitleH2('รายละเอียด: '),
              ],
            ),
            Text(
              productModel!.detail,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            MyStyle().mySizebox(),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        MyStyle().showTitleH2('ร้าน: '),
                        Text(
                          shopModels!.nameshop,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        MyStyle().showTitleH2('เบอร์โทร: '),
                        Text(
                          sellerModel!.phone,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                    height: 50, child: VerticalDivider(color: Colors.black)),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.chat,
                    size: 30,
                  ),
                ),
                MyStyle().mySizebox(),
                Text(
                  'แชท',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            MyStyle().mySizebox(),
            Row(
              children: [
                MyStyle().showTitleH2('ตำแหน่งร้าน: '),
              ],
            ),
            showMap(),
          ]));
}
