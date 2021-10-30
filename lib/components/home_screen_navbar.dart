import 'package:final_project_flutter8/components/searchfield_widget.dart';
import 'package:final_project_flutter8/screen/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../sa_constants.dart';

class HomeScreenNavBAr extends StatelessWidget {
  HomeScreenNavBAr({Key key, @required this.triggerAnimation})
      : super(key: key);

  final triggerAnimation;
  var photoURL = FirebaseAuth.instance.currentUser.photoURL;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SidebarButton(
          //   triggerAnimation: triggerAnimation,
          // ),
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
                    builder: (context) => ProfileScreen(),
                  ),
                );
              },
              child: CircleAvatar(
                // backgroundImage: AssetImage('asset/images/profile.jpg'),
                backgroundColor: Color(0xFFE7EEFB),
                child: photoURL != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(18.0),
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
    );
  }
}
