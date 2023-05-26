import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailsScreen extends StatefulWidget {
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool _isExpanded = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              "Sweet Donut",
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w700,
                // You can customize other properties like color, letterSpacing, etc.
              ),
            )),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 46, 46, 46),
                            Color.fromARGB(255, 73, 61, 61)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                    ),
                    padding: EdgeInsets.all(10),
                    height: 250,
                    width: MediaQuery.of(context).size.width / 1,
                    child: Image.network(
                        'https://www.royal-donuts.de/wp-content/uploads/2022/02/cool-bombs-caramel-cool-flash-30705201938597_600x-300x300.png'),
                  ),
                  const Positioned(
                    top: 20,
                    left: 20,
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$ 12.99',
                      style: GoogleFonts.montserrat(
                        fontSize: 24.0,

                        fontWeight: FontWeight.w500,
                        // You can customize other properties like color, letterSpacing, etc.
                      ),
                    ),
                    Text(
                      'Reward 13⭐',
                      style: GoogleFonts.montserrat(
                        fontSize: 14.0,

                        fontWeight: FontWeight.w400,
                        // You can customize other properties like color, letterSpacing, etc.
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // ExpansionPanelList(
              //   elevation: 1,
              //   expandedHeaderPadding: EdgeInsets.zero,
              //   expansionCallback: (int index, bool isExpanded) {
              //     setState(() {
              //       _isExpanded = !isExpanded;
              //     });
              //   },
              //   children: [
              //     ExpansionPanel(

              //       headerBuilder: (BuildContext context, bool isExpanded) {
              //         return Container(
              //           padding: EdgeInsets.all(16),
              //           child: Text(
              //             'Nutrition Information',
              //             style: GoogleFonts.montserrat(
              //               fontSize: 18.0,

              //               fontWeight: FontWeight.w700,
              //               // You can customize other properties like color, letterSpacing, etc.
              //             ),
              //           ),
              //         );
              //       },
              //       body: Container(
              //         padding:
              //             EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(
              //               'Calories: 250',
              //               style: GoogleFonts.montserrat(
              //                 fontSize: 16.0,

              //                 fontWeight: FontWeight.w500,
              //                 // You can customize other properties like color, letterSpacing, etc.
              //               ),
              //             ),
              //             Text(
              //               'Fat: 10g',
              //               style: GoogleFonts.montserrat(
              //                 fontSize: 16.0,

              //                 fontWeight: FontWeight.w500,
              //                 // You can customize other properties like color, letterSpacing, etc.
              //               ),
              //             ),
              //             Text(
              //               'Carbohydrates: 35g',
              //               style: GoogleFonts.montserrat(
              //                 fontSize: 16.0,

              //                 fontWeight: FontWeight.w500,
              //                 // You can customize other properties like color, letterSpacing, etc.
              //               ),
              //             ),
              //             Text(
              //               'Protein: 5g',
              //               style: GoogleFonts.montserrat(
              //                 fontSize: 16.0,

              //                 fontWeight: FontWeight.w500,
              //                 // You can customize other properties like color, letterSpacing, etc.
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       isExpanded: _isExpanded,
              //     ),
              //   ],
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nutrition Information',
                          style: GoogleFonts.montserrat(
                            fontSize: 18.0,

                            fontWeight: FontWeight.w700,
                            // You can customize other properties like color, letterSpacing, etc.
                          ),
                        ),
                        SizedBox(height: 8),
                        Text('Calories: 250'),
                        Text('Fat: 10g'),
                        Text('Carbohydrates: 35g'),
                        Text('Protein: 5g'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
