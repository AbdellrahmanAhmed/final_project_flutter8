import 'dart:async';
import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:final_project_flutter8/salibrary/sa_slide_to_act.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';




// Colors
const sABackgroundColor = Color(0xFF343477);
const sASecondarBackgroundColor = Color(0xFF4A47F5);
const sASidebarBackgroundColor = Color(0xFFF1F4FB);
const sACardPopupBackgroundColor = Color(0xFFF5F8FF);
const sAPrimaryLabelColor = Color(0xFF7C9F36);
const sASecondaryLabelColor = Color(0xFF661141);
const sAShadowColor = Color.fromRGBO(72, 76, 82, 0.1607843137254902);
const sACourseElementIconColor = Color(0xFF17294D);

List<BoxShadow> shadow = [
  const BoxShadow(
      color: sAShadowColor,
      offset: Offset(0, 0),
      blurRadius: 4.0,
      spreadRadius: 5)
];

class BouncyPageRoute extends PageRouteBuilder {
  final Widget widget;
  final Widget screen;
  final int millisecondsDuration;

  BouncyPageRoute({this.widget, this.screen, this.millisecondsDuration})
      : super(
            transitionDuration: Duration(milliseconds: millisecondsDuration),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> seccAnimation,
                Widget child) {
              animation =
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut);
              return ScaleTransition(
                scale: animation,
                alignment: Alignment.topRight,
                child: child,
              );
            },
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> seccAnimation) {
              return screen;
            });
}

class sATypewriter extends StatelessWidget {
  final text;
  final duration;
  final style;

  sATypewriter({
    this.text,
    this.style,
    this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.0,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 30.0,
          fontFamily: 'Agne',
        ),
        child: AnimatedTextKit(
          totalRepeatCount: 1,
          animatedTexts: [
            TypewriterAnimatedText(
              text,
              textStyle: style,
              speed: Duration(milliseconds: duration),
            ),
            // TypewriterAnimatedText('Design first, then code'),
            // TypewriterAnimatedText('Do not patch bugs out, rewrite them'),
            // TypewriterAnimatedText('Do not test bugs out, design them out'),
          ],
        ),
      ),
    );
  }
}

// const BoxShadow(
//     color: kShadowColor,
//     offset: Offset(-12, -12),
//     blurRadius: 0.0,
//     spreadRadius: 0),
// const BoxShadow(
//     color: kShadowColor,
//     offset: Offset(12, -12),
//     blurRadius: 0.0,
//     spreadRadius: 0),
// const BoxShadow(
//     color: kShadowColor,
//     offset: Offset(-12, 12),
//     blurRadius: 0.0,
//     spreadRadius: 0),
// Text Styles
var sALargeTitleStyle = TextStyle(
  fontSize: 28.0,
  fontWeight: FontWeight.bold,
  color: sABackgroundColor,
  fontFamily: Platform.isIOS ? 'SF Pro Text' : null,
  decoration: TextDecoration.none,
);
var sATitle1Style = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
  color: sAPrimaryLabelColor,
  fontFamily: Platform.isIOS ? 'SF Pro Text' : null,
  decoration: TextDecoration.none,
  shadows: shadow,
);
var sACardTitleStyle = TextStyle(
  fontFamily: Platform.isIOS ? 'SF Pro Text' : null,
  fontWeight: FontWeight.bold,
  color: Colors.white,
  fontSize: 22.0,
  decoration: TextDecoration.none,
);
var sATitle2Style = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  color: sAPrimaryLabelColor,
  fontFamily: Platform.isIOS ? 'SF Pro Text' : null,
  decoration: TextDecoration.none,
);
var sAHeadlineLabelStyle = TextStyle(
  fontSize: 17.0,
  fontWeight: FontWeight.w800,
  color: sAPrimaryLabelColor,
  fontFamily: 'SF Pro Text',
  decoration: TextDecoration.none,
);
var sASubtitleStyle = TextStyle(
  fontSize: 16.0,
  color: sASecondaryLabelColor,
  fontFamily: Platform.isIOS ? 'SF Pro Text' : null,
  decoration: TextDecoration.none,
);
var sABodyLabelStyle = TextStyle(
  fontSize: 16.0,
  color: Colors.black,
  fontFamily: Platform.isIOS ? 'SF Pro Text' : null,
  decoration: TextDecoration.none,
);
var sACalloutLabelStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.w800,
  color: sAPrimaryLabelColor,
  fontFamily: Platform.isIOS ? 'SF Pro Text' : null,
  decoration: TextDecoration.none,
);
var sASecondaryCalloutLabelStyle = TextStyle(
  fontSize: 16.0,
  color: sASecondaryLabelColor,
  fontFamily: Platform.isIOS ? 'SF Pro Text' : null,
  decoration: TextDecoration.none,
);
var sASearchPlaceholderStyle = TextStyle(
  fontSize: 13.0,
  color: sASecondaryLabelColor,
  fontFamily: Platform.isIOS ? 'SF Pro Text' : null,
  decoration: TextDecoration.none,
);
var sASearchTextStyle = TextStyle(
  fontSize: 13.0,
  color: sAPrimaryLabelColor,
  fontFamily: Platform.isIOS ? 'SF Pro Text' : null,
  decoration: TextDecoration.none,
);
var sACardSubtitleStyle = TextStyle(
  fontFamily: Platform.isIOS ? 'SF Pro Text' : null,
  color: Color(0xE6FFFFFF),
  fontSize: 13.0,
  decoration: TextDecoration.none,
);
var sACaptionLabelStyle = TextStyle(
  fontSize: 12.0,
  color: sASecondaryLabelColor,
  fontFamily: Platform.isIOS ? 'SF Pro Text' : null,
  decoration: TextDecoration.none,
);

var sALoginInputTextStyle = TextStyle(
  fontSize: 15.0,
  color: Colors.black.withOpacity(0.3),
  fontFamily: Platform.isIOS ? 'SF Pro Text' : null,
  decoration: TextDecoration.none,
);








// Class





class sASlideToAct extends StatelessWidget {
  final text;
  final iconcolor;
  final innercolor;
  final outerColor;
  final Screen;

  sASlideToAct({this.text, this.iconcolor, this.innercolor, this.outerColor,this.Screen});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final GlobalKey<sASlideActionState> _key = GlobalKey();
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: sASlideAction(
            sliderRotate: false,
            height: 60,
            alignment: Alignment.center,
            submittedIcon: SpinKitSpinningLines(
              size: 50,
              color: sABackgroundColor,
              itemCount: 6,
              lineWidth: 5,
              duration: Duration(seconds: 2),
            ),

            // CircularProgressIndicator(
            //   backgroundColor: Colors.deepOrange,
            //   color: Color(0xFFB73705),
            // ),

            // Icon(
            //   Icons.done_all,
            //   color: iconcolor,
            // ),
            reversed: true,
            child: text,
            key: _key,
            onSubmit: () {
              Future.delayed(Duration(seconds: 2), () async {
                // Simple check to see if we have Internet
                // ignore: avoid_print
                print(
                    '''The statement 'this machine is connected to the Internet' is: ''');
                final bool isConnected =
                await InternetConnectionChecker().hasConnection;
                // ignore: avoid_print
                print(
                  isConnected.toString(),
                );
                // returns a bool

                // We can also get an enum instead of a bool
                // ignore: avoid_print
                print(
                    'Current status: ${await InternetConnectionChecker().connectionStatus}');
                // Prints either InternetConnectionStatus.connected
                // or InternetConnectionStatus.disconnected

                // actively listen for status updates

                final StreamSubscription<InternetConnectionStatus> listener =
                InternetConnectionChecker().onStatusChange.listen(
                      (InternetConnectionStatus status) {
                    switch (status) {
                      case InternetConnectionStatus.connected:
                      // ignore: avoid_print
                        print('Data connection is available.');
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Screen,
                                fullscreenDialog: false));
                        break;
                      case InternetConnectionStatus.disconnected:
                      // ignore: avoid_print
                        print('You are disconnected from the internet.');
                        showBottomSheet(
                            backgroundColor: Colors.white.withOpacity(0.85),
                            clipBehavior: Clip.hardEdge,
                            context: context,
                            builder: (BuildContext context) =>
                                BottomSheetContainer(
                                  TextShow: "النت يصحبي",
                                ));
                        _key.currentState.reset();
                        break;
                    }
                  },
                );

                // close listener after 30 seconds, so the program doesn't run forever
                await Future<void>.delayed(const Duration(seconds: 30));
                await listener.cancel();
                // _key.currentState.reset(),
              });
            },
            innerColor: innercolor,
            outerColor: outerColor,
          ),
        );
      },
    );
  }
}



class BottomSheetContainer extends StatelessWidget {
  BottomSheetContainer({this.TextShow});

  final String TextShow;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black45),
        ),
      ),
      child: ListView(
        shrinkWrap: true,
        primary: false,
        children: [
          SizedBox(
            height: 10.0,
          ),
          ListTile(
            dense: true,
            title: Text(
              TextShow,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: sAPrimaryLabelColor,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          ButtonBar(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: FlatButton(
                  child: Text(
                    'طيب',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              )
            ],
            alignment: MainAxisAlignment.start,
          )
        ],
      ),
    );
  }
}


