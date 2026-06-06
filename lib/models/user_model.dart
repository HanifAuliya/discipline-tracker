class UserModel {
  final String? id;

  final String name;
  final String email;

  final int age;
  final double height;

  final double startWeight;
  final double targetBodyFat;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.age,
    required this.height,
    required this.startWeight,
    required this.targetBodyFat,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'age': age,
      'height': height,
      'start_weight': startWeight,
      'target_body_fat': targetBodyFat,
    };
  }
}
