import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


import '../../Shared/Component/appbar.dart';
import '../../main.dart';
import 'add_Items.dart';

class Pharmacy extends StatefulWidget {
  String id;
  String title;
  Pharmacy(this.id,this.title);

  @override
  State<Pharmacy> createState() => _PharmacyState();
}

class _PharmacyState extends State<Pharmacy> {
  @override
  void initState() {
    super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomeAppBar(widget.title, true, null),
        backgroundColor: black,
        body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("pharmacy")
                    .doc(widget.id)
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
                    return ListView.builder(
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
                                                padding:  EdgeInsets.only(top: 4.0),
                                                child: Container(
                                                  width: 200,
                                                  padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: Text(
                                                    snapshot.data.docs[index]
                                                    ["description"],
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
                                                        .data.docs[index]["cost"]
                                                        .toString(),
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
                                                      child: InkWell(
                                                        onTap: () async {
                                                       await FirebaseFirestore.instance
                                                            .collection("pharmacy")
                                                            .doc(widget.id)
                                                            .collection("items").doc(snapshot.data.docs[index].reference.id).delete();
                                                        setState(() {

                                                        });
                                                      },
                                                        child: Container(
                                                          width: 35,
                                                          height: 32,
                                                          alignment:
                                                          Alignment.center,
                                                          child: const Icon(
                                                            Icons.delete,
                                                            color: Colors.white,
                                                            size: 18,
                                                          ),
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
                        });
                  }
                })),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddItem(widget.id)));
          },
          backgroundColor: yellow,
          child: Icon(
            Icons.add,
            size: 40,
          ),
        ));
  }
}
