// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:school_survey/utils/exports.dart';

class SurveyModel {
  String? name;
  String? urn;
  String? description;
  DateTime? commencementDate;
  DateTime? dueDate;
  String? assignedTo;
  String? assignedBy;
  SurveyStatus? status;

  SurveyModel({
    this.name,
    this.urn,
    this.description,
    this.commencementDate,
    this.dueDate,
    this.assignedTo,
    this.assignedBy,
    this.status,
  });

  SurveyModel copyWith({
    String? name,
    String? urn,
    String? description,
    DateTime? commencementDate,
    DateTime? dueDate,
    String? assignedTo,
    String? assignedBy,
    SurveyStatus? status,
  }) {
    return SurveyModel(
      name: name ?? this.name,
      urn: urn ?? this.urn,
      description: description ?? this.description,
      commencementDate: commencementDate ?? this.commencementDate,
      dueDate: dueDate ?? this.dueDate,
      assignedTo: assignedTo ?? this.assignedTo,
      assignedBy: assignedBy ?? this.assignedBy,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'urn': urn,
      'description': description,
      'commencementDate': commencementDate?.millisecondsSinceEpoch,
      'dueDate': dueDate?.millisecondsSinceEpoch,
      'assignedTo': assignedTo,
      'assignedBy': assignedBy,
      'status': status.toString(),
    };
  }

  factory SurveyModel.fromMap(Map<String, dynamic> map) {
    return SurveyModel(
      name: map['name'] != null ? map['name'] as String : null,
      urn: map['urn'] != null ? map['urn'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      commencementDate:
          map['commencementDate'] != null
              ? DateTime.fromMillisecondsSinceEpoch(
                map['commencementDate'] as int,
              )
              : null,
      dueDate:
          map['dueDate'] != null
              ? DateTime.fromMillisecondsSinceEpoch(map['dueDate'] as int)
              : null,
      assignedTo:
          map['assignedTo'] != null ? map['assignedTo'] as String : null,
      assignedBy:
          map['assignedBy'] != null ? map['assignedBy'] as String : null,
      status: SurveyStatus.values.firstWhere(
        (e) => e.toString() == map['status'],
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SurveyModel.fromJson(String source) =>
      SurveyModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
