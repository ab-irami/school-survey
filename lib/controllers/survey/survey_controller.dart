import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:school_survey/utils/exports.dart';

part 'survey_controller.g.dart';

@riverpod
class SurveyController extends _$SurveyController {
  @override
  FutureOr<List<SurveyModel>> build() async {
    return await _loadSurveys();
  }

  Future<List<SurveyModel>> _loadSurveys() async {
    state = AsyncValue.loading();
    final repository = ref.read(surveyRepositoryProvider);
    List<SurveyModel> surveys = [];
    state = await AsyncValue.guard(() async {
      surveys = await repository.loadSurveys();
      return surveys;
    });

    return surveys;
  }

  Future<void> addSurvey(SurveyModel survey) async {
    state = AsyncValue.loading();
    final repository = ref.read(surveyRepositoryProvider);
    state = await AsyncValue.guard(() async {
      await repository.addSurvey(survey);
      return _loadSurveys();
    });
  }

  Future<void> updateSurveyStatus(String? id, SurveyStatus status) async {
    state = const AsyncValue.loading();
    final repository = ref.read(surveyRepositoryProvider);
    state = await AsyncValue.guard(() async {
      await repository.moveSurveyToWithheld(id, status);
      return _loadSurveys();
    });
  }

  Future<void> updateSurvey(String? id, SurveyModel survey) async {
    state = const AsyncValue.loading();
    final repository = ref.read(surveyRepositoryProvider);
    state = await AsyncValue.guard(() async {
      await repository.updateSurvey(id, survey);
      return _loadSurveys();
    });
  }
}
