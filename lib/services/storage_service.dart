import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/schedule_model.dart';

class StorageService {
  static const String scheduleKey = "schedules";

  Future<void> saveSchedules(List<ScheduleModel> schedules) async {
    final prefs = await SharedPreferences.getInstance();

    final data = schedules.map((e) => e.toJson()).toList();

    await prefs.setString(scheduleKey, jsonEncode(data));
  }

  Future<List<ScheduleModel>> loadSchedules() async {
    final prefs = await SharedPreferences.getInstance();

    final raw = prefs.getString(scheduleKey);

    if (raw == null) {
      return [];
    }

    final decoded = jsonDecode(raw) as List;

    return decoded.map((e) => ScheduleModel.fromJson(e)).toList();
  }
}
