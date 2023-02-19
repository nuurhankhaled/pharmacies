import 'package:flutter/material.dart';

import '../../main.dart';

class FormFields extends StatelessWidget {
  TextEditingController textFieldController = TextEditingController();
  dynamic prefix;
  dynamic suffix;
  String x = "";
  bool IsObsecure;
  dynamic function;
  FormFields(this.x,this.prefix,this.suffix,this.IsObsecure,this.textFieldController);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (String? text){
    if(textFieldController.text == ''){
    return 'This Field is Required.';
    }
    },
      obscureText: IsObsecure,
      cursorColor: Colors.grey,
        controller: textFieldController,
        decoration: InputDecoration(
          prefixIcon: prefix,
          suffixIcon: suffix,
          filled: true,
          fillColor: Colors.white,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          // floatingLabelStyle: const TextStyle(color:   Color.fromRGBO(247, 180, 63 , 1), fontWeight: FontWeight.w700, fontSize: 15),
          labelStyle: TextStyle(color: Colors.black),
          focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
          width: 2,
            color:  yellow,
        ),
      ),
        labelText: x,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    ));
  }
}
