import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewardapp/controller/auth_controller.dart';
import 'package:rewardapp/utils/auth_check.dart';
import 'package:rewardapp/view/auth_screens/forgot_password.dart';
import 'package:rewardapp/view/other_screens/bottom_nav.dart';

import 'register.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _rememberMe = false;
  bool passIsObscure = true;
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
                          "Sign In to Reward App",
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
                        controller: _email,
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
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _password,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Password required";
                          }
                        },
                        obscureText: passIsObscure,
                        decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 73, 61, 61)),
                          ),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                              onPressed: () {
                                passIsObscure = !passIsObscure;
                              },
                              icon: const Icon(Icons.remove_red_eye)),
                          labelText: 'Password',
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _rememberMe,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _rememberMe = value as bool;
                                  });
                                },
                              ),
                              Text('Remember Me'),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ForgetPasswordScreen(),
                                  ));
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            AuthController()
                                .Login(_email.text, _password.text)
                                .then((value) {
                              if (value) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const AuthCheck(),
                                    ));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Email Or Password is incorrect")));
                              }
                            });
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
                                "Login",
                                style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton.extended(
                  backgroundColor: Color.fromARGB(255, 73, 61, 61),
                  onPressed: () {
                    // TODO: Implement sign-in functionality
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ));
                  },
                  label: Text('Join Now'),
                  icon: Icon(Icons.login),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
