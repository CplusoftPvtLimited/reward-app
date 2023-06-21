import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../controller/product_controller.dart';
import 'product_details.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductController>(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          "Royal Bombs",
          style: GoogleFonts.montserrat(
            fontSize: 16.0,
            color: Colors.black,
            fontWeight: FontWeight.w700,
            // You can customize other properties like color, letterSpacing, etc.
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: GridView.builder(
          itemCount: productProvider.products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 250),
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
                    color: const Color.fromARGB(255, 73, 61, 61)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                          "https://www.royal-donuts.de/wp-content/uploads/2022/02/cool-bombs-caramel-cool-flash-30705201938597_600x-300x300.png"),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Cheese Cake",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "\$ 12.99",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text("13 ⭐", style: TextStyle(color: Colors.white))
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
    ));
  }
}
