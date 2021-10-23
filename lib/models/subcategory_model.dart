import 'dart:convert';

class SubcategoryModel {
  String? idsubcategory;
  String? namesubcategory;
  SubcategoryModel({
    this.idsubcategory,
    this.namesubcategory,
  });

  SubcategoryModel copyWith({
    String? idsubcategory,
    String? namesubcategory,
  }) {
    return SubcategoryModel(
      idsubcategory: idsubcategory ?? this.idsubcategory,
      namesubcategory: namesubcategory ?? this.namesubcategory,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_subcategory': idsubcategory,
      'namesubcategory': namesubcategory,
    };
  }

  factory SubcategoryModel.fromMap(Map<String, dynamic> map) {
    return SubcategoryModel(
      idsubcategory:
          map['id_subcategory'] != null ? map['id_subcategory'] : null,
      namesubcategory:
          map['namesubcategory'] != null ? map['namesubcategory'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubcategoryModel.fromJson(String source) =>
      SubcategoryModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'SubcategoryModel(idsubcategory: $idsubcategory, namesubcategory: $namesubcategory)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubcategoryModel &&
        other.idsubcategory == idsubcategory &&
        other.namesubcategory == namesubcategory;
  }

  @override
  int get hashCode => idsubcategory.hashCode ^ namesubcategory.hashCode;
}
