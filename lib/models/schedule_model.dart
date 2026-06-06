class ScheduleModel {
  String title;

  String time;

  String category;

  bool isDone;

  ScheduleModel({
    required this.title,
    required this.time,
    required this.category,
    this.isDone = false,
  });
}
