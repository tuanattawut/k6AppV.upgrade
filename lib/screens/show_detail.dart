import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:k6_app/models/product_models.dart';

class ShowDetail extends StatefulWidget {
  @override
  _ShowDetailState createState() => _ShowDetailState();
}

class _ShowDetailState extends State<ShowDetail> {
  ProductModels productModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: productModel == null
            ? Text('Show detail')
            : Text('Show ${productModel.name}'),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
