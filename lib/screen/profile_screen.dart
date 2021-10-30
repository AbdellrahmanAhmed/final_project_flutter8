import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_flutter8/sa_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var badges = [];

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance;

  var name = "Loading...";
  var bio = "Loading...";
  var photoURL = FirebaseAuth.instance.currentUser.photoURL;

  @override
  void initState() {
    super.initState();
    _auth.currentUser.reload();
    loadUserData();
    loadBadges();
  }

  Future getImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File _image = File(pickedFile.path);
      _storage
          .ref("profile_pictures/${_auth.currentUser.uid}.png")
          .putFile(_image)
          .then((snapshot) {
        snapshot.ref.getDownloadURL().then((url) {
          _firestore
              .collection("users")
              .doc(_auth.currentUser.uid)
              .update({'profilePic': url}).then((value) {
            _auth.currentUser.updateProfile(photoURL: url);
          });
        });
      });
    } else {}
  }

  void loadUserData() {
    _firestore
        .collection("users")
        .doc(_auth.currentUser.uid)
        .get()
        .then((snapshot) {
      setState(() {
        name = snapshot.data()["name"];
        bio = snapshot.data()["bio"];
      });
    });
  }

  void updateUserData() {
    _firestore.collection("users").doc(_auth.currentUser.uid).update({
      'name': name,
      "bio": bio,
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
                      Navigator.of(context).pop();
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

  void loadBadges() {
    _firestore
        .collection("users")
        .doc(_auth.currentUser.uid)
        .get()
        .then((snapshot) {
      for (var badge in snapshot.data()["badges"]) {
        _storage.ref("badges/$badge").getDownloadURL().then((url) {
          setState(() {
            badges.add(url);
          });
        });
      }
      ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pop();
        },
        label: const Text('Back'),
        icon: const Icon(Icons.arrow_back),
        backgroundColor: sABackgroundColor,
        splashColor: sASecondarBackgroundColor,
        elevation: 10,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                getImage();
              },
              child: Container(
                child: Container(
                  child: CircleAvatar(
                    // backgroundImage: AssetImage('asset/images/profile.jpg'),
                    backgroundColor: Color(0xFFE7EEFB),
                    child: photoURL != null
                        ? ClipRRect(
                            child: Image.network(
                              photoURL,
                              fit: BoxFit.fitWidth,
                              width: MediaQuery.of(context).size.width,
                            ),
                          )
                        : Icon(
                            Icons.person,
                            size: 100,
                          ),
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Container(
              transform: Matrix4.translationValues(0, -65, 0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5 + 65,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(65.0)),
                  color: Colors.grey.shade100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(name, style: sALargeTitleStyle),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              bio,
                              style: sATitle2Style.apply(
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Update Your Profile!'),
                                        content: Container(
                                          height: 130.0,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
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
                                                    decoration: InputDecoration(
                                                      icon: const Icon(
                                                        Icons.person,
                                                        color:
                                                            Color(0xFF5488F1),
                                                        size: 20.0,
                                                      ),
                                                      border: InputBorder.none,
                                                      hintText: "Email Address",
                                                      hintStyle:
                                                          sALoginInputTextStyle,
                                                    ),
                                                    style: sALoginInputTextStyle
                                                        .copyWith(
                                                            color:
                                                                Colors.black),
                                                    onChanged: (textEntered) {
                                                      name = textEntered;
                                                    },
                                                    controller:
                                                        TextEditingController(
                                                            text: name),
                                                  ),
                                                  Container(
                                                    height: 1,
                                                    child: Expanded(
                                                      child: Container(
                                                        height: 0.1,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFF5488F1),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  TextField(
                                                    cursorColor:
                                                        Colors.deepOrange,
                                                    decoration: InputDecoration(
                                                      icon: const Icon(
                                                        Icons.credit_card,
                                                        color:
                                                            Color(0xFF5488F1),
                                                        size: 20.0,
                                                      ),
                                                      border: InputBorder.none,
                                                      hintText: "Email Address",
                                                      hintStyle:
                                                          sALoginInputTextStyle,
                                                    ),
                                                    style: sALoginInputTextStyle
                                                        .copyWith(
                                                            color:
                                                                Colors.black),
                                                    onChanged: (textEntered) {
                                                      bio = textEntered;
                                                    },
                                                    controller:
                                                        TextEditingController(
                                                            text: bio),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        actions: [
                                          FlatButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                updateUserData();
                                              },
                                              child: Text("Update!"))
                                        ],
                                      );
                                    });
                              },
                              child: Container(
                                width: 350.0,
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14.0),
                                    gradient: LinearGradient(colors: [
                                      sASecondarBackgroundColor,
                                      sABackgroundColor
                                    ])),
                                child: Icon(
                                  Platform.isAndroid
                                      ? Icons.edit
                                      : CupertinoIcons.pencil,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
