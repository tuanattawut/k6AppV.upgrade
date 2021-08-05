import 'dart:convert';

class CategoryModel {
  String? idcategory;
  String? namecategory;
  CategoryModel({
    this.idcategory,
    this.namecategory,
  });

  CategoryModel copyWith({
    String? idcategory,
    String? namecategory,
  }) {
    return CategoryModel(
      idcategory: idcategory ?? this.idcategory,
      namecategory: namecategory ?? this.namecategory,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idcategory': idcategory,
      'namecategory': namecategory,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      idcategory: map['id_category'],
      namecategory: map['namecategory'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'CategoryModel(idcategory: $idcategory, namecategory: $namecategory)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryModel &&
        other.idcategory == idcategory &&
        other.namecategory == namecategory;
  }

  @override
  int get hashCode => idcategory.hashCode ^ namecategory.hashCode;
}
