enum ReminderMode { silent, notification, alarm }

class ScheduleModel {
  String title;

  String time;

  String category;

  bool isDone;

  ReminderMode reminderMode;

  String ringtone;

  ScheduleModel({
    required this.title,
    required this.time,
    required this.category,
    this.isDone = false,
    this.reminderMode = ReminderMode.notification,
    this.ringtone = "default",
  });
}
