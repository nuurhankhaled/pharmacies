import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Shared/Component/PharmacyCard.dart';
import '../../Shared/Component/user_appbar.dart';
import '../../main.dart';

class DoctorsByCat extends StatelessWidget {
  String title="";
  DoctorsByCat(this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: UserAppBar(title) ,
      body: Column(
        children: [
          Flexible(
            child: Padding(
              padding:
              EdgeInsets.only(top: 10.0, left: 10, right: 10, bottom: 60),
              child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("doctor").where("category", isEqualTo: title).get(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData == false) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: yellow,
                        ),
                      );
                    } else {
                      return Flexible(
                        child: ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Container(
                                  height: 190,
                                  width: 400,
                                  decoration: BoxDecoration(
                                      color: lightBlack,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(

                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15, right: 8, top: 12),
                                              child: Container(
                                                width: 135,
                                                height: 150,
                                                child: Image.network(
                                                  snapshot.data
                                                      .docs[index]["photo"],
                                                  fit: BoxFit.contain,

                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(top: 18.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    EdgeInsets.only(top: 20.0),
                                                    child: Container(
                                                      width: 200,
                                                      padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 10),
                                                      child: Text(
                                                        snapshot.data.docs[index]
                                                        ["name"],
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.white),
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                  ),

                                                  Padding(
                                                    padding: EdgeInsets.only(top: 4.0),
                                                    child: Container(
                                                      width: 200,
                                                      padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 10),
                                                      child: Text(
                                                        snapshot
                                                            .data.docs[index]["phone"]
                                                            ,
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.white),
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        top: 5.0, left: 150),
                                                    child: Container(
                                                      margin: const EdgeInsets.only(
                                                          right: 24),
                                                      child: Align(
                                                        alignment:
                                                        Alignment.bottomRight,
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            border: Border.all(
                                                              color: yellow,
                                                              width: 1.5,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                5),
                                                            color: yellow,
                                                          ),
                                                          child: Container(
                                                            width: 35,
                                                            height: 32,
                                                            alignment:
                                                            Alignment.center,
                                                            child:  IconButton(
                                                              onPressed: (){
                                                                launch("tel:"+snapshot.data.docs[index]["phone"]);
                                                              },  icon: Icon(Icons.phone, color: Colors.white,size: 20,) ,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
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
      ),
    );
  }
}
