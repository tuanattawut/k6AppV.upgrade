import 'dart:convert';

class CategoryModel {
  String? idcategory;
  String? namecategory;
  String? image;
  CategoryModel({
    this.idcategory,
    this.namecategory,
    this.image,
  });

  CategoryModel copyWith({
    String? idcategory,
    String? namecategory,
    String? image,
  }) {
    return CategoryModel(
      idcategory: idcategory ?? this.idcategory,
      namecategory: namecategory ?? this.namecategory,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idcategory': idcategory,
      'namecategory': namecategory,
      'image': image,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      idcategory: map['id_category'],
      namecategory: map['namecategory'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'CategoryModel(idcategory: $idcategory, namecategory: $namecategory, image: $image)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryModel &&
        other.idcategory == idcategory &&
        other.namecategory == namecategory &&
        other.image == image;
  }

  @override
  int get hashCode =>
      idcategory.hashCode ^ namecategory.hashCode ^ image.hashCode;
}
