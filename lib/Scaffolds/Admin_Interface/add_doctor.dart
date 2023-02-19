import 'dart:io';
import 'dart:typed_data';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import '../../Shared/Component/appbar.dart';
import '../../Shared/Component/custombutton.dart';
import '../../Shared/Component/textfield.dart';
import '../../main.dart';
import '../../resources/cloudfirestore_methods.dart';
import '../../utils/utils.dart';


class AddDoctor extends StatefulWidget {
  const AddDoctor({Key? key}) : super(key: key);

  @override
  State<AddDoctor> createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {
  TextEditingController phone = TextEditingController();
  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  Uint8List? image;
  String dropdownValue = 'Dentist';
  var items = ["Dentist", "Pediatrician", "Surgeon", "Neurologist"];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: black,
      appBar: CustomeAppBar("Add Doctor", true, null),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.08,
                      ),
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: MediaQuery.of(context).size.height * 0.21,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10,
                                  spreadRadius: 5,
                                )
                              ],
                              borderRadius: BorderRadius.circular(200),
                              color: Colors.transparent,
                            ),
                            child: image == null
                                ? ClipRRect(
                                borderRadius: BorderRadius.circular(150),
                                child: Image.asset(
                                  "assets/images/nop.jpg",
                                  fit: BoxFit.fitHeight,
                                ))
                                : ClipRRect(
                                borderRadius: BorderRadius.circular(150),
                                child: Image.memory(image!,
                                    fit: BoxFit.cover)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.151,
                                left: MediaQuery.of(context).size.width * 0.3),
                            child: Container(
                              width: 58,
                              height: 58,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: black, width: 5)),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  onPressed: () async {
                                    Uint8List? temp = await Utils().pickImage();
                                    if (temp != null) {
                                      setState(() {
                                        image = temp;
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: Colors.grey.shade600,
                                    size: 31,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.05,
                        left: MediaQuery.of(context).size.width * 0.07,
                        right: MediaQuery.of(context).size.width * 0.07),
                    child: FormFields("Name", Icon(Icons.type_specimen_rounded),
                        null, false, name),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.03,
                        left: MediaQuery.of(context).size.width * 0.07,
                        right: MediaQuery.of(context).size.width * 0.07),
                    child: FormFields("Number",
                        Icon(Icons.phone_android_rounded), null, false, phone),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.2),
                          child: const Text(
                            "Category:",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontFamily: "alef",
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.17),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              items: items
                                  .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ))
                                  .toList(),
                              value: dropdownValue,
                              onChanged: (value) {
                                setState(() {
                                  dropdownValue = value as String;
                                });
                              },
                              icon: const Icon(
                                Icons.arrow_drop_down_circle,
                                size: 20,
                              ),
                              iconSize: 16,
                              iconEnabledColor: Colors.black,
                              buttonHeight: 50,
                              buttonWidth: 160,
                              buttonPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                ),
                                color: Colors.grey.shade300,
                              ),
                              buttonElevation: 2,
                              itemHeight: 40,
                              itemPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                              dropdownMaxHeight: 200,
                              dropdownWidth: 200,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.grey.shade300,
                              ),
                              dropdownElevation: 8,
                              scrollbarRadius: const Radius.circular(40),
                              scrollbarThickness: 6,
                              scrollbarAlwaysShow: true,
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
                  "Submit",yellow, Colors.white,
                      () async {
                    if (formKey.currentState != null &&
                        formKey.currentState!.validate())  {
                      String output = await CloudFirestoreClass().uploadPDoctorToDatabase(image: image, Name: name.text, phone:phone.text, category: dropdownValue);
                      if(output=="success"){
                        Utils().showSnackBar(
                            context: context,
                            content: "Data Saved Successfully");
                        name.clear();
                        phone.clear();
                        setState(() {
                          image=null;
                        });

                      } else {

                        Utils().showSnackBar(
                            context: context, content: output);
                      }
                    } else
                      Utils().showSnackBar(
                          context: context,
                          content: "Plase enter Data, its cannot be empty.");
                  }, 45, 60, 20),
            ),
          ],
        ),
      ),
    );
  }
}
