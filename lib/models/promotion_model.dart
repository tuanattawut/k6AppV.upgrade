import 'dart:convert';

class PromotionModel {
  String? id;
  String? image;
  String? createdAt;
  String? updatedAt;
  PromotionModel({
    this.id,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  PromotionModel copyWith({
    String? id,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) {
    return PromotionModel(
      id: id ?? this.id,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory PromotionModel.fromMap(Map<String, dynamic> map) {
    return PromotionModel(
      id: map['id'],
      image: map['image'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PromotionModel.fromJson(String source) =>
      PromotionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PromotionModel(id: $id, image: $image, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PromotionModel &&
        other.id == id &&
        other.image == image &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        image.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
