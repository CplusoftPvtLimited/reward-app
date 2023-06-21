import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class RewardedScreen extends StatelessWidget {
  final int rewardPoint;
  const RewardedScreen({super.key, required this.rewardPoint});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
            height: 250,
            width: 250,
            child: Image.network(
                "https://www.pngmart.com/files/7/Rewards-PNG-HD.png")),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Thanks for the purchase",
                style: GoogleFonts.montserrat(fontSize: 25),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "You have been Awarded with ${rewardPoint} Points",
                style: GoogleFonts.montserrat(
                    fontSize: 30, fontWeight: FontWeight.w700),
              )
            ],
          ),
        )
      ]),
    );
  }
}
