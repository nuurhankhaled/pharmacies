import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Shared/Component/pharmacy_container_forUSer.dart';
import '../../Shared/Component/user_appbar.dart';
import '../../main.dart';
import 'Item.dart';

class ItemsToOreder extends StatelessWidget {
  String title;
  String id;
  String cat;
  ItemsToOreder(this.title,this.id, this.cat);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: black,
      appBar: UserAppBar(title),
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection("pharmacy")
                  .doc(id)
                  .collection("items")
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Item(snapshot.data.docs[index]["name"], snapshot.data.docs[index]["photo"],
                            snapshot.data.docs[index]["description"], snapshot.data.docs[index]["cost"].toString(), cat.toString(),title, id)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: PharmacyContainerUser(
                                snapshot.data.docs[index]["photo"],
                                snapshot.data.docs[index]["name"]),
                          ),
                        );
                      }));
                }
              })),
    );
  }
}
