import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:school_survey/utils/exports.dart';

part 'survey_repository.g.dart';

class SurveyRepository {
  Future<List<SurveyModel>> loadSurveys() async {
    final String? storedSurveys = SharedPrefs.instance.getString('surveys');
    if (storedSurveys != null) {
      final List<dynamic> jsonList = jsonDecode(storedSurveys);
      return jsonList.map((json) => SurveyModel.fromJson(json)).toList();
    }
    return [];
  }

  Future<void> saveSurveys(List<SurveyModel> surveys) async {
    final String encodedData = jsonEncode(
      surveys.map((survey) => survey.toJson()).toList(),
    );
    await SharedPrefs.instance.setString('surveys', encodedData);
  }

  Future<void> addSurvey(SurveyModel survey) async {
    final surveys = await loadSurveys();
    surveys.add(survey);
    await saveSurveys(surveys);
  }

  Future<void> moveSurveyToWithheld(String? urn, SurveyStatus status) async {
    final surveys = await loadSurveys();
    final updatedSurveys =
        surveys.map((survey) {
          if (survey.urn == urn) {
            return survey.copyWith(status: status);
          }
          return survey;
        }).toList();
    await saveSurveys(updatedSurveys);
  }

  Future<void> updateSurvey(String? urn, SurveyModel newSurvey) async {
    final surveys = await loadSurveys();
    final updatedSurveys =
        surveys.map((survey) {
          if (survey.urn == urn) {
            return newSurvey;
          }
          return survey;
        }).toList();
    await saveSurveys(updatedSurveys);
  }
}

@riverpod
SurveyRepository surveyRepository(Ref ref) {
  return SurveyRepository();
}
