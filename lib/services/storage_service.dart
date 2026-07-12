import 'package:shared_preferences/shared_preferences.dart';
import '../models/bead_record.dart';
import '../utils/constants.dart';

class StorageService {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static int getTodayCount() => _prefs?.getInt(AppConstants.keyTodayCount) ?? 0;
  static Future<void> saveTodayCount(int count) async =>
      await _prefs?.setInt(AppConstants.keyTodayCount, count);

  static int getTotalCycles() =>
      _prefs?.getInt(AppConstants.keyTotalCycles) ?? 0;
  static Future<void> saveTotalCycles(int cycles) async =>
      await _prefs?.setInt(AppConstants.keyTotalCycles, cycles);

  static String getBeadTitle() =>
      _prefs?.getString(AppConstants.keyBeadTitle) ?? "ဂုဏ်တော်";
  static Future<void> saveBeadTitle(String title) async =>
      await _prefs?.setString(AppConstants.keyBeadTitle, title);

  static List<BeadRecord> getRecords() {
    final List<String>? recordsJson =
        _prefs?.getStringList(AppConstants.keyRecords);
    if (recordsJson == null) return [];
    return recordsJson.map((item) => BeadRecord.fromJson(item)).toList();
  }

  static Future<void> saveRecord(BeadRecord record) async {
    List<BeadRecord> currentRecords = getRecords();
    int index = currentRecords
        .indexWhere((r) => r.date == record.date && r.title == record.title);
    if (index >= 0) {
      currentRecords[index] = record;
    } else {
      currentRecords.add(record);
    }
    List<String> jsonList = currentRecords.map((r) => r.toJson()).toList();
    await _prefs?.setStringList(AppConstants.keyRecords, jsonList);
  }

  // Alarm Settings
  static int getAlarmHour() => _prefs?.getInt(AppConstants.keyAlarmHour) ?? 20;
  static int getAlarmMinute() =>
      _prefs?.getInt(AppConstants.keyAlarmMinute) ?? 0;
  static String getAlarmDesc() =>
      _prefs?.getString(AppConstants.keyAlarmDesc) ??
      "ပုတီးစိပ်ရန် အချိန်ကျပါပြီ";
  static bool isAlarmEnabled() =>
      _prefs?.getBool(AppConstants.keyAlarmEnabled) ?? false;

  static Future<void> saveAlarmSettings(
      int hour, int minute, String desc, bool enabled) async {
    await _prefs?.setInt(AppConstants.keyAlarmHour, hour);
    await _prefs?.setInt(AppConstants.keyAlarmMinute, minute);
    await _prefs?.setString(AppConstants.keyAlarmDesc, desc);
    await _prefs?.setBool(AppConstants.keyAlarmEnabled, enabled);
  }
}
