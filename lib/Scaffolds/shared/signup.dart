import 'package:flutter/material.dart';


import '../../Shared/Component/bnv.dart';
import '../../Shared/Component/custombutton.dart';
import '../../Shared/Component/textfield.dart';
import '../../main.dart';
import '../../resources/authentication_methods.dart';
import '../../utils/utils.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameFieldController = TextEditingController();
  TextEditingController emailFieldController = TextEditingController();
  TextEditingController passwordFieldController = TextEditingController();
  TextEditingController phoneFieldController = TextEditingController();
  AuthenticationMethods authenticationMethods = AuthenticationMethods();

  bool passwordVisible = false;
  bool Issecure = true;
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
            height: size.height * 0.963,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/signup.png"),
                    fit: BoxFit.cover)),
            child: Form(
              key: formKey,
              child: Stack(
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.108),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: Column(
                            children: [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.03,
                                  ),
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 37,
                                        fontFamily: "title"),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  "Create yor own account now",
                                  style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 13,
                                      fontFamily: "alef",
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.035,
                                    left: MediaQuery.of(context).size.width *
                                        0.07,
                                    right: MediaQuery.of(context).size.width *
                                        0.07),
                                child: FormFields("Name", Icon(Icons.person),
                                    null, false, nameFieldController),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.width *
                                        0.03,
                                    left: MediaQuery.of(context).size.width *
                                        0.07,
                                    right: MediaQuery.of(context).size.width *
                                        0.07),
                                child: FormFields(
                                    "Email",
                                    const Icon(Icons.email),
                                    null,
                                    false,
                                    emailFieldController),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.width *
                                        0.03,
                                    left: MediaQuery.of(context).size.width *
                                        0.07,
                                    right: MediaQuery.of(context).size.width *
                                        0.07),
                                child: FormFields(
                                    "Phone",
                                    Icon(Icons.phone_android_rounded),
                                    null,
                                    false,
                                    phoneFieldController),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.width *
                                        0.03,
                                    left: MediaQuery.of(context).size.width *
                                        0.07,
                                    right: MediaQuery.of(context).size.width *
                                        0.07),
                                child: FormFields(
                                    "Password",
                                    Icon(Icons.lock),
                                    IconButton(
                                      icon: Icon(
                                        passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          Issecure = !Issecure;
                                          passwordVisible = !passwordVisible;
                                        });
                                      },
                                    ),
                                    Issecure,
                                    passwordFieldController),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.width *
                                        0.085,
                                    left: MediaQuery.of(context).size.width *
                                        0.15,
                                    right: MediaQuery.of(context).size.width *
                                        0.15,
                                    bottom: MediaQuery.of(context).size.width *
                                        0.001),
                                child: CustomButton(
                                    "SIGN UP", yellow, Colors.white, () async {
                                  if (formKey.currentState != null &&
                                      formKey.currentState!.validate()) {
                                      String output =
                                      await authenticationMethods.signUpUser(
                                          name: nameFieldController.text,
                                          phone: phoneFieldController.text,
                                          email: emailFieldController.text,
                                          password: passwordFieldController.text,
                                          );
                                      if (output == "success") {
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                                builder: (_) => CustomedBNB()));
                                      }
                                      else {
                                        Utils().showSnackBar(
                                            context: context, content: output);
                                      }
                                    } else{

                                      Utils().showSnackBar(
                                          context: context, content: "Please Enter your data.");
                                    }



                                }, 52, 0.75, 22.5),
                              ),
                              Center(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: size.height * 0.01),
                                  child: GestureDetector(
                                    child: Text(
                                      'Already have an account? SignIn',
                                      style: TextStyle(
                                          fontFamily: 'title',
                                          fontSize: 15,
                                          color: Colors.white54,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.white54),
                                    ),
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => LogIn()));
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
