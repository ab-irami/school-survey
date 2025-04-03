import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:school_survey/utils/exports.dart';

part 'school_data_controller.g.dart';

@riverpod
class SchoolDataNotifier extends _$SchoolDataNotifier {
  @override
  List<SchoolDataModel> build() {
    return [];
  }

  void updateSchool(int index, SchoolDataModel school) {
    final updatedList = List<SchoolDataModel>.from(state);

    if (index < updatedList.length) {
      updatedList[index] = school;
    } else {
      updatedList.add(school);
    }

    state = updatedList;
  }

  SchoolDataModel getSchool(int index) {
    return index < state.length ? state[index] : SchoolDataModel();
  }
}
