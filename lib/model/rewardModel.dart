enum RewardStatus { Gain, Redeem }

class RewardModel {
  final String reward_points;
  final String userId;
  final String date;
  final RewardStatus status;

  RewardModel(this.date,
      {required this.reward_points,
      required this.userId,
      required this.status});

  factory RewardModel.fromJson(Map map) {
    return RewardModel(DateTime.now().toIso8601String(),
        reward_points: map['points'],
        userId: map['user_id'],
        status:
            map['status'] == "gain" ? RewardStatus.Gain : RewardStatus.Redeem);
  }
}
