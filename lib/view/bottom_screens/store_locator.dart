import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rewardapp/controller/storeController.dart';

class StoreLocatorScreen extends StatefulWidget {
  @override
  State<StoreLocatorScreen> createState() => _StoreLocatorScreenState();
}

class _StoreLocatorScreenState extends State<StoreLocatorScreen> {
  GoogleMapController? mapController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<StoreController>(context, listen: false).getStores();
  }

  @override
  Widget build(BuildContext context) {
    var storeProvider = Provider.of<StoreController>(context).stores;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Locate Store",
          style: GoogleFonts.montserrat(
            fontSize: 16.0,
            color: Colors.black,
            fontWeight: FontWeight.w500,
            // You can customize other properties like color, letterSpacing, etc.
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return const [
                PopupMenuItem<String>(
                  value: '10',
                  child: Text('10 Km'),
                ),
                PopupMenuItem<String>(
                  value: '25',
                  child: Text('20 KM'),
                ),
                PopupMenuItem<String>(
                  value: '50',
                  child: Text('50 KM'),
                ),
                PopupMenuItem<String>(
                  value: '100',
                  child: Text('100 KM'),
                ),
              ];
            },
            onSelected: (String value) {
              // Handle menu item selection here
              print('Selected: $value');
            },
            child: const Icon(
                Icons.filter_list_sharp), // Icon that triggers the dropdown
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    37.7749, -122.4194), // Initial map location (San Francisco)
                zoom: 12.0, // Initial zoom level
              ),
              onMapCreated: (GoogleMapController controller) {
                setState(() {
                  mapController = controller;
                });
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: storeProvider.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    storeProvider[index].title.toString(),
                    style: GoogleFonts.montserrat(
                      fontSize: 16.0,

                      fontWeight: FontWeight.w700,
                      // You can customize other properties like color, letterSpacing, etc.
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Liwa Road Madinat Zayed , Abu Dabi",
                    style: GoogleFonts.montserrat(
                      fontSize: 14.0,

                      // You can customize other properties like color, letterSpacing, etc.
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "1358.4 Km . Open Until 12:00 AM",
                    style: GoogleFonts.montserrat(
                      fontSize: 14.0,

                      // You can customize other properties like color, letterSpacing, etc.
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  storeProvider[index].drivethru == true &&
                          storeProvider[index].wifiaccess == true
                      ? Row(
                          children: [
                            Column(
                              children: [
                                const Icon(Icons.drive_eta),
                                Text(
                                  "Drive-Thru",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14.0,

                                    // You can customize other properties like color, letterSpacing, etc.
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Column(
                              children: [
                                const Icon(Icons.wifi),
                                Text(
                                  "Wifi-access",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14.0,

                                    // You can customize other properties like color, letterSpacing, etc.
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : storeProvider[index].drivethru == true
                          ? Column(
                              children: [
                                const Icon(Icons.drive_eta),
                                Text(
                                  "Drive-Thru",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14.0,

                                    // You can customize other properties like color, letterSpacing, etc.
                                  ),
                                ),
                              ],
                            )
                          : storeProvider[index].wifiaccess == true
                              ? Column(
                                  children: [
                                    const Icon(Icons.wifi),
                                    Text(
                                      "Wifi-access",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14.0,

                                        // You can customize other properties like color, letterSpacing, etc.
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                  const Divider(),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
