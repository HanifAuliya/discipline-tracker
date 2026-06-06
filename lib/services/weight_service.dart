class WeightService {
  double calculateBMI({required double weight, required double height}) {
    final h = height / 100;

    return weight / (h * h);
  }

  double calculateTargetWeight({
    required double currentWeight,
    required double targetBodyFat,
  }) {
    // sementara sederhana

    if (targetBodyFat <= 15) {
      return currentWeight * 0.90;
    }

    if (targetBodyFat <= 18) {
      return currentWeight * 0.93;
    }

    return currentWeight * 0.95;
  }

  double calculateRemainingWeight({
    required double currentWeight,
    required double targetWeight,
  }) {
    return currentWeight - targetWeight;
  }

  int estimateWeeks({required double remainingWeight}) {
    return (remainingWeight / 0.7).ceil();
  }
}
