import 'package:final_project_flutter8/sa_constants.dart';
import 'package:final_project_flutter8/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  bool _iconColor = true;
  String email;
  String password;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  var name = "Enter your name...";
  var bio = "Enter your bio...";
  var address = "Enter your address...";
  bool _validate = false;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
      _iconColor = !_iconColor;
      _validate = !_validate;
    });
  }

  Future<void> updateUserData() {
    _firestore.collection("users").doc(_auth.currentUser.uid).set({
      'name': name,
      "bio": bio,
      "password": password,
      "address": address,
    }).then((value) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Success!'),
              content: Text('The profile data has been upgraded!'),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                              fullscreenDialog: false));
                    },
                    child: Text("Ok!"))
              ],
            );
          });
    }).catchError((error) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Uh-Oh!'),
              content: Text('$error'),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Try Again!"))
              ],
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'asset/illustrations/Login.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  transform: Matrix4.translationValues(0, 150, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Final Project\n Flutter 8",
                        style: sALargeTitleStyle.copyWith(
                            color: Colors.white, fontSize: 36.0),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 7.0,
                      ),
                      Text(
                        "Abdelrahman Ahmed Abdeldaim\nFaculty of Engineering, Port Said University",
                        style: sAHeadlineLabelStyle.copyWith(
                            color: Colors.white70),
                        textAlign: TextAlign.center,
                        textScaleFactor: 0.9,
                      )
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 53.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Text(
                            //   "Log in to",
                            //   style: kTitle1Style,
                            // ),
                            sATypewriter(
                              text: "Log in to",
                              style: sATitle1Style,
                              duration: 100,
                            ),
                            Text("Start spending money",
                                style: sATitle1Style.apply(
                                    color: const Color(0xFF4A47F5))),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              height: 130.0,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(14.0),
                                      boxShadow: shadow,
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 5.0,
                                            right: 16.0,
                                            left: 16.0,
                                          ),
                                          child: TextField(
                                            cursorColor: Colors.deepOrange,
                                            decoration: InputDecoration(
                                              icon: const Icon(
                                                Icons.email,
                                                color: sASecondaryLabelColor,
                                                size: 20.0,
                                              ),
                                              border: InputBorder.none,
                                              hintText: _validate
                                                  ? 'يرجى إدخال البريد الألكتروني'
                                                  : "Email Address",
                                              hintStyle: _validate
                                                  ? sACaptionLabelStyle
                                                      .copyWith(
                                                          color: Colors.red)
                                                  : sALoginInputTextStyle,
                                            ),
                                            style: sALoginInputTextStyle
                                                .copyWith(color: Colors.black),
                                            onChanged: (textEntered) {
                                              email = textEntered;
                                            },
                                          ),
                                        ),
                                        const Divider(
                                          thickness: 2.0,
                                        ),
                                        Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 5.0,
                                                right: 16.0,
                                                left: 16.0,
                                              ),
                                              child: TextField(
                                                enableInteractiveSelection:
                                                    false,
                                                cursorColor: Colors.deepOrange,
                                                obscureText: _obscureText,
                                                decoration: InputDecoration(
                                                  icon: const Icon(
                                                    Icons.lock,
                                                    color:
                                                        sASecondaryLabelColor,
                                                    size: 20.0,
                                                  ),
                                                  border: InputBorder.none,
                                                  hintText: _validate
                                                      ? 'يرجى إدخال كلمة السر'
                                                      : "Password",
                                                  hintStyle: _validate
                                                      ? sACaptionLabelStyle
                                                          .copyWith(
                                                              color: Colors.red)
                                                      : sALoginInputTextStyle,
                                                ),
                                                style: sALoginInputTextStyle
                                                    .copyWith(
                                                        color: Colors.black),
                                                onChanged: (textEntered) {
                                                  password = textEntered;
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  const SizedBox(
                                                    height: 45.0,
                                                  ),
                                                  GestureDetector(
                                                    onTap: _toggle,
                                                    child: Icon(
                                                      _iconColor
                                                          ? Icons.remove_red_eye
                                                          : Icons.remove,
                                                      color: _iconColor
                                                          ? sASecondaryLabelColor
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    print(email);
                                    print(password);
                                    if (email == null ||
                                        password == null ||
                                        email == "" ||
                                        password == "") {
                                      _toggle();
                                    } else {
                                      setState(() {
                                        _validate == false;
                                      });
                                      try {
                                        await _auth.signInWithEmailAndPassword(
                                            email: email, password: password);
                                        // creatNewUserData();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen(),
                                                fullscreenDialog: false));
                                      } on FirebaseAuthException catch (error) {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text("Error"),
                                              content: Text(error.message),
                                              actions: [
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text("Ok!"))
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    }
                                    ;
                                  },
                                  child: Container(
                                    child: Text(
                                      "Login",
                                      style: sACalloutLabelStyle.copyWith(
                                          color: Colors.white),
                                    ),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14.0),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF343477),
                                          Color(0xFF4A47F5),
                                        ],
                                      ),
                                    ),
                                    height: 47,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                _auth.sendPasswordResetEmail(email: email).then(
                                      (value) => {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text("Email Sent"),
                                              content: Text(
                                                  "The Password reset email has been sent"),
                                              actions: [
                                                FlatButton.icon(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  icon: Icon(Icons.done),
                                                  label: Text("Ok!"),
                                                )
                                              ],
                                            );
                                          },
                                        )
                                      },
                                    );
                              },
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Update Your Profile!'),
                                          content: Container(
                                            height: 300.0,
                                            decoration: BoxDecoration(
                                              color: sASecondaryLabelColor,
                                              borderRadius:
                                                  BorderRadius.circular(14.0),
                                              // boxShadow: shadow,
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(14.0),
                                                boxShadow: shadow,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    TextField(
                                                      cursorColor:
                                                          Colors.deepOrange,
                                                      decoration:
                                                          InputDecoration(
                                                        icon: const Icon(
                                                          Icons.person,
                                                          color:
                                                              sASecondaryLabelColor,
                                                          size: 20.0,
                                                        ),
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            "Enter your name",
                                                        hintStyle:
                                                            sALoginInputTextStyle,
                                                      ),
                                                      style:
                                                          sALoginInputTextStyle
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black),
                                                      onChanged: (textEntered) {
                                                        name = textEntered;
                                                      },
                                                    ),
                                                    Container(
                                                      height: 1,
                                                      child: Expanded(
                                                        child: Container(
                                                          height: 0.1,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFF5488F1),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    TextField(
                                                      cursorColor:
                                                          Colors.deepOrange,
                                                      decoration:
                                                          InputDecoration(
                                                        icon: const Icon(
                                                          Icons.email,
                                                          color:
                                                              sASecondaryLabelColor,
                                                          size: 20.0,
                                                        ),
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            "Email Address",
                                                        hintStyle:
                                                            sALoginInputTextStyle,
                                                      ),
                                                      style:
                                                          sALoginInputTextStyle
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black),
                                                      onChanged: (textEntered) {
                                                        email = textEntered;
                                                      },
                                                    ),
                                                    Container(
                                                      height: 1,
                                                      child: Expanded(
                                                        child: Container(
                                                          height: 0.1,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFF5488F1),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Stack(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            bottom: 3.0,
                                                            right: 0.0,
                                                            left: 0.0,
                                                          ),
                                                          child: TextField(
                                                            enableInteractiveSelection:
                                                                false,
                                                            cursorColor: Colors
                                                                .deepOrange,
                                                            obscureText:
                                                                _obscureText,
                                                            decoration:
                                                                InputDecoration(
                                                              icon: const Icon(
                                                                Icons.lock,
                                                                color:
                                                                    sASecondaryLabelColor,
                                                                size: 20.0,
                                                              ),
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              hintText:
                                                                  "Password",
                                                              hintStyle:
                                                                  sALoginInputTextStyle,
                                                            ),
                                                            style: sALoginInputTextStyle
                                                                .copyWith(
                                                                    color: Colors
                                                                        .black),
                                                            onChanged:
                                                                (textEntered) {
                                                              password =
                                                                  textEntered;
                                                            },
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 10.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              const SizedBox(
                                                                height: 45.0,
                                                              ),
                                                              GestureDetector(
                                                                onTap: _toggle,
                                                                child: Icon(
                                                                    Icons
                                                                        .remove_red_eye,
                                                                    color:
                                                                        sASecondaryLabelColor),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Container(
                                                      height: 1,
                                                      child: Expanded(
                                                        child: Container(
                                                          height: 0.1,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFF5488F1),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    TextField(
                                                      cursorColor:
                                                          Colors.deepOrange,
                                                      decoration:
                                                          InputDecoration(
                                                        icon: const Icon(
                                                          Icons.credit_card,
                                                          color:
                                                              sASecondaryLabelColor,
                                                          size: 20.0,
                                                        ),
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            "Enter your bio",
                                                        hintStyle:
                                                            sALoginInputTextStyle,
                                                      ),
                                                      style:
                                                          sALoginInputTextStyle
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black),
                                                      onChanged: (textEntered) {
                                                        bio = textEntered;
                                                      },
                                                    ),
                                                    Container(
                                                      height: 1,
                                                      child: Expanded(
                                                        child: Container(
                                                          height: 0.1,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFF5488F1),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    TextField(
                                                      cursorColor:
                                                          Colors.deepOrange,
                                                      decoration:
                                                          InputDecoration(
                                                        icon: const Icon(
                                                          Icons.location_on,
                                                          color:
                                                              sASecondaryLabelColor,
                                                          size: 20.0,
                                                        ),
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            "Enter your address",
                                                        hintStyle:
                                                            sALoginInputTextStyle,
                                                      ),
                                                      style:
                                                          sALoginInputTextStyle
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black),
                                                      onChanged: (textEntered) {
                                                        address = textEntered;
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          actions: [
                                            FlatButton(
                                                onPressed: () async {
                                                  Navigator.of(context).pop();
                                                  await _auth
                                                      .createUserWithEmailAndPassword(
                                                          email: email,
                                                          password: password)
                                                      .catchError((onError) {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title:
                                                                Text('Uh-Oh!'),
                                                            content: Text(
                                                                '$onError'),
                                                            actions: [
                                                              FlatButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                      "Try Again!"))
                                                            ],
                                                          );
                                                        });
                                                  }).then((value) {
                                                    updateUserData();
                                                  });
                                                },
                                                child: Text("Update!"))
                                          ],
                                        );
                                      });
                                },
                                child: Container(
                                  child: Text(
                                    "إنشاء حساب",
                                    style: TextStyle(
                                        color: Colors.teal.withOpacity(0.7),
                                        fontSize: 16.0),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
