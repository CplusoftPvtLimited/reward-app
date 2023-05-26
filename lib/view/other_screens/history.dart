import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        body: Center(
          child: Text(
            "No history yet!",
            style: GoogleFonts.montserrat(
              fontSize: 16.0,
              color: Colors.black,
              fontWeight: FontWeight.w400,
              // You can customize other properties like color, letterSpacing, etc.
            ),
          ),
        ),
      ),
    );
  }
}
