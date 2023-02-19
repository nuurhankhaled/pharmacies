
import 'package:firebase_auth/firebase_auth.dart';
import 'cloudfirestore_methods.dart';
import 'models/user_detailes.dart';

class AuthenticationMethods {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CloudFirestoreClass cloudFirestoreClass = CloudFirestoreClass();
  Future<String> signUpUser(
      {required String name,
        required String phone,
        required String email,
        required String password}) async {
    name.trim();
    phone.trim();
    email.trim();
    password.trim();
    String output = "Something went wrong";
    if (name != "" && phone != "" && email != "" && password != "") {
      try {
        await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        UserDetailsModel user = UserDetailsModel(name: name, phone: phone,type: "User", password: password);
        await cloudFirestoreClass.uploadToDatabase(user: user);
        output = "success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "Please fill up all the fields.";
    }
    return output;
  }

  Future<String> logInUser(
      {required String email, required String password}) async {
    email.trim();
    password.trim();
    String output = "Something went wrong";
    if (email != "" && password != "") {
      try {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        output = "success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "Please fill up all the fields.";
    }
    return output;
  }
  Future<String> logOutUser() async {

    String output = "Something went wrong";

      try {
        await firebaseAuth.signOut();
        output = "success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
      return output;
    }

  }
