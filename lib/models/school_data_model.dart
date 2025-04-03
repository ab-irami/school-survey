import 'dart:convert';

class SchoolDataModel {
  String? name;
  String? type;
  List<String>? curriculam;
  DateTime? establishedAt;
  List<String>? grades;

  SchoolDataModel({
    this.name,
    this.type,
    this.curriculam,
    this.establishedAt,
    this.grades,
  });

  SchoolDataModel copyWith({
    String? name,
    String? type,
    List<String>? curriculam,
    DateTime? establishedAt,
    List<String>? grades,
  }) {
    return SchoolDataModel(
      name: name ?? this.name,
      type: type ?? this.type,
      curriculam: curriculam ?? this.curriculam,
      establishedAt: establishedAt ?? this.establishedAt,
      grades: grades ?? this.grades,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'type': type,
      'curriculam': curriculam,
      'establishedAt': establishedAt?.millisecondsSinceEpoch,
      'grades': grades,
    };
  }

  factory SchoolDataModel.fromMap(Map<String, dynamic> map) {
    return SchoolDataModel(
      name: map['name'] != null ? map['name'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      curriculam:
          map['curriculam'] != null
              ? List<String>.from((map['curriculam'] as List<String>))
              : null,
      establishedAt:
          map['establishedAt'] != null
              ? DateTime.fromMillisecondsSinceEpoch(map['establishedAt'] as int)
              : null,
      grades:
          map['grades'] != null
              ? List<String>.from((map['grades'] as List<String>))
              : null,
    );
  }

  String toJson() => json.encode(toMap());
}
