class ScheduleModel {
  String title;

  String time;

  String category;

  bool isDone;

  bool notificationEnabled;

  String ringtone;

  ScheduleModel({
    required this.title,
    required this.time,
    required this.category,
    this.isDone = false,
    this.notificationEnabled = true,
    this.ringtone = "default",
  });
}
