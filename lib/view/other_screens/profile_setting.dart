import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rewardapp/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSettingScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back_ios_rounded)),
                        ),
                        const SizedBox(
                          height: 14.0,
                        ),
                        const Text(
                          "Profile Setting",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                FutureBuilder<SharedPreferences>(
                  future: SharedPreferences.getInstance(),
                  builder: (context, snapshot) {
                    var userModel = UserModel.fromJson(
                        jsonDecode(snapshot.data!.get('user').toString()));

                    if (snapshot.hasData) {
                      return Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Personal Information",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const Divider(
                                height: 25,
                              ),
                              TextFormField(
                                initialValue: userModel.firstName,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "field is required";
                                  }
                                },
                                decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 73, 61, 61)),
                                  ),
                                  prefixIcon: Icon(Icons.person),
                                  border: OutlineInputBorder(),
                                  labelText: 'First name',
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                initialValue: userModel.lastName,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "field is required";
                                  }
                                },
                                decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 73, 61, 61)),
                                  ),
                                  prefixIcon: Icon(Icons.person),
                                  border: OutlineInputBorder(),
                                  labelText: 'Last name',
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "Security",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const Divider(
                                height: 25,
                              ),
                              TextFormField(
                                initialValue: userModel.email,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "email is required";
                                  }
                                },
                                decoration: const InputDecoration(
                                  enabled: false,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 73, 61, 61)),
                                  ),
                                  prefixIcon: Icon(Icons.mail),
                                  border: OutlineInputBorder(),
                                  labelText: 'Email',
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // TextFormField(
                              //   validator: (val) {
                              //     if (val!.isEmpty) {
                              //       return "old password is required";
                              //     }
                              //   },
                              //   decoration: InputDecoration(
                              //       focusedBorder: const OutlineInputBorder(
                              //         borderSide: BorderSide(
                              //             color:
                              //                 Color.fromARGB(255, 73, 61, 61)),
                              //       ),
                              //       prefixIcon: const Icon(Icons.lock),
                              //       border: const OutlineInputBorder(),
                              //       labelText: 'Old Password',
                              //       suffixIcon: IconButton(
                              //           onPressed: () {},
                              //           icon: Icon(Icons.remove_red_eye))),
                              // ),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              TextFormField(
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "password is required";
                                  }
                                },
                                decoration: InputDecoration(
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 73, 61, 61)),
                                    ),
                                    prefixIcon: const Icon(Icons.lock),
                                    border: const OutlineInputBorder(),
                                    labelText: 'Password',
                                    suffixIcon: IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.remove_red_eye))),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: FloatingActionButton.extended(
                                  backgroundColor: Colors.black45,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text("User created")));
                                    }
                                    // TODO: Implement sign-in functionality
                                  },
                                  label: Text('Update'),
                                  icon: Icon(Icons.login),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
