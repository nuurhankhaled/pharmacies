import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../Shared/Component/PharmacyCard.dart';
import '../../../main.dart';
import '../view_Pharmacies.dart';

class Doctors extends StatefulWidget {
  const Doctors({Key? key}) : super(key: key);

  @override
  State<Doctors> createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> {
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
                FirebaseFirestore.instance.collection("doctor").get(),
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
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: PharmacyCard(
                                  snapshot.data.docs[index]["photo"],
                                  snapshot.data.docs[index]["name"],
                                      () async {
                                    await FirebaseFirestore.instance
                                        .collection("doctor")
                                        .doc(snapshot
                                        .data.docs[index].reference.id)
                                        .delete();
                                    setState(() {});
                                  }),
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
