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
}
