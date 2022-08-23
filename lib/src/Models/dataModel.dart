// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class userData {
  String Name;
  String Email;
  int Age;
  int Weight;
  int Height;
  String Gender;
  String Goal;
  String Experience;
  int? Streak;
  int? Rank;
  int Level;
  userData({
    required this.Name,
    required this.Email,
    required this.Age,
    required this.Weight,
    required this.Height,
    required this.Gender,
    required this.Goal,
    required this.Experience,
    this.Streak,
    this.Rank,
    required this.Level,
  });

  userData copyWith({
    String? Name,
    String? Email,
    int? Age,
    int? Weight,
    int? Height,
    String? Gender,
    String? Goal,
    String? Experience,
    bool? signUp,
    int? Streak,
    int? Rank,
    int? Level,
  }) {
    return userData(
      Name: Name ?? this.Name,
      Email: Email ?? this.Email,
      Age: Age ?? this.Age,
      Weight: Weight ?? this.Weight,
      Height: Height ?? this.Height,
      Gender: Gender ?? this.Gender,
      Goal: Goal ?? this.Goal,
      Experience: Experience ?? this.Experience,
      Streak: Streak ?? this.Streak,
      Rank: Rank ?? this.Rank,
      Level: Level ?? this.Level,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Name': Name,
      'Email': Email,
      'Age': Age,
      'Weight': Weight,
      'Height': Height,
      'Gender': Gender,
      'Goal': Goal,
      'Experience': Experience,
      'Streak': Streak,
      'Rank': Rank,
      'Level': Level,
    };
  }

  factory userData.fromMap(Map<String, dynamic> map) {
    return userData(
      Name: map['Name'] as String,
      Email: map['Email'] as String,
      Age: map['Age'] as int,
      Weight: map['Weight'] as int,
      Height: map['Height'] as int,
      Gender: map['Gender'] as String,
      Goal: map['Goal'] as String,
      Experience: map['Experience'] as String,
      Streak: map['Streak'] != null ? map['Streak'] as int : null,
      Rank: map['Rank'] != null ? map['Rank'] as int : null,
      Level: map['Level'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory userData.fromJson(String source) =>
      userData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'userData(Name: $Name, Email: $Email, Age: $Age, Weight: $Weight, Height: $Height, Gender: $Gender, Goal: $Goal, Experience: $Experience, Streak: $Streak, Rank: $Rank, Level: $Level)';
  }

  @override
  bool operator ==(covariant userData other) {
    if (identical(this, other)) return true;

    return other.Name == Name &&
        other.Email == Email &&
        other.Age == Age &&
        other.Weight == Weight &&
        other.Height == Height &&
        other.Gender == Gender &&
        other.Goal == Goal &&
        other.Experience == Experience &&
        other.Streak == Streak &&
        other.Rank == Rank &&
        other.Level == Level;
  }

  @override
  int get hashCode {
    return Name.hashCode ^
        Email.hashCode ^
        Age.hashCode ^
        Weight.hashCode ^
        Height.hashCode ^
        Gender.hashCode ^
        Goal.hashCode ^
        Experience.hashCode ^
        Streak.hashCode ^
        Rank.hashCode ^
        Level.hashCode;
  }
}
