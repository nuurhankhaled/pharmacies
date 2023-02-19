import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacies/Scaffolds/User_Inreface/checkout.dart';
import 'package:pharmacies/utils/utils.dart';

import '../../Shared/Component/cart_card.dart';
import '../../Shared/Component/custombutton.dart';
import '../../main.dart';
import '../../resources/cloudfirestore_methods.dart';
import '../../resources/models/cart_model.dart';

class Cart extends StatelessWidget {
  double total = 0;
  Cart(this.total);
  @override
  Widget build(BuildContext context) {
    double num1 = double.parse((total).toStringAsFixed(2));
    num1 = num1+20;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.08),
              child: Container(
                child: ListView(
                  children: [
                    SizedBox(
                      height: 70,
                    ),
                    Container(
                      child: FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection("users")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection("cart")
                              .get(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData == false) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: yellow,
                                ),
                              );
                            } else {
                              return Flexible(
                                  child: Column(
                                      children: List.generate(
                                          snapshot.data.docs.length, (index) {
                                return FutureBuilder(
                                    future: FirebaseFirestore.instance
                                        .collection("restaurant")
                                        .doc(snapshot.data.docs[index]["resID"])
                                        .get(),
                                    builder: (context, AsyncSnapshot snap) {
                                      return Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: CartCard(
                                            snapshot.data.docs[index]["photo"],
                                            snapshot.data.docs[index]["name"],
                                            snapshot
                                                .data.docs[index]["quantity"]
                                                .toString(),
                                            (snapshot.data.docs[index]["cost"] *
                                                    snapshot.data.docs[index]
                                                        ["quantity"])
                                                .toString()),
                                      );
                                    });
                              })));
                            }
                          }),
                    ),
                    SizedBox(
                      height: size.height * 0.3,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.675),
              child: Container(
                width: size.width,
                height: size.height * 0.291,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/lower.png"),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.075,
                          ),
                      child: Text(
                        "Your Order cost: $total EGP",
                        style: TextStyle(
                            fontFamily: "fred",
                            color: Colors.white,
                            fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                      ),
                      child: Text(
                        "Delivery fees: 20EGP",
                        style: TextStyle(
                            fontFamily: "fred",
                            color: Colors.white,
                            fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                      ),
                      child: Text(
                        "total cost: $num1 EGP",
                        style: TextStyle(
                            fontFamily: "fred",
                            color: Colors.white,
                            fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.025,
                          left: MediaQuery.of(context).size.width * 0.3,
                          right: MediaQuery.of(context).size.width * 0.3),
                      child: CustomButton("Order now", Colors.white, yellow,
                          () async {
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

                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Expanded(
                                  child: AlertDialog(
                                    title: Text('Error'),
                                    content: Text('There\'re no items to order.'),
                                    actions: [
                                      MaterialButton(
                                        textColor: Colors.black,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        } else {
                           CloudFirestoreClass().PlaceOrder();
                           double time = await CloudFirestoreClass().getTime();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DisplayTime(time)));

                        } }, 45, 60, 20),
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: size.width,
              height: 145,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/upper.png"),
                    fit: BoxFit.cover),
              ),
            )
          ],
        ),
      ),
    );
  }
}
