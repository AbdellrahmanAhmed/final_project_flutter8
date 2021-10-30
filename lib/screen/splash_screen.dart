import 'dart:convert';

import 'package:final_project_flutter8/model/categories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import '../sa_constants.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

Future<DataModel> future;
DataModel dataModel = DataModel();

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    future = getData();
  }

  Future<DataModel> getData() async {
    /// Server LockUp - Get Response from it
    final response = await http
        .get(Uri.parse('https://retail.amit-learning.com/api/categories'));
    if (response.statusCode == 200) {
      // print('Data Model : ${jsonDecode(response.body)}');
      return dataModel = DataModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'asset/illustrations/Splash.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 30, left: 30, top: 650),
                      child: sASlideToAct(
                        text: Text(
                          "Abdellrahman Ahmed Abdelldaim",
                          style: sALargeTitleStyle.copyWith(fontSize: 12),
                        ),
                        iconcolor: Colors.deepOrange,
                        innercolor: Colors.white,
                        outerColor: Colors.black,
                        Screen: (FirebaseAuth.instance.currentUser == null)
                            ? LoginScreen()
                            : HomeScreen(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Container(),
            ),
          );
        }
      },
    );
  }
}


