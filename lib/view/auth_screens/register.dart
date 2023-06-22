import 'package:flutter/material.dart';
import 'package:rewardapp/controller/auth_controller.dart';
import 'package:rewardapp/view/auth_screens/login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confromPassword = TextEditingController();

  bool passIsObscure = true;
  bool conformIsObscure = true;

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
                          "Sign Up",
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
                Form(
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
                          controller: _firstname,
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
                          controller: _lastname,
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
                          controller: _email,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "email is required";
                            }
                          },
                          decoration: const InputDecoration(
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
                        TextFormField(
                          obscureText: passIsObscure,
                          controller: _password,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "password is required";
                            }
                          },
                          decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 73, 61, 61)),
                              ),
                              prefixIcon: const Icon(Icons.lock),
                              border: const OutlineInputBorder(),
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    passIsObscure = !passIsObscure;
                                  },
                                  icon: Icon(Icons.remove_red_eye))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _confromPassword,
                          obscureText: conformIsObscure,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "password conformation is required";
                            } else if (val != _password.text) {
                              return "confrom password is not same as password";
                            }
                          },
                          decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 73, 61, 61)),
                              ),
                              prefixIcon: const Icon(Icons.lock),
                              border: const OutlineInputBorder(),
                              labelText: 'Confrom Password',
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    conformIsObscure = !conformIsObscure;
                                  },
                                  icon: Icon(Icons.remove_red_eye))),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: FloatingActionButton.extended(
                            backgroundColor: Colors.black45,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await AuthController()
                                    .SignUp(_firstname.text, _lastname.text,
                                        _email.text, _password.text)
                                    .then((value) {
                                  print(value);
                                  if (value == true) {
                                    _firstname.text = '';
                                    _lastname.text = '';
                                    _email.text = '';
                                    _password.text = '';
                                    _confromPassword.text = '';
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              content: const Text(
                                                  "You have been Registered"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                SignInScreen(),
                                                          ));
                                                    },
                                                    child:
                                                        const Text("Login Now"))
                                              ],
                                            ));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text("User Created")));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("Somthing Went Wrong")));
                                  }
                                });
                              }
                              // TODO: Implement sign-in functionality
                            },
                            label: Text('Join Now'),
                            icon: Icon(Icons.login),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
