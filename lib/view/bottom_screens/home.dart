import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rewardapp/controller/categoryControler.dart';
import 'package:rewardapp/controller/product_controller.dart';
import 'package:rewardapp/controller/rewardController.dart';

import '../product_screens/product_category_grid.dart';
import '../product_screens/product_details.dart';
import '../product_screens/product_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isListview = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProductController>(context, listen: false).getProducts();
    Provider.of<CategoryController>(context, listen: false).getCategories();
    isListview = true;
  }

  @override
  Widget build(BuildContext context) {
    var rewardProvider = Provider.of<RewardController>(context);
    var productProvider = Provider.of<ProductController>(context);
    var categoryProvider = Provider.of<CategoryController>(context);
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 44, 44, 44),
                    Color.fromARGB(255, 114, 114, 114)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                  height: MediaQuery.of(context).size.height / 4.3,
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      width: size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi Jhonson',
                            style: GoogleFonts.montserrat(
                              fontSize: 24.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              // You can customize other properties like color, letterSpacing, etc.
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "It's a great day for a donut",
                                style: GoogleFonts.montserrat(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  // You can customize other properties like color, letterSpacing, etc.
                                ),
                              ),
                              // Row(
                              //   children: [
                              //     Row(
                              //       children: const [
                              //         Icon(Icons.login),
                              //         Text('Login')
                              //       ],
                              //     ),
                              //     const SizedBox(
                              //       width: 20,
                              //     ),
                              //     Row(
                              //       children: const [
                              //         Icon(Icons.login),
                              //         Text('SignUp')
                              //       ],
                              //     ),
                              //   ],
                              // ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.settings,
                                    color: Colors.white,
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                    //Header End
                    //Reward Status Start
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black,
                                offset: Offset(1, 1),
                                blurRadius: 0.5,
                                spreadRadius: 0.2,
                                blurStyle: BlurStyle.inner)
                          ],
                          gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 46, 46, 46),
                                Color.fromARGB(255, 73, 61, 61)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Rewards",
                                style: GoogleFonts.montserrat(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  // You can customize other properties like color, letterSpacing, etc.
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                QrImageView(
                                  data: '1234567890',
                                  version: QrVersions.auto,
                                  foregroundColor: Colors.white,
                                  size: 100,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircularPercentIndicator(
                                          radius: 30.0,
                                          lineWidth: 5.0,
                                          percent: rewardProvider.reward /
                                              (rewardProvider.reward + 250),
                                          center: Text(
                                            "${rewardProvider.reward}⭐",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                          progressColor:
                                              Color.fromARGB(255, 255, 98, 98),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Today',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            // You can customize other properties like color, letterSpacing, etc.
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircularPercentIndicator(
                                          radius: 30.0,
                                          lineWidth: 5.0,
                                          percent: rewardProvider.reward /
                                              (rewardProvider.reward + 1000),
                                          center: Text(
                                            "${rewardProvider.reward}⭐",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                          progressColor:
                                              Color.fromARGB(255, 255, 98, 98),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Total',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            // You can customize other properties like color, letterSpacing, etc.
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        )),
                    //Reward Status End
                  ],
                )
              ],
            ),
            // Header Start

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                  child: Text(
                    "Categories",
                    style: GoogleFonts.montserrat(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      // You can customize other properties like color, letterSpacing, etc.
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductCategoryGridScreen(),
                          ));
                    },
                    child: const Text(
                      "view all",
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ),
            //Category Start
            Container(
              height: 110,
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 5),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryProvider.category.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductList(),
                          ));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        decoration: BoxDecoration(),
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 46, 46, 46),
                                      Color.fromARGB(255, 73, 61, 61)
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://www.shugarysweets.com/wp-content/uploads/2020/01/baked-chocolate-donuts-recipe.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              categoryProvider.category[index].title,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black
                                  // You can customize other properties like color, letterSpacing, etc.
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            //Category End
            //Menu Section Start
            Padding(
              padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Products",
                    style: GoogleFonts.montserrat(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      // You can customize other properties like color, letterSpacing, etc.
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              isListview = true;
                            });
                          },
                          icon: Icon(Icons.list)),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              isListview = false;
                            });
                          },
                          icon: Icon(Icons.grid_view_outlined))
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: isListview
                  ? ListView.builder(
                      itemCount: productProvider.products.length,
                      itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailsScreen(
                                        productProvider.products[index].id),
                                  ));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 2),
                                    child: ListTile(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 15),
                                      leading: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        height: 50,
                                        width: 50,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.network(
                                            "https://www.shugarysweets.com/wp-content/uploads/2020/01/baked-chocolate-donuts-recipe.jpg",
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        productProvider.products[index].title,
                                        style: GoogleFonts.montserrat(
                                            color: Colors.black
                                            // You can customize other properties like color, letterSpacing, etc.
                                            ),
                                      ),
                                      subtitle: const Text(
                                        "\$ 12.99",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      trailing: Text(
                                        "13 ⭐",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          // You can customize other properties like color, letterSpacing, etc.
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 1,
                                  )
                                ],
                              ),
                            ),
                          ))
                  : GridView.builder(
                      itemCount: productProvider.products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              mainAxisExtent: 160),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen(
                                    productProvider.products[index].id),
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromARGB(255, 212, 212, 212)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  height: 100,
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.network(
                                      "https://www.royal-donuts.de/wp-content/uploads/2022/02/cool-bombs-caramel-cool-flash-30705201938597_600x-300x300.png"),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  productProvider.products[index].title,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SizedBox(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        "\$ 12.99",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Text("13 ⭐",
                                          style: TextStyle(color: Colors.black))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
