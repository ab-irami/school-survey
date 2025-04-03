import 'package:school_survey/utils/exports.dart';

class SharedPrefs {
  static final SharedPrefs _instance = SharedPrefs._internal();
  SharedPreferences? _prefs;

  SharedPrefs._internal();

  static SharedPrefs get instance => _instance;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> setString(String key, String value) async =>
      _prefs?.setString(key, value) ?? false;

  String? getString(String key) => _prefs?.getString(key);

  Future<bool> remove(String key) async => _prefs?.remove(key) ?? false;

  Future<bool> clear() async => _prefs?.clear() ?? false;
}
