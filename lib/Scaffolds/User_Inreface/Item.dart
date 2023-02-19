import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Shared/Component/custombutton.dart';
import '../../main.dart';
import '../../resources/cloudfirestore_methods.dart';
import '../../state management/statemanagement.dart';
import '../../utils/utils.dart';

class Item extends StatelessWidget {
  String name;
  String ingredients;
  String photo;
  String Cost;
  String cat;
  String res;
  String resid;
  Item(this.name, this.photo, this.ingredients, this.Cost, this.cat,this.res, this.resid);

  MyBloc test = MyBloc();

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: black,
      body: Padding(
        padding: EdgeInsets.only(top: size.height * 0.035),
        child: BlocProvider(
          create: (context) {
            return test;
          },
          child: Builder(
            builder: (context2) {
              dynamic bloc = BlocProvider.of<MyBloc>(context2);
              return Container(
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
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Padding(
                                  padding: EdgeInsets.only(right: 2.0),
                                  child: Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    size: 22.5,
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: size.height * 0.06),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: MediaQuery.of(context).size.height * 0.21,
                              decoration: BoxDecoration(
                                boxShadow: [

                                ],
                                borderRadius: BorderRadius.circular(200),
                                color: Colors.transparent,
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child:
                                      Image.network(photo, fit: BoxFit.contain)),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: size.height * 0.03),
                            child: Container(
                              width: 270,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: lightBlack,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: Text(
                                  name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "rob"),
                                ),
                              ),
                            ),
                          ),
                        ),
                        (cat != "Grocery")
                            ? Center(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: size.height * 0.04),
                                  child: Container(
                                    width: 350,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: lightBlack,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Center(
                                      child: Text(
                                        ingredients,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "rob",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Center(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: size.height * 0.04),
                                  child: Container(
                                    width: 150,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: lightBlack,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Center(
                                      child: Text(
                                        ingredients,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "rob",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: size.height * 0.04),
                            child: Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: lightBlack,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: Text(
                                  "Cost : $Cost",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "rob",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: size.width * 0.35, top: size.height * 0.02),
                          margin: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black12,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                  color: yellow,
                                ),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (bloc.state.count > 1) {
                                          bloc.add(MyBlocEvent("-"));
                                        }
                                      },
                                      child: Container(
                                        width: 35,
                                        height: 32,
                                        alignment: Alignment.center,
                                        child: const Icon(
                                          Icons.remove,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black12, width: 1.5),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                      child: Container(
                                        width: 35,
                                        height: 32,
                                        alignment: Alignment.center,
                                        child: BlocBuilder<MyBloc, MyBlocState>(
                                          builder: (context3, state) {
                                            return Text(
                                                bloc.state.count.toString());
                                          },
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        bloc.add(MyBlocEvent("+"));
                                      },
                                      child: Container(
                                        width: 35,
                                        height: 32,
                                        alignment: Alignment.center,
                                        child: const Icon(
                                          Icons.add,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.04,
                              left: MediaQuery.of(context).size.width * 0.3,
                              right: MediaQuery.of(context).size.width * 0.3),
                          child: CustomButton(
                              "Add to Cart", yellow, Colors.white, () async {
                            String output = await CloudFirestoreClass()
                                .uploadItemToCart(
                                    id: FirebaseAuth.instance.currentUser!.uid,
                                    image: photo,
                                    Name: name,
                                    Cost: Cost,
                                    quantity: bloc.state.count,
                                    resId: resid);
                            if(output=="success"){
                              Utils().showSnackBar(
                                  context: context, content: "Item added to cart successfully");
                            } else{
                              Utils().showSnackBar(
                                  context: context, content: output);
                            }
                          }, 48, 63, 20),
                        )
                      ]));
            },
          ),
        ),
      ),
    );
  }
}
