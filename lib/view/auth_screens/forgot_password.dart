import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewardapp/view/other_screens/bottom_nav.dart';

import 'register.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  State<ForgetPasswordScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3.5,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25)),
                      gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 46, 46, 46),
                            Color.fromARGB(255, 73, 61, 61)
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: MediaQuery.of(context).size.width / 3,
                    child: Center(
                      child: SizedBox(
                        height: 150,
                        width: 150,
                        child: Image.network(
                            "https://cdn-icons-png.flaticon.com/512/2282/2282515.png"),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Forgot Password?",
                          style: GoogleFonts.montserrat(
                            fontSize: 24.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            // You can customize other properties like color, letterSpacing, etc.
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Email required";
                          }
                        },
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 73, 61, 61)),
                          ),
                          prefixIcon: Icon(Icons.email),
                          focusColor: Colors.black45,
                          labelText: 'Email',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const BottomNavBarScreen(),
                                ));
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 46, 46, 46),
                                  Color.fromARGB(255, 73, 61, 61)
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.login,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Send",
                                style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
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
