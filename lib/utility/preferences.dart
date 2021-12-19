import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  SharedPreferences? _prefs;

  String mediumKey = "MEDIUM";
  String stdKey = "STD";

  static Future<Preferences> instance() async {
    Preferences newInstance = Preferences();
    newInstance._prefs = await SharedPreferences.getInstance();
    return newInstance;
  }

  Future<void> saveMedium(int medium) async {
    await _prefs?.setInt(mediumKey, medium);
  }

  Future<void> saveStandard(int std) async {
    await _prefs?.setInt(stdKey, std);
  }

  Future<int> getMedium() async {
    return _getInt(mediumKey);
  }

  Future<int> getStandard() async {
    return _getInt(stdKey);
  }

  Future<int> _getInt(String key) async {
    return _prefs?.getInt(key) ?? 0;
  }

  Future<bool> hasMedium() {
    return _hasKey(mediumKey);
  }

  Future<bool> hasStd() {
    return _hasKey(stdKey);
  }

  Future<bool> _hasKey(String key) async {
    return _prefs?.get(key) != null;
  }
}
