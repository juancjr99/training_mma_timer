import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static Future<void> saveSettings({
    required bool isSound,
    required bool isVibration,
    required bool isRotation,
    required bool isAlert,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSound', isSound);
    await prefs.setBool('isVibration', isVibration);
    await prefs.setBool('isRotation', isRotation);
    await prefs.setBool('isAlert', isAlert);
  }

  static Future<Map<String, bool>> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'isSound': prefs.getBool('isSound') ?? true,
      'isVibration': prefs.getBool('isVibration') ?? true,
      'isRotation': prefs.getBool('isRotation') ?? true,
      'isAlert': prefs.getBool('isAlert') ?? true,
    };
  }

  static Future<void> saveTimer({
    required int rounds,
    required int duration,
    required int restTime,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('rounds', rounds);
    await prefs.setInt('duration', duration);
    await prefs.setInt('restTime', restTime);
  }

  static Future<Map<String, int>> loadTimer() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'rounds': prefs.getInt('rounds') ?? 5,
      'duration': prefs.getInt('duration') ?? 10,
      'restTime': prefs.getInt('restTime') ?? 5,
    };
  }
}