import 'dart:convert';

class ProductModels {
  final String id;
  final String category;
  final String name;
  final String descriptions;
  final String imgUrl;
  final String price;
  ProductModels({
    this.id,
    this.category,
    this.name,
    this.descriptions,
    this.imgUrl,
    this.price,
  });

  ProductModels copyWith({
    String id,
    String category,
    String name,
    String descriptions,
    String imgUrl,
    String price,
  }) {
    return ProductModels(
      id: id ?? this.id,
      category: category ?? this.category,
      name: name ?? this.name,
      descriptions: descriptions ?? this.descriptions,
      imgUrl: imgUrl ?? this.imgUrl,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'name': name,
      'descriptions': descriptions,
      'imgUrl': imgUrl,
      'price': price,
    };
  }

  factory ProductModels.fromMap(Map<String, dynamic> map) {
    return ProductModels(
      id: map['id'],
      category: map['category'],
      name: map['name'],
      descriptions: map['descriptions'],
      imgUrl: map['imgUrl'],
      price: map['price'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModels.fromJson(String source) =>
      ProductModels.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductModels(id: $id, category: $category, name: $name, descriptions: $descriptions, imgUrl: $imgUrl, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModels &&
        other.id == id &&
        other.category == category &&
        other.name == name &&
        other.descriptions == descriptions &&
        other.imgUrl == imgUrl &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        category.hashCode ^
        name.hashCode ^
        descriptions.hashCode ^
        imgUrl.hashCode ^
        price.hashCode;
  }

  static final List<ProductModels> testData = [
    ProductModels(
        id: '1',
        category: 'ของกิน',
        name: 'หมูปิ้ง',
        descriptions: 'ปิ้งด้วยความไว 2000 เมตร',
        imgUrl:
            'https://food.mthai.com/app/uploads/2017/09/Grilled-Pork-Sticks.jpg',
        price: '20'),
    ProductModels(
        id: '2',
        category: 'ของกิน',
        name: 'ไก่',
        descriptions: 'ลองกินดิ',
        imgUrl: 'https://i.ytimg.com/vi/WZVGW5DiYlY/maxresdefault.jpg',
        price: '40-500'),
    ProductModels(
        id: '3',
        category: 'ของกิน',
        name: 'ผักชี',
        descriptions: 'บวชนานแล้ว',
        imgUrl: 'https://www.greenery.org/wp-content/uploads/2018/10/PC-01.jpg',
        price: '20-50'),
    ProductModels(
        id: '4',
        category: 'ของกิน',
        name: 'เนื้อหมู',
        descriptions: 'เนื้อหมูกินทุกวัน',
        imgUrl:
            'https://static.thairath.co.th/media/dFQROr7oWzulq5FZUEh1bGHbkAlMP6YU69FzlfmtDtIvKULTA65Qg2Y02blCtbVGNLp.jpg',
        price: '80-90'),
    ProductModels(
        id: '5',
        category: 'ของใช้',
        name: 'เสื้อผ้า',
        descriptions: 'หลากหลายสไตล์',
        imgUrl:
            'https://www.livingpop.com/wp-content/uploads/2019/11/3-1200x960.jpg',
        price: '60-190'),
    ProductModels(
        id: '6',
        category: 'ของใช้',
        name: 'น้องหมา',
        descriptions: 'เดินได้ วิ่งได้ นอนได้',
        imgUrl:
            'https://imgcp.aacdn.jp/img-a/1200/900/global-aaj-front/article/2016/11/582922b20dfbd_582922a622783_178712518.jpg',
        price: '1,650'),
    ProductModels(
        id: '7',
        category: 'ของกิน',
        name: 'โค๊ก',
        descriptions: 'กระป๋องแดง ซ่าจัด',
        imgUrl:
            'https://www.prachachat.net/wp-content/uploads/2019/03/S__21585924-728x546.jpg',
        price: '15'),
    ProductModels(
        id: '8',
        category: 'ของกิน',
        name: 'โจ๊ก',
        descriptions: 'ต้องต้มให้เละ',
        imgUrl:
            'https://img-global.cpcdn.com/recipes/052796c4ff9d3068/751x532cq70/%E0%B8%A3%E0%B8%B9%E0%B8%9B-%E0%B8%AB%E0%B8%A5%E0%B8%B1%E0%B8%81-%E0%B8%82%E0%B8%AD%E0%B8%87-%E0%B8%AA%E0%B8%B9%E0%B8%95%E0%B8%A3-%E0%B9%82%E0%B8%88%E0%B9%8A%E0%B8%81%E0%B8%AB%E0%B8%A1%E0%B8%B9%E0%B8%81%E0%B9%89%E0%B8%AD%E0%B8%99%E0%B8%81%E0%B8%A5%E0%B8%A1.jpg',
        price: '15-30'),
    ProductModels(
        id: '9',
        category: 'ของใช้',
        name: 'หนังสือเอเลี่ยน',
        descriptions: 'ลองอ่านสิ่งใหม่ๆบ้าง',
        imgUrl:
            'https://www.bongkoch.com/shop/image/catalog/products/magazine/renlub/renlub513.jpg',
        price: '38'),
    ProductModels(
        id: '10',
        category: 'ของกิน',
        name: 'ไมโล',
        descriptions: 'อร่อยถูกใจ ',
        imgUrl:
            'https://static.bigc.co.th/media/catalog/product/8/8/8850127010213.jpg',
        price: '88'),
  ];
}
