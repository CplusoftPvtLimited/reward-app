import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewardapp/utils/auth_check.dart';
import 'package:rewardapp/view/auth_screens/login.dart';
import 'package:rewardapp/view/other_screens/history.dart';
import 'package:rewardapp/view/other_screens/profile_setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Card(
            child: Container(
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text("Logo Here"),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HistoryScreen(),
                  ));
            },
            child: Container(
              color: Color(0xffF1F1F1),
              child: ListTile(
                leading: const Icon(Icons.history),
                title: Text(
                  "History",
                  style: GoogleFonts.montserrat(),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileSettingScreen(),
                  ));
            },
            child: Container(
              color: Color(0xffF1F1F1),
              child: ListTile(
                leading: const Icon(Icons.password),
                title: Text(
                  "Change Profile",
                  style: GoogleFonts.montserrat(

                      // You can customize other properties like color, letterSpacing, etc.
                      ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          InkWell(
            onTap: () async {
              // Obtain shared preferences.
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();

              await prefs.remove('user').then((value) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AuthCheck(),
                    ));
              });
            },
            child: Container(
              color: Color(0xffF1F1F1),
              child: ListTile(
                leading: const Icon(Icons.logout),
                title: Text(
                  "Logout",
                  style: GoogleFonts.montserrat(

                      // You can customize other properties like color, letterSpacing, etc.
                      ),
                ),
              ),
            ),
          ),
        ],
      )),
    ));
  }
}
