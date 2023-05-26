import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewardapp/view/product_screens/product_list.dart';

import 'product_details.dart';

class ProductCategoryGridScreen extends StatelessWidget {
  const ProductCategoryGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          "Categories",
          style: GoogleFonts.montserrat(
            fontSize: 14.0,
            color: Colors.black,
            fontWeight: FontWeight.w700,
            // You can customize other properties like color, letterSpacing, etc.
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: GridView.builder(
          itemCount: 8,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 200),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductList(),
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
                    color: const Color.fromARGB(255, 73, 61, 61)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      padding: EdgeInsets.all(10),
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          "https://www.shugarysweets.com/wp-content/uploads/2020/01/baked-chocolate-donuts-recipe.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Royal Bombs",
                        style: GoogleFonts.montserrat(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          // You can customize other properties like color, letterSpacing, etc.
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
