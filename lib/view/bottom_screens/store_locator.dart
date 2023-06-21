import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rewardapp/controller/storeController.dart';

import '../../model/storeModel.dart';

class StoreLocatorScreen extends StatefulWidget {
  @override
  State<StoreLocatorScreen> createState() => _StoreLocatorScreenState();
}

class _StoreLocatorScreenState extends State<StoreLocatorScreen> {
  GoogleMapController? mapController;
  bool isSearchEnabled = false;
  Position? currentPosition;
  TextEditingController searchController = TextEditingController();
  Set<Marker> markers = Set();
  Set<Circle> circles = Set();
  void enableSearch() {
    setState(() {
      isSearchEnabled = true;
    });
  }

  void disableSearch() {
    setState(() {
      isSearchEnabled = false;
      searchController.clear();
    });
  }

  void performSearch(String searchText) {
    // Perform the search action based on the entered search text
    print('Searching for: $searchText');
  }

  Future<void> getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      currentPosition = position;
    });

    // // Update user's location marker
    // final userMarker = Marker(
    //   markerId: MarkerId('userLocation'),
    //   position: LatLng(position.latitude, position.longitude),
    //   infoWindow: InfoWindow(title: 'Your Location'),
    //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    // );
    // setState(() {
    //   markers.add(userMarker);
    // });

    // Create accuracy circle
    // final accuracyCircle = Circle(
    //   circleId: CircleId('accuracyCircle'),
    //   center: LatLng(position.latitude, position.longitude),
    //   radius: position.accuracy,
    //   fillColor: Colors.blue.withOpacity(0.1),
    //   strokeColor: Colors.blue,
    //   strokeWidth: 1,
    // );
    // setState(() {
    //   circles.add(accuracyCircle);
    // });

    // Set camera position to user's location
    mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(position.latitude, position.longitude),
        12,
      ),
    );
  }

  List<StoreModel> getFilteredModel(int range) {
    List<StoreModel> stores = [];
    Provider.of<StoreController>(context, listen: false)
        .stores
        .forEach((element) {
      if (calculateDistance(
              currentPosition!.latitude,
              currentPosition!.longitude,
              element.latitude!.toDouble(),
              element.longitude!.toDouble()) <
          range) {
        stores.add(element);
      }
    });

    return stores;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation().then((value) {
      mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(currentPosition!.latitude, currentPosition!.longitude),
          12,
        ),
      );
    });
    Provider.of<StoreController>(context, listen: false)
        .getStores()
        .then((value) {
      var storeData =
          Provider.of<StoreController>(context, listen: false).stores;

      storeData.forEach((element) {
        print(
            'lat : ${element.latitude} , long : ${element.longitude} , title : ${element.title}');
        markers.add(
          Marker(
            markerId: MarkerId(element.id.toString()),
            position: LatLng(element.latitude!.toDouble(),
                element.longitude!.toDouble()), // Example location
            infoWindow: InfoWindow(title: element.title),
          ),
        );
      });
    });
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // in kilometers

    final double dLat = _degreesToRadians(lat2 - lat1);
    final double dLon = _degreesToRadians(lon2 - lon1);

    final double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final double c = 2 * asin(sqrt(a));

    final double distance = earthRadius * c;
    return distance;
  }

  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }

  String searchWord = '';
  int filterRange = 0;
  @override
  Widget build(BuildContext context) {
    var storeProvider = Provider.of<StoreController>(context).stores;
    var searchStoresList = storeProvider.where((item) {
      final lowercaseItem = item.title!.toLowerCase();
      return lowercaseItem.contains(searchWord.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: isSearchEnabled
            ? Container(
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.all(5),
                child: TextField(
                  controller: searchController,
                  autofocus: true,
                  onChanged: (val) {
                    setState(() {
                      searchWord = val;
                    });
                  },
                  decoration: InputDecoration(
                    suffixIconColor: Colors.black,
                    hoverColor: Colors.black,
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                        onPressed: () {
                          disableSearch();
                        },
                        icon: Icon(Icons.close)),
                    hintText: 'Search For Store',
                  ),
                ),
              )
            : Text(
                "Locate Store",
                style: GoogleFonts.montserrat(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  // You can customize other properties like color, letterSpacing, etc.
                ),
              ),
        actions: [
          IconButton(
              onPressed: () {
                enableSearch();
              },
              icon: Icon(Icons.search)),
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return const [
                PopupMenuItem<String>(
                  value: '0',
                  child: Text('All'),
                ),
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
              setState(() {
                filterRange = int.parse(value);
              });
              print('Selected: $filterRange');
            },
            child: const Icon(
                Icons.filter_list_sharp), // Icon that triggers the dropdown
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          disableSearch();
        },
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: LatLng(0, 0), // Initial map position
                  zoom: 14,
                ),
                onMapCreated: (GoogleMapController controller) {
                  setState(() {
                    mapController = controller;
                  });
                },
                markers: markers,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: getFilteredModel(filterRange).isEmpty
                    ? ListView.builder(
                        itemCount: searchWord.isEmpty
                            ? storeProvider.length
                            : searchStoresList.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                searchWord.isEmpty
                                    ? storeProvider[index].title.toString()
                                    : searchStoresList[index].title.toString(),
                                style: GoogleFonts.montserrat(
                                  fontSize: 16.0,

                                  fontWeight: FontWeight.w700,
                                  // You can customize other properties like color, letterSpacing, etc.
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        searchWord.isEmpty
                                            ? storeProvider[index]
                                                .address
                                                .toString()
                                            : searchStoresList[index]
                                                .address
                                                .toString(),
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14.0,

                                          // You can customize other properties like color, letterSpacing, etc.
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "${calculateDistance(currentPosition!.latitude, currentPosition!.longitude, searchWord.isEmpty ? storeProvider[index].latitude!.toDouble() : searchStoresList[index].latitude!.toDouble(), searchWord.isEmpty ? storeProvider[index].longitude!.toDouble() : searchStoresList[index].longitude!.toDouble()).toStringAsFixed(2)} Km Away",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14.0,

                                          // You can customize other properties like color, letterSpacing, etc.
                                        ),
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      mapController?.animateCamera(
                                        CameraUpdate.newLatLngZoom(
                                          LatLng(
                                              searchWord.isEmpty
                                                  ? storeProvider[index]
                                                      .latitude!
                                                      .toDouble()
                                                  : searchStoresList[index]
                                                      .latitude!
                                                      .toDouble(),
                                              searchWord.isEmpty
                                                  ? storeProvider[index]
                                                      .longitude!
                                                      .toDouble()
                                                  : searchStoresList[index]
                                                      .longitude!
                                                      .toDouble()),
                                          14,
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Order Here",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateColor
                                          .resolveWith((states) =>
                                              Color.fromARGB(255, 46, 46, 46)),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              searchWord.isEmpty
                                  ? storeProvider[index].drivethru == true &&
                                          storeProvider[index].wifiaccess ==
                                              true
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
                                          : storeProvider[index].wifiaccess ==
                                                  true
                                              ? Column(
                                                  children: [
                                                    const Icon(Icons.wifi),
                                                    Text(
                                                      "Wifi-access",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontSize: 14.0,

                                                        // You can customize other properties like color, letterSpacing, etc.
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Container()
                                  : searchStoresList[index].drivethru == true &&
                                          searchStoresList[index].wifiaccess ==
                                              true
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
                                      : searchStoresList[index].drivethru ==
                                              true
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
                                          : searchStoresList[index]
                                                      .wifiaccess ==
                                                  true
                                              ? Column(
                                                  children: [
                                                    const Icon(Icons.wifi),
                                                    Text(
                                                      "Wifi-access",
                                                      style: GoogleFonts
                                                          .montserrat(
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
                      )
                    : ListView.builder(
                        itemCount: searchWord.isEmpty
                            ? getFilteredModel(filterRange).length
                            : searchStoresList.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                searchWord.isEmpty
                                    ? getFilteredModel(filterRange)[index]
                                        .title
                                        .toString()
                                    : searchStoresList[index].title.toString(),
                                style: GoogleFonts.montserrat(
                                  fontSize: 16.0,

                                  fontWeight: FontWeight.w700,
                                  // You can customize other properties like color, letterSpacing, etc.
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        searchWord.isEmpty
                                            ? getFilteredModel(
                                                    filterRange)[index]
                                                .address
                                                .toString()
                                            : searchStoresList[index]
                                                .address
                                                .toString(),
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14.0,

                                          // You can customize other properties like color, letterSpacing, etc.
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "${calculateDistance(currentPosition!.latitude, currentPosition!.longitude, searchWord.isEmpty ? getFilteredModel(filterRange)[index].latitude!.toDouble() : searchStoresList[index].latitude!.toDouble(), searchWord.isEmpty ? getFilteredModel(filterRange)[index].longitude!.toDouble() : searchStoresList[index].longitude!.toDouble()).toStringAsFixed(2)} Km Away",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14.0,

                                          // You can customize other properties like color, letterSpacing, etc.
                                        ),
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      mapController?.animateCamera(
                                        CameraUpdate.newLatLngZoom(
                                          LatLng(
                                              searchWord.isEmpty
                                                  ? getFilteredModel(
                                                          filterRange)[index]
                                                      .latitude!
                                                      .toDouble()
                                                  : searchStoresList[index]
                                                      .latitude!
                                                      .toDouble(),
                                              searchWord.isEmpty
                                                  ? getFilteredModel(
                                                          filterRange)[index]
                                                      .longitude!
                                                      .toDouble()
                                                  : searchStoresList[index]
                                                      .longitude!
                                                      .toDouble()),
                                          14,
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Order Here",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateColor
                                          .resolveWith((states) =>
                                              Color.fromARGB(255, 46, 46, 46)),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              searchWord.isEmpty
                                  ? getFilteredModel(filterRange)[index]
                                                  .drivethru ==
                                              true &&
                                          getFilteredModel(filterRange)[index]
                                                  .wifiaccess ==
                                              true
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
                                      : getFilteredModel(filterRange)[index]
                                                  .drivethru ==
                                              true
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
                                          : getFilteredModel(filterRange)[index]
                                                      .wifiaccess ==
                                                  true
                                              ? Column(
                                                  children: [
                                                    const Icon(Icons.wifi),
                                                    Text(
                                                      "Wifi-access",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontSize: 14.0,

                                                        // You can customize other properties like color, letterSpacing, etc.
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Container()
                                  : searchStoresList[index].drivethru == true &&
                                          searchStoresList[index].wifiaccess ==
                                              true
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
                                      : searchStoresList[index].drivethru ==
                                              true
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
                                          : searchStoresList[index]
                                                      .wifiaccess ==
                                                  true
                                              ? Column(
                                                  children: [
                                                    const Icon(Icons.wifi),
                                                    Text(
                                                      "Wifi-access",
                                                      style: GoogleFonts
                                                          .montserrat(
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
      ),
    );
  }
}
