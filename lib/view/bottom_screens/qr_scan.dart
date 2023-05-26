import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/material.dart';

class QRScannerScreen extends StatefulWidget {
  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkPermissionStatus();
    });
  }

  Future<void> checkPermissionStatus() async {
    final status = await Permission.camera.status;
    if (status.isDenied) {
      requestPermission();
    }
  }

  Future<void> requestPermission() async {
    final status = await Permission.camera.request();
    if (status.isPermanentlyDenied) {
      print("perm");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showPermissionDialog();
      });
    }
    if (status.isDenied) {
      print("denied");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showPermissionDialog();
      });
    }
    if (status.isLimited) {
      print("limited");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showPermissionDialog();
      });
    }
  }

  void showPermissionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Camera Permission'),
          content: Text('Camera permission is required to proceed.'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Open Settings'),
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'QR Scanner',
          style: GoogleFonts.montserrat(
            fontSize: 16.0,
            color: Colors.black,
            fontWeight: FontWeight.w500,
            // You can customize other properties like color, letterSpacing, etc.
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: QRView(
              overlay: QrScannerOverlayShape(
                  borderColor: Colors.black, overlayColor: Colors.black45),
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      // Handle scanned QR code data
      print(scanData.code);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
