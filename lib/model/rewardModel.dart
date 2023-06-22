enum RewardStatus { Gain, Redeem }

class RewardModel {
  final int reward_points;
  final String userId;
  final DateTime date;
  final RewardStatus status;

  RewardModel(
      {required this.reward_points,
      required this.userId,
      required this.date,
      required this.status});

  factory RewardModel.fromJson(Map map) {
    return RewardModel(
        reward_points: map['reward_points'],
        userId: map['userId'],
        date: DateTime.now(),
        status:
            map['status'] == "Gain" ? RewardStatus.Gain : RewardStatus.Redeem);
  }
}
