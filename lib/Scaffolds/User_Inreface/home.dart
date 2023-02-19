import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pharmacies/Scaffolds/User_Inreface/doctors_by_category.dart';
import 'package:pharmacies/Scaffolds/User_Inreface/viewall.dart';

import '../../Shared/Component/card.dart';
import '../../Shared/Functions/time.dart';
import '../../main.dart';
import '../../resources/authentication_methods.dart';
import '../../resources/cloudfirestore_methods.dart';
import '../../resources/models/cart_model.dart';
import '../shared/login.dart';
import 'cart.dart';
import 'items_by_pharmacy.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  AuthenticationMethods authenticationMethods = AuthenticationMethods();
  var items = ["Dentist", "Pediatrician", "Surgeon", "Neurologist"];
  var pics = [
    "assets/images/pngwing.com (1).png",
    "assets/images/pngwing.com (2).png",
    "assets/images/pngwing.com (3).png",
    "assets/images/pngwing.com (4).png"
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        width: size.width,
        height: size.height * 0.963,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/Home.png"),
                fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.04,
                    ),
                    child: LabeledTime(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.height * 0.05, left: size.width * 0.25),
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.shopping_cart_rounded,
                          size: 22,
                        ),
                        onPressed: () async {
                          List<cart> carts = [];
                          await FirebaseFirestore.instance
                              .collection("users")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection("cart")
                              .get()
                              .then((value) {
                            for (var element in value.docs) {
                              carts.add(cart.fromJson(element.data()));
                            }
                          });
                          if (carts.isEmpty) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Cart(0)));
                          }
                          else{
                            double total = await CloudFirestoreClass().getTotalPrice();
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Cart(total)));
                          }

                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.height * 0.05, right: size.width * 0.07),
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: IconButton(
                          icon: Icon(
                            Icons.logout_rounded,
                            size: 22,
                          ),
                          onPressed: () async {
                            String output =
                                await authenticationMethods.logOutUser();
                            if (output == 'success') {
                              Navigator.of(context, rootNavigator: true)
                                  .pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return LogIn();
                                  },
                                ),
                                (_) => false,
                              );
                            }
                            ;
                          }),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.12),
              child: Container(
                height: 130,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return (index == items.length - 1)
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left: size.width * 0.08,
                                  right: size.width * 0.08),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DoctorsByCat(items[index])));
                                },
                                child: Container(
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: size.height * 0.025),
                                          child: Image.asset(
                                            pics[index],
                                            width: 55,
                                            color: black,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: size.height * 0.01),
                                          child: Text(
                                            items[index],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.only(left: size.width * 0.08),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DoctorsByCat(items[index])));
                                },
                                child: Container(
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: size.height * 0.028),
                                          child: Image.asset(
                                            pics[index],
                                            width: 65,
                                            color: black,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: size.height * 0.011),
                                          child: Text(
                                            items[index],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35.0, left: 7, right: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20,
                              left: MediaQuery.of(context).size.width * 0.04),
                          child: const Text(
                            "  Top Pharmacies",
                            style: TextStyle(
                                fontFamily: "fred",
                                color: Colors.white,
                                fontSize: 15),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Viewall()));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 25,
                                right:
                                    MediaQuery.of(context).size.width * 0.05),
                            child: Text(
                              "view all",
                              style: TextStyle(
                                  fontFamily: "fred",
                                  color: Colors.white,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.03),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 405,
                        child: FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection("pharmacy")
                              .get(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData == false) {
                              return Center(child: Text("data"));
                            } else {
                              return ListView.builder(
                                itemCount: 2,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ItemsToOreder(
                                                      snapshot.data.docs[index]
                                                          ["name"],
                                                      snapshot.data.docs[index]
                                                          .reference.id,
                                                      "")));
                                    },
                                    child: Cards(
                                      snapshot.data.docs[index]["name"],
                                      snapshot.data.docs[index]["photo"],
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
