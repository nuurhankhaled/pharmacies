import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmacies/main.dart';

import '../../Shared/Component/custombutton.dart';

class DisplayTime extends StatelessWidget {
  double time;
  DisplayTime(this.time);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    time = (time*25 +25);
    int n = time.toInt() ;
    return Scaffold(
      backgroundColor: Color.fromRGBO(120,120,120, 1),
      body: SafeArea(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
               child: Lottie.network("https://assets3.lottiefiles.com/packages/lf20_6ljouwnr.json")
             ),
          Padding(
            padding: EdgeInsets.only(top: size.height*0.17),
            child: Center(
              child: Text(
                "Your Order will arrive within: ",
                style: TextStyle(
                    fontFamily: "fred",
                    color: Colors.white,
                    fontSize: 20),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height*0.017),
            child: Center(
              child: Text(
                "$n mins ",
                style: TextStyle(
                    fontFamily: "fred",
                    color: Colors.white,
                    fontSize: 20),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery
                    .of(context)
                    .size
                    .height * 0.05,
                left: MediaQuery
                    .of(context)
                    .size
                    .width * 0.3,
                right: MediaQuery
                    .of(context)
                    .size
                    .width * 0.3),
            child: CustomButton(
                "Back to Home",
                Colors.white,
                Colors.red,
                    () async{
                  Navigator.pop(context);
                     },
                45,
                60,
                20),
          )
        ]),
      ),
    );
  }
}
