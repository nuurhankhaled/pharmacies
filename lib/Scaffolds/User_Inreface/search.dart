import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchtf = TextEditingController();
  String name = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        width: size.width,
        height: size.height * 0.963,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/search.png"),
                fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.03,
                  left: MediaQuery.of(context).size.height * 0.019),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: black,
                    borderRadius: BorderRadius.circular(20)),
                child: IconButton(
                    onPressed: ()  async {
                    },
                    icon: Padding(
                      padding:  EdgeInsets.only(right: 2.0),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 22.5,
                        color: Colors.white,
                      ),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.03,
                  left: size.width * 0.07,
                  right: size.width * 0.08),
              child: TextFormField(
                controller: searchtf,
                onChanged: (value) {
                  name = value;
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                  prefixIcon: InkWell(
                    child: const Padding(
                      padding: EdgeInsets.only(
                        left: 6,
                      ),
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 23,
                      ),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.only(top: 10),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(7),
                    ),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(7),
                    ),
                    borderSide: BorderSide(
                      color: Colors.white54,
                      width: 1,
                    ),
                  ),
                  hintText: 'Search ',
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 40),
            child: SingleChildScrollView(
              child: Container(
                height: 600,
                child: Flexible(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('pharmacy').snapshots(),
                    builder: (context, AsyncSnapshot snapshots) {
                      return (snapshots.connectionState == ConnectionState.waiting)
                          ? Center(
                        child: CircularProgressIndicator(),
                      )
                          : ListView.builder(
                          itemCount: snapshots.data!.docs.length,
                          itemBuilder: (context, index) {
                            var data = snapshots.data!.docs[index].data()
                            as Map<String, dynamic>;
                            if (name.isEmpty) {
                              print("aaaaaaaaaahhhhhhhhhhhhhhhh");
                              return Container(
                                height: 100,
                                width: 400,
                                child: Expanded(
                                  child: ListTile(
                                    title: Text(
                                      data['name'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    // subtitle: Text(
                                    //   data['email'],
                                    //   maxLines: 1,
                                    //   overflow: TextOverflow.ellipsis,
                                    //   style: TextStyle(
                                    //       color: Colors.black54,
                                    //       fontSize: 16,
                                    //       fontWeight: FontWeight.bold),
                                    // ),
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(data['photo']),
                                    ),
                                  ),
                                ),
                              );
                            }
                            if (data['name']
                                .toString()
                                .toLowerCase().startsWith(name.toLowerCase())) {
                              return Container(
                                height: 100,
                                width: 400,
                                child: Expanded(
                                  child: ListTile(
                                    title: Text(
                                      data['name'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    // subtitle: Text(
                                    //   data['email'],
                                    //   maxLines: 1,
                                    //   overflow: TextOverflow.ellipsis,
                                    //   style: TextStyle(
                                    //       color: Colors.black54,
                                    //       fontSize: 16,
                                    //       fontWeight: FontWeight.bold),
                                    // ),
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(data['photo']),
                                    ),
                                  ),
                                ),
                              );
                            }
                            return Container();
                          });
                    },
                  )
                ),
              ),
            ),)
          ],
        ),
      ),
    );
  }
}
