import 'package:flutter/material.dart';
import 'package:k6_app/models/product_models.dart';
import 'package:k6_app/utility/my_constant.dart';

class ItemCard extends StatelessWidget {
  final ProductModel product;
  final Function()? press;
  const ItemCard({
    required this.product,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: "${product.idProduct}",
                child: Image.network('${MyConstant().domain}/${product.image}'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20 / 4),
            child: Text(
              product.detail,
              style: TextStyle(color: Colors.amber),
            ),
          ),
          Text(
            "\$${product.price}",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
