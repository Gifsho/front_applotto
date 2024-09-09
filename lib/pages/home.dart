// ignore_for_file: prefer_const_constructors, unused_element, use_super_parameters, unused_import

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:my_project/pages/navpages/another.dart';
import 'package:my_project/pages/navpages/homePage.dart';
import 'package:my_project/pages/navpages/mylotto.dart';



class HomePage extends StatefulWidget {
  final int? cid;
  final String? token;

  const HomePage({Key? key, this.cid, this.token}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? email;
  int selectedIndex = 0;
  Widget currentPage = const Page1();

  @override
  void initState() {
    super.initState();
    if (widget.token != null) {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token!);
      email = jwtDecodedToken['email'] as String?;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Home'),
        automaticallyImplyLeading: false,
      ),
          bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'สลากของฉัน'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
          currentIndex: selectedIndex,
	  onTap: (int index) {
		setState(() {
		  selectedIndex = index;
		  if (selectedIndex == 0) {
			currentPage = const Page1();
		  } else if (selectedIndex == 1) {
			currentPage = const Page2();
		  }else if (selectedIndex == 2) {
			currentPage = const Page3();
		  }
            });
          },
        ),
        body: currentPage,
      );
    
  
      // body: Center(
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text('Welcome to Home Page'),
        //     SizedBox(height: 20),
        //     Text('CID: ${widget.cid ?? "Not provided"}'),
        //     Text('Token: ${widget.token ?? "Not provided"}'),
        //     Text('Email: ${email ?? "Not provided"}'),
        //   ],
        // ),
    //   ),
    // );
  }

  Widget _buildBackButton() {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
