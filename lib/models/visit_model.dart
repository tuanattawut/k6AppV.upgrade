import 'dart:convert';

class VisitModel {
  String? section;
  String? title;
  String? visit;
  VisitModel({
    this.section,
    this.title,
    this.visit,
  });

  VisitModel copyWith({
    String? section,
    String? title,
    String? visit,
  }) {
    return VisitModel(
      section: section ?? this.section,
      title: title ?? this.title,
      visit: visit ?? this.visit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'section': section,
      'title': title,
      'visit': visit,
    };
  }

  factory VisitModel.fromMap(Map<String, dynamic> map) {
    return VisitModel(
      section: map['section'] != null ? map['section'] : null,
      title: map['title'] != null ? map['title'] : null,
      visit: map['visit'] != null ? map['visit'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VisitModel.fromJson(String source) =>
      VisitModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'VisitModel(section: $section, title: $title, visit: $visit)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VisitModel &&
        other.section == section &&
        other.title == title &&
        other.visit == visit;
  }

  @override
  int get hashCode => section.hashCode ^ title.hashCode ^ visit.hashCode;
}
