import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../Shared/Component/PharmacyCard.dart';
import '../../Shared/Component/appbar.dart';
import '../../Shared/Component/pharmacy_container_forUSer.dart';
import '../../Shared/Component/user_appbar.dart';
import '../../main.dart';
import '../../resources/authentication_methods.dart';
import '../shared/login.dart';
import 'items_by_pharmacy.dart';

class Viewall extends StatefulWidget {
  const Viewall({Key? key}) : super(key: key);

  @override
  State<Viewall> createState() => _ViewallState();
}

class _ViewallState extends State<Viewall> {
  @override
  void initState() {
    super.initState();
  }

  AuthenticationMethods authenticationMethods = AuthenticationMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: black,
        appBar: UserAppBar(
          "All Pharmacies",
        ),
        body: Column(
          children: [
            Flexible(
              child: Padding(
                padding:
                EdgeInsets.only(top: 10.0, left: 10, right: 10, bottom: 10),
                child: FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("pharmacy")
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
                          child: GridView.builder(
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemsToOreder( snapshot.data.docs[index]["name"], snapshot.data.docs[index].reference.id,
                                        "")));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: PharmacyContainerUser(
                                        snapshot.data.docs[index]["photo"],
                                        snapshot.data.docs[index]["name"],
                                          ),
                                  ),
                                );
                              }),
                        );
                      }
                    }),
              ),
            ),
          ],
        ),);
  }
}
