import 'dart:convert';

Covid covidFromJson(String str) => Covid.fromJson(json.decode(str));

String covidToJson(Covid data) => json.encode(data.toJson());

class Covid {
  int confirmed;
  int recovered;
  int hospitalized;
  int deaths;
  int newConfirmed;
  int newRecovered;
  int newHospitalized;
  int newDeaths;
  String updateDate;
  String source;
  String devBy;
  String severBy;
  Covid({
    required this.confirmed,
    required this.recovered,
    required this.hospitalized,
    required this.deaths,
    required this.newConfirmed,
    required this.newRecovered,
    required this.newHospitalized,
    required this.newDeaths,
    required this.updateDate,
    required this.source,
    required this.devBy,
    required this.severBy,
  });

  Covid copyWith({
    int? confirmed,
    int? recovered,
    int? hospitalized,
    int? deaths,
    int? newConfirmed,
    int? newRecovered,
    int? newHospitalized,
    int? newDeaths,
    String? updateDate,
    String? source,
    String? devBy,
    String? severBy,
  }) {
    return Covid(
      confirmed: confirmed ?? this.confirmed,
      recovered: recovered ?? this.recovered,
      hospitalized: hospitalized ?? this.hospitalized,
      deaths: deaths ?? this.deaths,
      newConfirmed: newConfirmed ?? this.newConfirmed,
      newRecovered: newRecovered ?? this.newRecovered,
      newHospitalized: newHospitalized ?? this.newHospitalized,
      newDeaths: newDeaths ?? this.newDeaths,
      updateDate: updateDate ?? this.updateDate,
      source: source ?? this.source,
      devBy: devBy ?? this.devBy,
      severBy: severBy ?? this.severBy,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'confirmed': confirmed,
      'recovered': recovered,
      'hospitalized': hospitalized,
      'deaths': deaths,
      'newConfirmed': newConfirmed,
      'newRecovered': newRecovered,
      'newHospitalized': newHospitalized,
      'newDeaths': newDeaths,
      'updateDate': updateDate,
      'source': source,
      'devBy': devBy,
      'severBy': severBy,
    };
  }

  factory Covid.fromMap(Map<String, dynamic> map) {
    return Covid(
      confirmed: map['confirmed'],
      recovered: map['recovered'],
      hospitalized: map['hospitalized'],
      deaths: map['deaths'],
      newConfirmed: map['newConfirmed'],
      newRecovered: map['newRecovered'],
      newHospitalized: map['newHospitalized'],
      newDeaths: map['newDeaths'],
      updateDate: map['updateDate'],
      source: map['source'],
      devBy: map['devBy'],
      severBy: map['severBy'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Covid.fromJson(String source) => Covid.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Covid(confirmed: $confirmed, recovered: $recovered, hospitalized: $hospitalized, deaths: $deaths, newConfirmed: $newConfirmed, newRecovered: $newRecovered, newHospitalized: $newHospitalized, newDeaths: $newDeaths, updateDate: $updateDate, source: $source, devBy: $devBy, severBy: $severBy)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Covid &&
        other.confirmed == confirmed &&
        other.recovered == recovered &&
        other.hospitalized == hospitalized &&
        other.deaths == deaths &&
        other.newConfirmed == newConfirmed &&
        other.newRecovered == newRecovered &&
        other.newHospitalized == newHospitalized &&
        other.newDeaths == newDeaths &&
        other.updateDate == updateDate &&
        other.source == source &&
        other.devBy == devBy &&
        other.severBy == severBy;
  }

  @override
  int get hashCode {
    return confirmed.hashCode ^
        recovered.hashCode ^
        hospitalized.hashCode ^
        deaths.hashCode ^
        newConfirmed.hashCode ^
        newRecovered.hashCode ^
        newHospitalized.hashCode ^
        newDeaths.hashCode ^
        updateDate.hashCode ^
        source.hashCode ^
        devBy.hashCode ^
        severBy.hashCode;
  }
}
