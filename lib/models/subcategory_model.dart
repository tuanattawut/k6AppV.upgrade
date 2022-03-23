import 'dart:convert';

class SubcategoryModel {
  String? id;
  String? namesubcategory;
  SubcategoryModel({
    this.id,
    this.namesubcategory,
  });

  SubcategoryModel copyWith({
    String? id,
    String? namesubcategory,
  }) {
    return SubcategoryModel(
      id: id ?? this.id,
      namesubcategory: namesubcategory ?? this.namesubcategory,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'namesubcategory': namesubcategory,
    };
  }

  factory SubcategoryModel.fromMap(Map<String, dynamic> map) {
    return SubcategoryModel(
      id: map['id'],
      namesubcategory: map['namesubcategory'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SubcategoryModel.fromJson(String source) =>
      SubcategoryModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'SubcategoryModel(id: $id, namesubcategory: $namesubcategory)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubcategoryModel &&
        other.id == id &&
        other.namesubcategory == namesubcategory;
  }

  @override
  int get hashCode => id.hashCode ^ namesubcategory.hashCode;
}
