import '../models/schedule_model.dart';

class ScheduleService {
  List<ScheduleModel> getDefaultSchedules() {
    return [
      ScheduleModel(
        title: "Tahajud",
        time: "04:00",
        category: "Ibadah",
        reminderMode: ReminderMode.alarm,
        ringtone: "adzan",
      ),

      ScheduleModel(title: "Qur'an", time: "04:30", category: "Ibadah"),

      ScheduleModel(title: "Lari Pagi", time: "05:30", category: "Workout"),

      ScheduleModel(
        title: "Belajar Dicoding",
        time: "07:00",
        category: "Belajar",
        reminderMode: ReminderMode.notification,
      ),
    ];
  }
}
