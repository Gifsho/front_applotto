// ignore_for_file: camel_case_types, use_build_context_synchronously, sort_child_properties_last, non_constant_identifier_names, unused_element

import 'dart:convert';

import 'package:flutter/material.dart';


import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

// import 'package:lotto_app/pages/home.dart';
import 'package:my_project/config/config.dart';
import 'package:my_project/config/configg.dart';
import 'package:my_project/pages/home.dart';
import 'package:my_project/pages/reg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  String url = '';
  String text = "";
  TextEditingController emailNoCtl = TextEditingController();
  TextEditingController passNoCtl = TextEditingController();
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPref();
    Configuration.getConfig().then(
      (value) {
        dev.log(value['apiEndpoint']);
        url = value['apiEndpoint'];
      },
    );
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  // void loginUser() async {
  //   if (emailNoCtl.text.isNotEmpty && passNoCtl.text.isNotEmpty) {
  //     var reqBody = {
  //       "email": emailNoCtl.text,
  //       "password": passNoCtl.text,
  //     };

  //     try {
  //        var response = await http.post(Uri.parse(login),
  //           headers: {"Content-Type": "application/json"},
  //           body: jsonEncode(reqBody));

  //       var jsonResponse = jsonDecode(response.body);
  //       if (jsonResponse['status']) {
  //         var myToken = jsonResponse['token'];
  //         prefs.setString('token', myToken);

  //         // Navigate to HomePage
  //         Navigator.of(context).pushReplacement(MaterialPageRoute(
  //             builder: (context) => HomePage(token: myToken)));
  //       } else {
  //         setState(() {
  //           text = "Login failed. Please check your credentials.";
  //         });
  //         dev.log('Login failed: ${jsonResponse['message'] ?? "Unknown error"}');
  //         _showSnackBar("Login failed. Please check your credentials.");
  //       }
  //     } catch (e) {
  //       setState(() {
  //         text = "An error occurred. Please try again later.";
  //       });
  //       dev.log('Error during login: $e');
  //       _showSnackBar("An error occurred. Please try again later.");
  //     }
  //   } else {
  //     setState(() {
  //       text = "Please enter both email and password.";
  //     });
  //     _showSnackBar("Please enter both email and password.");
  //   }
  // }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0E0E0),
      body: Stack(
        children: [
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                color: Color(0xFFD1C4E9),
                shape: BoxShape.circle,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    const Text(
                      'Lotto',
                      style: TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Welcome onboard!',
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: emailNoCtl,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.person, color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: passNoCtl,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock, color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: loginUser,
                        child: const Text('Login',
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7E57C2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account? ",
                            style: TextStyle(color: Colors.grey[600])),
                        GestureDetector(
                          onTap: _navigateToRegister,
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                                color: Color(0xFF7E57C2),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToRegister() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RegisterPage(),
        ));
  }

  void loginUser() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ));
  }
}