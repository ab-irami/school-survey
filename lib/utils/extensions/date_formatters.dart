import 'package:school_survey/utils/exports.dart';

ymdDateFormat(DateTime? date) {
  return DateFormat('yyyy-MM-dd').format(date ?? DateTime.now());
}
