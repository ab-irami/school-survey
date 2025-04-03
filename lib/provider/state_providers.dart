import 'dart:math';

import 'package:school_survey/utils/exports.dart';

final scheduledSurveysProvider = Provider<List<SurveyModel>?>(
  (ref) =>
      ref
          .watch(surveyControllerProvider)
          .asData
          ?.value
          .where((s) => s.status == SurveyStatus.scheduled)
          .toList(),
);

final completedSurveysProvider = Provider<List<SurveyModel>?>(
  (ref) =>
      ref
          .watch(surveyControllerProvider)
          .asData
          ?.value
          .where((s) => s.status == SurveyStatus.completed)
          .toList(),
);

final withheldSurveysProvider = Provider<List<SurveyModel>?>(
  (ref) =>
      ref
          .watch(surveyControllerProvider)
          .asData
          ?.value
          .where((s) => s.status == SurveyStatus.withheld)
          .toList(),
);

final userProvider = StateProvider<UserModel?>((ref) => null);

final urnStateProvider = Provider<int>((ref) {
  final random = Random();
  return 10000 + random.nextInt(90000);
});

final commencementDatePickerProvider = StateProvider<DateTime>(
  (ref) => DateTime.now(),
);

final dueDatePickerProvider = StateProvider<DateTime>((ref) => DateTime.now());

final surveyNameProvider = StateProvider<String>((ref) => "");

final descriptionProvider = StateProvider<String>((ref) => "");

final assignedToProvider = StateProvider<String>((ref) => "");

final selectedSurveyForProgress = StateProvider<SurveyModel?>((ref) => null);

final isEditingSurveyProvider = StateProvider<bool>((ref) => false);

final schoolFormKeysProvider = StateProvider<Map<int, GlobalKey<FormState>>>(
  (ref) => {},
);

final schoolDataProvider = StateProvider<List<SchoolDataModel>?>((ref) => null);

final surveyingSchoolData = StateProvider<SchoolDataModel?>((ref) => null);

final schoolCountProvider = StateProvider<int>((ref) => 0);
