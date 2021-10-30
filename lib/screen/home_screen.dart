import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animations/animations.dart';
import 'package:final_project_flutter8/components/lists/categories_card_list.dart';
import 'package:final_project_flutter8/components/searchfield_widget.dart';
import 'package:final_project_flutter8/model/categories.dart';
import 'package:final_project_flutter8/screen/basket_screen.dart';
import 'package:final_project_flutter8/screen/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../sa_constants.dart';

const double _fabDimension = 56.0;

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  Animation<Offset> sidebarAnimation;
  Animation<double> fadeAnimation;
  AnimationController sidebarAnimationController;
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  var sidebarHidden = true;
  var photoURL = FirebaseAuth.instance.currentUser.photoURL;

  DateTime TimeBackPress = DateTime.now();
  Future<DataModel> future;
  DataModel dataModel = DataModel();

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
  void initState() {
    super.initState();
    sidebarAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    sidebarAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: sidebarAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: sidebarAnimationController,
        curve: Curves.bounceInOut,
      ),
    );
    future = getData();
  }

  @override
  void dispose() {
    super.dispose();
    sidebarAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(TimeBackPress);
        final isExitWarning = difference >= Duration(seconds: 2);
        TimeBackPress = DateTime.now();
        if (isExitWarning) {
          final message = "مرة أخرى للخروج";
          Fluttertoast.showToast(msg: message, fontSize: 12);
          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'asset/illustrations/Home.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              top: false,
              child: Container(
                child: Stack(
                  children: [
                    SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  const SearchFieldWidget(),
                                  const Icon(
                                    Icons.notifications,
                                    color: sAPrimaryLabelColor,
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      boxShadow: shadow,
                                      shape: BoxShape.circle,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        // Navigator.push(context, BouncyPageRoute(screen: ProfileScreen() ,millisecondsDuration: 90));
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProfileScreen(),
                                          ),
                                        );
                                      },
                                      child: CircleAvatar(
                                        // backgroundImage: AssetImage('asset/images/profile.jpg'),
                                        backgroundColor: Color(0xFFE7EEFB),
                                        child: photoURL != null
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                child: Image.network(
                                                  photoURL,
                                                  width: 60.0,
                                                  height: 60.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : Icon(Icons.person),
                                        radius: 18.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // Text(
                                  //   "Recents",
                                  //   style: sALargeTitleStyle.apply(
                                  //       color: Color(0xFF718EA4)),
                                  // ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 100,
                                        child: DefaultTextStyle(
                                          style: sALargeTitleStyle.apply(
                                              fontFamily: 'Horizon',
                                              color: Color(0xFF718EA4)),
                                          child: AnimatedTextKit(
                                            animatedTexts: [
                                              RotateAnimatedText('Fashion'),
                                              RotateAnimatedText('Electronics'),
                                              RotateAnimatedText(
                                                  'Baby Products'),
                                              RotateAnimatedText(
                                                  'Health & Beauty'),
                                              RotateAnimatedText('Phones'),
                                              RotateAnimatedText('Supermarket'),
                                            ],
                                            repeatForever: true,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "تسوق أفضل المنتجات مع أفضل الأسعار",
                                    style: sATitle1Style.apply(shadows: [
                                      const BoxShadow(
                                          color: Colors.black,
                                          offset: Offset(4, 3.5),
                                          blurRadius: 4.0,
                                          spreadRadius: 50)
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            CategoriesCardLists(),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                  top: 25.0,
                                  bottom: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "عروض اليوم",
                                        style: sATitle1Style.apply(shadows: [
                                          const BoxShadow(
                                              color: Colors.black,
                                              offset: Offset(4, 3.5),
                                              blurRadius: 4.0,
                                              spreadRadius: 50)
                                        ]),
                                      ),
                                      SizedBox(
                                        height: 38.0,
                                      ),
                                      Text(
                                        "لا توجد عروض لليوم..",
                                        textDirection: TextDirection.rtl,
                                        style: sASubtitleStyle.apply(
                                            color: Colors.white70),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // ContinueWatc/hingScreen(),
                    IgnorePointer(
                      ignoring: sidebarHidden,
                      child: Stack(
                        children: [
                          FadeTransition(
                            opacity: fadeAnimation,
                            child: GestureDetector(
                              child: Container(
                                color: const Color.fromRGBO(36, 38, 41, 0.6),
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                              ),
                              onTap: () {
                                setState(() {
                                  sidebarHidden = !sidebarHidden;
                                });
                                sidebarAnimationController.reverse();
                              },
                            ),
                          ),
                          // SlideTransition(
                          //   position: sidebarAnimation,
                          //   child: const Padding(
                          //     padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          //     child: SafeArea(
                          //       bottom: false,
                          //       top: false,
                          //       child: SidebarScreen(),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: OpenContainer(
            middleColor: sABackgroundColor,
            openColor: Theme.of(context).colorScheme.onSecondary,
            transitionDuration: Duration(milliseconds: 500),
            transitionType: _transitionType,
            openBuilder: (BuildContext context, VoidCallback) {
              return MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                home: MyHomePage(),
              );

              // return BasketScreen();
            },
            closedElevation: 6.0,
            closedShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(_fabDimension / 2),
              ),
            ),
            closedColor: sASecondaryLabelColor,
            closedBuilder: (BuildContext context, VoidCallback openContainer) {
              return SizedBox(
                height: _fabDimension,
                width: _fabDimension,
                child: Center(
                  child: Icon(
                    Icons.shopping_cart,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              );
            },
          )),
    );
  }
}
