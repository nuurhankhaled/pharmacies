import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import '../../Shared/Component/appbar.dart';
import '../../Shared/Component/custombutton.dart';
import '../../Shared/Component/textfield.dart';
import '../../main.dart';
import '../../resources/cloudfirestore_methods.dart';
import '../../utils/utils.dart';

class AddItem extends StatefulWidget {
  @override
  State<AddItem> createState() => _AddItemState();
  String id;
  AddItem(this.id);
}
class _AddItemState extends State<AddItem> {
  TextEditingController contain = TextEditingController();
  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController cost = TextEditingController();
  Uint8List? image;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: black,
      appBar: CustomeAppBar("Add Item", true, null),
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
                      padding:  EdgeInsets.only( top:MediaQuery.of(context).size.height * 0.08 ,
                      ),
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: MediaQuery.of(context).size.height * 0.21,
                            decoration:  BoxDecoration(
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
                            child : image== null? ClipRRect(
                                borderRadius: BorderRadius.circular(150),
                                child: Image.asset("assets/images/nop.jpg",fit: BoxFit.fitHeight,)): ClipRRect(
                                borderRadius: BorderRadius.circular(150),
                                child: Image.memory(image!, fit: BoxFit.contain)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.151,
                                left:MediaQuery.of(context).size.width * 0.3 ),
                            child: Container(
                              width: 58,
                              height: 58,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                      color: black,
                                      width: 5
                                  )
                              ),
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
                                  icon: Icon(Icons.camera_alt,color: Colors.grey.shade600,size: 31,),
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
                    child: FormFields("Name",
                        Icon(Icons.type_specimen_rounded), null, false, name),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.03,
                        left: MediaQuery.of(context).size.width * 0.07,
                        right: MediaQuery.of(context).size.width * 0.07),
                    child: FormFields(
                        "Description",
                        Icon(Icons.description),
                        null,
                        false,
                        contain),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.03,
                        left: MediaQuery.of(context).size.width * 0.07,
                        right: MediaQuery.of(context).size.width * 0.07),
                    child: FormFields(
                        "Cost",
                        Icon(Icons.monetization_on_rounded),
                        null,
                        false,
                        cost),
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
                            String output = await CloudFirestoreClass().uploadItemToPharmacy(id: widget.id, image: image, Name: name.text,
                                Cost: cost.text, Contain: contain.text);
                            if(output=="success"){
                              Utils().showSnackBar(
                                  context: context,
                                  content: "Data Saved Successfully");
                              name.clear();
                              contain.clear();
                              cost.clear();
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
                  )

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
