import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/rewardModel.dart';
import '../utils/api_url.dart';

class RewardController with ChangeNotifier {
  List<RewardModel> _rewardPoints = [];

  List<RewardModel> get rewardPoints {
    return [..._rewardPoints];
  }

  Future<void> addReward(RewardModel reward) async {
    try {
      print(reward.userId);
      print(reward.reward_points);
      print(reward.status);
      var response =
          await http.post(Uri.parse('${ApiUrl.BASE_URL}${ApiUrl.REWARD}'),
              body: jsonEncode({
                "user_id": "12312",
                "points": "200",
                "status": reward.status == RewardStatus.Gain ? "gain" : "redeem"
              }));
      if (response.statusCode == 200) {
        _rewardPoints.add(reward);
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  int get reward {
    int total = 0;
    if (_rewardPoints.isNotEmpty) {
      for (int i = 0; i < _rewardPoints.length; i++) {
        total += int.parse(_rewardPoints[i].reward_points);
      }
    }

    return total;
  }
}
