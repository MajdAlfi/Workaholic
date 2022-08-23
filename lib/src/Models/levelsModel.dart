// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class levelsModel {
  String? Thumb;
  String? exName;
  int? day;
  String? vidUrl;
  String? desc;
  levelsModel({
    this.Thumb,
    this.exName,
    this.day,
    this.vidUrl,
    this.desc,
  });

  levelsModel copyWith({
    String? Thumb,
    String? exName,
    int? day,
    String? vidUrl,
    String? desc,
  }) {
    return levelsModel(
      Thumb: Thumb ?? this.Thumb,
      exName: exName ?? this.exName,
      day: day ?? this.day,
      vidUrl: vidUrl ?? this.vidUrl,
      desc: desc ?? this.desc,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Thumb': Thumb,
      'exName': exName,
      'day': day,
      'vidUrl': vidUrl,
      'desc': desc,
    };
  }

  factory levelsModel.fromMap(Map<String, dynamic> map) {
    return levelsModel(
      Thumb: map['Thumb'] as String,
      exName: map['exName'] as String,
      day: map['day'] as int,
      vidUrl: map['vidUrl'] as String,
      desc: map['desc'] != null ? map['desc'] as String : null,
    );
  }
  factory levelsModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return levelsModel(
      Thumb: data?['Thumb'] as String,
      exName: data?['exName'] as String,
      day: data?['day'] as int,
      vidUrl: data?['vidUrl'] as String,
      desc: data?['desc'] != null ? data!['desc'] as String : null,
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (Thumb != null) "name": Thumb,
      if (exName != null) "state": exName,
      if (day != null) "country": day,
      if (vidUrl != null) "capital": vidUrl,
      if (desc != null) "population": desc,
    };
  }

  String toJson() => json.encode(toMap());

  factory levelsModel.fromJson(String source) =>
      levelsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'levelsModel(Thumb: $Thumb, exName: $exName, day: $day, vidUrl: $vidUrl, desc: $desc)';
  }

  @override
  bool operator ==(covariant levelsModel other) {
    if (identical(this, other)) return true;

    return other.Thumb == Thumb &&
        other.exName == exName &&
        other.day == day &&
        other.vidUrl == vidUrl &&
        other.desc == desc;
  }

  @override
  int get hashCode {
    return Thumb.hashCode ^
        exName.hashCode ^
        day.hashCode ^
        vidUrl.hashCode ^
        desc.hashCode;
  }
}
