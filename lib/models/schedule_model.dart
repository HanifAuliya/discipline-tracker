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

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "time": time,
      "category": category,
      "isDone": isDone,
      "reminderMode": reminderMode.name,
      "ringtone": ringtone,
    };
  }

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      title: json["title"],
      time: json["time"],
      category: json["category"],
      isDone: json["isDone"] ?? false,
      ringtone: json["ringtone"] ?? "default",
      reminderMode: ReminderMode.values.firstWhere(
        (e) => e.name == json["reminderMode"],
        orElse: () => ReminderMode.notification,
      ),
    );
  }
}
