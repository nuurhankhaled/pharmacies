import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../main.dart';
import 'first.dart';
import 'login.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 2500,
      backgroundColor: yellow,
      splash: Column(
        //: MainAxisAlignment.start,
        children: [

          Center(
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.37),
              child: Text("Medicine Delivery", style: TextStyle(
                  fontFamily: "title",color: Colors.white, fontSize: 45

              ),),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.35),
            child: SpinKitThreeBounce(
              color: Colors.white,
              size: 55,
            ),
          ),
        ],
      ),
      //nextScreen: FirstScreen(),
      splashIconSize: MediaQuery.of(context).size.height*0.9,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.rightToLeft, nextScreen: FirstScreen(),
    );
  }
}
//37, 45, 47
//#252D30