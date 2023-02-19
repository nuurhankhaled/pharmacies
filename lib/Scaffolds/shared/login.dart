import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmacies/Scaffolds/shared/signup.dart';


import '../../Shared/Component/bnv.dart';
import '../../Shared/Component/custombutton.dart';
import '../../Shared/Component/textfield.dart';
import '../../main.dart';
import '../../resources/authentication_methods.dart';
import '../../utils/utils.dart';
import '../Admin_Interface/home.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool passwordVisible = false;
  TextEditingController? emailFieldController = TextEditingController();
  TextEditingController? passwordFieldController = TextEditingController();
  AuthenticationMethods authenticationMethods = AuthenticationMethods();

  bool isSecure = true;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: size.width,
            height: size.height*0.963,
            decoration: BoxDecoration(
                image: DecorationImage(image:AssetImage("assets/images/login.png") , fit: BoxFit.cover)
            ),
            child: Form(
              key: formKey,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.21),
                    child:
                      ListView(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.08,
                                left: MediaQuery.of(context).size.width * 0.21),
                            child: const Text(
                              "Welcome back",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 37,
                                  fontFamily: "title"),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.34),
                            child: Text(
                              "Login to your account",
                              style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 13,
                                  fontFamily: "alef",
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.065,
                                left: MediaQuery.of(context).size.width * 0.07,
                                right: MediaQuery.of(context).size.width * 0.07),
                            child: FormFields("Email", const Icon(Icons.mail), null,
                                false, emailFieldController!),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.width * 0.05,
                                left: MediaQuery.of(context).size.width * 0.07,
                                right: MediaQuery.of(context).size.width * 0.07),
                            child: FormFields(
                                "Password",
                                const Icon(Icons.lock),
                                IconButton(
                                  icon: Icon(
                                    passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isSecure = !isSecure;
                                      passwordVisible = !passwordVisible;
                                    });
                                  },
                                ),
                                isSecure,
                                passwordFieldController!),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: size.height * 0.065,
                                left: size.width * 0.15,
                                right: size.width * 0.15),
                            child: CustomButton(
                                "LOG IN",
                                yellow,
                                Colors.white, () async {
                              // if(emailFieldController!.text == "admin" &&
                              //     passwordFieldController!.text == "admin") {
                              //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> AdminHome()));
                              // }
                              // else
                                if (formKey.currentState != null &&
                                  formKey.currentState!.validate()) {
                                  String output =
                                  await authenticationMethods.logInUser(
                                      email: emailFieldController!.text,
                                      password: passwordFieldController!.text);

                                  if (output == "success")  {
                                    //functions
                                    await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots().forEach((element) {
                                      if(element.data()?['type'] == "User"){
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CustomedBNB()));
                                      }
                                      else if(element.data()?['type'] == "Admin"){
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminHome()));
                                      }
                                    });
                                  } else {

                                    Utils().showSnackBar(
                                        context: context, content: output);
                                  }
                                } else {
                                  Utils().showSnackBar(
                                      context: context, content: "Please Enter your data." );

                              }
                            }, 52, 0.75, 22.5),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: size.height*0.01),
                              child: GestureDetector(child: Text('Don\'t have an account? SignUp', style: TextStyle(fontFamily: 'title', fontSize:15, color: Colors.white54, decoration: TextDecoration.underline, decorationColor: Colors.white54),),onTap: ()  {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignUp()));
                              },),
                            ),
                          ),
                        ],
                      ),
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
