import '../models/habit_model.dart';

class HabitService {
  List<HabitModel> getDefaultHabits() {
    return [
      HabitModel(title: "Tahajud"),

      HabitModel(title: "Subuh Tepat Waktu"),

      HabitModel(title: "Qur'an 1 Halaman"),

      HabitModel(title: "Murajaah Juz 30"),

      HabitModel(title: "Lari Pagi"),

      HabitModel(title: "Workout"),

      HabitModel(title: "Dicoding"),
    ];
  }
}
