import 'package:flutter/material.dart';
import 'package:pharmacies/Scaffolds/shared/signup.dart';

import '../../Shared/Component/custombutton.dart';
import '../../main.dart';
import 'login.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
    body: SafeArea(
    child: SingleChildScrollView(
    child: Container(
    width: size.width,
    height: size.height*0.963,
    decoration: BoxDecoration(
    image: DecorationImage(image:AssetImage("assets/images/first.png") , fit: BoxFit.cover)
    ),
      child: Padding(
        padding: EdgeInsets.only(top: size.height*0.59),
        child: Column(
          children: [
            CustomButton(
                "SIGN UP",
                yellow,
                Colors.white, ()  {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUp()));

            }, 52, 0.75, 20),
            Padding(
              padding:  EdgeInsets.only(top: size.height*0.02),
              child: CustomButton(
                  "Log In",
                  yellow,
                  Colors.white, ()  {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> LogIn()));

              }, 52, 0.75, 20),
            ),

          ],
        ),
      ),
    ),
    ),
    ),
    );
  }
}
