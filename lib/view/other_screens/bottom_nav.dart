import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/material.dart';

import '../bottom_screens/home.dart';
import '../bottom_screens/profile.dart';
import '../bottom_screens/qr_scan.dart';
import '../bottom_screens/store_locator.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBarScreen> {
  var _currentIndex = 0;

  Future<void> _requestLocationPermission() async {
    final PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      // Location permission granted
      // Perform necessary actions
    } else if (status.isDenied) {
      // Location permission denied
      // Show a dialog or message to the user
    } else if (status.isPermanentlyDenied) {
      // Location permission permanently denied
      // Show a dialog or message to the user with instructions on how to enable the permission
    }
  }

  List<Widget> _screens = [
    HomeScreen(),
    QRScannerScreen(),
    StoreLocatorScreen(),
    ProfileScreen()
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _requestLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomNavigationBar(
        iconSize: 30.0,
        selectedColor: Color.fromARGB(255, 73, 61, 61),
        strokeColor: Color(0x30040307),
        unSelectedColor: Color(0xffacacac),
        backgroundColor: Colors.white,
        items: [
          CustomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          CustomNavigationBarItem(
              icon: Icon(Icons.qr_code), title: Text("Scan")),
          CustomNavigationBarItem(
              icon: Icon(Icons.store), title: Text("Stores")),
          CustomNavigationBarItem(
              icon: Icon(Icons.person), title: Text("Profile")),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
