import 'dart:convert';

class LimitshopModel {
  String? idsub;
  String? namesubcategory;
  String? number;
  LimitshopModel({
    this.idsub,
    this.namesubcategory,
    this.number,
  });

  LimitshopModel copyWith({
    String? idsub,
    String? namesubcategory,
    String? number,
  }) {
    return LimitshopModel(
      idsub: idsub ?? this.idsub,
      namesubcategory: namesubcategory ?? this.namesubcategory,
      number: number ?? this.number,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idsub': idsub,
      'namesubcategory': namesubcategory,
      'num': number,
    };
  }

  factory LimitshopModel.fromMap(Map<String, dynamic> map) {
    return LimitshopModel(
      idsub: map['idsub'] != null ? map['idsub'] : null,
      namesubcategory:
          map['namesubcategory'] != null ? map['namesubcategory'] : null,
      number: map['num'] != null ? map['num'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LimitshopModel.fromJson(String source) =>
      LimitshopModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'LimitshopModel(idsub: $idsub, namesubcategory: $namesubcategory, number: $number)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LimitshopModel &&
        other.idsub == idsub &&
        other.namesubcategory == namesubcategory &&
        other.number == number;
  }

  @override
  int get hashCode =>
      idsub.hashCode ^ namesubcategory.hashCode ^ number.hashCode;
}
