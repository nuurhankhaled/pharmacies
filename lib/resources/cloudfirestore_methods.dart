import 'dart:collection';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../utils/utils.dart';
import 'models/cart_model.dart';
import 'models/user_detailes.dart';

class CloudFirestoreClass {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future uploadToDatabase({required UserDetailsModel user}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .set(user.getJson());
  }

  Future getCurrentUserData() async {
    DocumentSnapshot snap = await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get();

    UserDetailsModel userModel = UserDetailsModel.getModelFromJson(
      (snap.data() as dynamic),
    );

    return userModel;
  }

  Future<String> uploadPharmacyToDatabase({
    required Uint8List? image,
    required String Name,
    required String long,
    required String lat,
  }) async {
    Name.trim();

    String output = "Something went wrong";

    if (image != null && Name != "" && long != "" && lat != "") {
      try {
        String uid = Utils().getUid();
        String url = await uploadImageToDatabase(image: image, uid: uid);
        double latitude = double.parse(lat);
        double longitude = double.parse(lat);
        double time=0;
        FirebaseFirestore.instance
            .collection("pharmacy")
            .add(<String, dynamic>{
          "name": Name,
          "latitude": latitude,
          "longitude": longitude,
          "photo": url,
          "orders":time
        });

        output = "success";
      } catch (e) {
        output = e.toString();
      }
    } else {
      output = "Please make sure all the fields are not empty";
    }

    return output;
  }
//
  Future<String> uploadItemToPharmacy({
    required String id,
    required Uint8List? image,
    required String Name,
    required String Cost,
    required String Contain,
  }) async {
    Name.trim();

    String output = "Something went wrong";

    if (image != null && Name != "" && id != "" && Cost != "") {
      try {
        String uid = Utils().getUid();
        String url = await uploadImageToDatabase(image: image, uid: uid);
        double cost = double.parse(Cost);
        FirebaseFirestore.instance
            .collection("pharmacy")
            .doc(id)
            .collection("items")
            .add(<String, dynamic>{
          "name": Name,
          "cost": cost,
          "photo": url,
          "description": Contain
        });

        output = "success";
      } catch (e) {
        output = e.toString();
      }
    } else {
      output = "Please make sure all the fields are not empty";
    }

    return output;
  }
  //cart
  Future<String> uploadItemToCart({
    required String id,
    required String image,
    required String Name,
    required String Cost,
    required int quantity,
    required String resId,
  }) async {
    Name.trim();

    String output = "Something went wrong";

    if (image != null && Name != "" && id != "" && Cost != "" ) {
      try {
        double cost= double.parse(Cost);
        FirebaseFirestore.instance
            .collection("users").doc(id).collection("cart").add(<String, dynamic>{
          "name" : Name,
          "cost" : cost,
          "photo": image,
          "quantity" : quantity,
          "resID": resId,
        });

        output = "success";
      } catch (e) {
        output = e.toString();
      }
    } else {
      output = "Please make sure all the fields are not empty";
    }

    return output;
  }
  //image
  Future<String> uploadImageToDatabase(
      {required Uint8List image, required String uid}) async {
    Reference storageRef =
        FirebaseStorage.instance.ref().child("pictures").child(uid);
    UploadTask uploadTask = storageRef.putData(image);
    TaskSnapshot task = await uploadTask;
    return task.ref.getDownloadURL();
  }
  // order
  Future<List<cart>> PlaceOrder() async {
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
    List<String> id=[];
    for (int i = 0; i < carts.length; i++) {
      id.add(carts[i].id);
    }
    List<String> result = LinkedHashSet<String>.from(id).toList();
    for(int j =0; j<result.length; j++){
      var res = await FirebaseFirestore.instance
          .collection("pharmacy")
          .doc(result[j])
          .get();
      print("heeeyyy");
      print(res.data()!["orders"]);
      double order = res.data()!["orders"];
      order++;
      print(order);
      await FirebaseFirestore.instance.collection("pharmacy").doc(result[j]).update(<String, double>{
        "orders" : order,
      });
    } var snapShot = await FirebaseFirestore
        .instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("cart")
        .get();
    for (var doc in snapShot.docs) {
      await doc.reference.delete();
    }
    return carts;
  }
  // get time
  getTime() async{
    double temp=0;
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
    List<String> id=[];
    for (int i = 0; i < carts.length; i++) {
      id.add(carts[i].id);
    }
    List<String> result = LinkedHashSet<String>.from(id).toList();
    for(int j =0; j<result.length; j++){
      var res = await FirebaseFirestore.instance
          .collection("pharmacy")
          .doc(result[j])
          .get();
      print("heeeyyy");
      print(res.data()!["orders"]);
      double order = res.data()!["orders"];
      if(temp <= order ){
        temp = order;
      }
    }
    return temp;
  }
  //get total order
  getTotalPrice() async{
    double temp=0;
    List<cart> carts = [];
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("cart")
        .get()
        .then((value) {
      for (var element in value.docs) {
        temp = temp + (element.data()["cost"]*element.data()["quantity"]);
      }
    });
    double num1 = double.parse((temp).toStringAsFixed(2));
    return num1;
  }
  //doctor
  Future<String> uploadPDoctorToDatabase({
    required Uint8List? image,
    required String Name,
    required String phone,
    required String category,
  }) async {
    Name.trim();

    String output = "Something went wrong";

    if (image != null && Name != "" && phone != "" && category != "") {
      try {
        String uid = Utils().getUid();
        String url = await uploadImageToDatabase(image: image, uid: uid);
        FirebaseFirestore.instance
            .collection("doctor")
            .add(<String, dynamic>{
          "name": Name,
          "phone": phone,
          "category": category,
          "photo": url,
        });
        output = "success";
      } catch (e) {
        output = e.toString();
      }
    } else {
      output = "Please make sure all the fields are not empty";
    }

    return output;
  }
}
