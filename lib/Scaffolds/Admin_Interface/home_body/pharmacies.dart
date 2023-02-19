import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../Shared/Component/PharmacyCard.dart';
import '../../../main.dart';
import '../view_Pharmacies.dart';

class Pharmacies extends StatefulWidget {
  const Pharmacies({Key? key}) : super(key: key);

  @override
  State<Pharmacies> createState() => _PharmaciesState();
}

class _PharmaciesState extends State<Pharmacies> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Padding(
            padding:
            EdgeInsets.only(top: 10.0, left: 10, right: 10, bottom: 60),
            child: FutureBuilder(
                future:
                FirebaseFirestore.instance.collection("pharmacy").get(),
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Pharmacy(
                                            snapshot.data.docs[index]
                                                .reference.id, snapshot.data.docs[index]["name"] )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: PharmacyCard(
                                    snapshot.data.docs[index]["photo"],
                                    snapshot.data.docs[index]["name"],
                                        () async {
                                      var snapShot = await FirebaseFirestore
                                          .instance
                                          .collection("pharmacy")
                                          .doc(snapshot
                                          .data.docs[index].reference.id)
                                          .collection("items")
                                          .get();
                                      for (var doc in snapShot.docs) {
                                        await doc.reference.delete();
                                      }
                                      await FirebaseFirestore.instance
                                          .collection("pharmacy")
                                          .doc(snapshot
                                          .data.docs[index].reference.id)
                                          .delete();
                                      setState(() {});
                                    }),
                              ),
                            );
                          }),
                    );
                  }
                }),
          ),
        ),
      ],
    );
  }
}
