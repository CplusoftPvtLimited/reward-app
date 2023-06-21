import 'package:flutter/material.dart';

class RewardController with ChangeNotifier {
  List<int> _rewardPoints = [];

  List<int> get rewardPoints {
    return [..._rewardPoints];
  }

  void addReward(int reward) {
    _rewardPoints.add(reward);

    notifyListeners();
  }

  int get reward {
    int total = 0;
    if (_rewardPoints.isNotEmpty) {
      for (int i = 0; i < _rewardPoints.length; i++) {
        total += _rewardPoints[i];
      }
    }

    return total;
  }
}
