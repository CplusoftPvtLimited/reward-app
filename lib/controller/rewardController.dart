import 'package:flutter/material.dart';

import '../model/rewardModel.dart';

class RewardController with ChangeNotifier {
  List<RewardModel> _rewardPoints = [];

  List<RewardModel> get rewardPoints {
    return [..._rewardPoints];
  }

  void addReward(RewardModel reward) {
    _rewardPoints.add(reward);

    notifyListeners();
  }

  int get reward {
    int total = 0;
    if (_rewardPoints.isNotEmpty) {
      for (int i = 0; i < _rewardPoints.length; i++) {
        total += _rewardPoints[i].reward_points;
      }
    }

    return total;
  }
}
