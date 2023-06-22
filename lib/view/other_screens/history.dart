import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rewardapp/controller/rewardController.dart';
import 'package:rewardapp/model/rewardModel.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});
  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    var rewardProvider = Provider.of<RewardController>(context).rewardPoints;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            title: Text(
              'History',
              style: GoogleFonts.montserrat(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.w500,
                // You can customize other properties like color, letterSpacing, etc.
              ),
            ),
          ),
          body: ListView.builder(
            itemCount: rewardProvider.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(
                rewardProvider[index].status == RewardStatus.Gain
                    ? "Gained"
                    : "Redeem",
                style: TextStyle(
                    color: rewardProvider[index].status == RewardStatus.Gain
                        ? Colors.green
                        : Colors.red),
              ),
              subtitle: Text(formatDate(rewardProvider[index].date)),
              trailing: Text(
                rewardProvider[index].status == RewardStatus.Gain
                    ? "+ ${rewardProvider[index].reward_points}"
                    : "- ${rewardProvider[index].reward_points}",
                style: TextStyle(
                    color: rewardProvider[index].status == RewardStatus.Gain
                        ? Colors.green
                        : Colors.red),
              ),
            ),
          )),
    );
  }
}
