import 'package:flutter/material.dart';
import 'dart:io';

import '../../main.dart';



class Cards extends StatelessWidget {
  String name = '';
  String pic ;


  Cards(this.name, this.pic);

  var size, width, height;



  late double left;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    String img = pic;
    return Padding(
      padding: EdgeInsets.only(
          left: width * 0.06, right: width * 0.06, top: height * 0.01),
      child: Expanded(
        child: Container(
          width: width * 0.99,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            color: lightBlack,
            border: Border.all(color: Colors.black12, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: height * 0.015,

                    bottom: height * 0.02),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: width * 0.25,
                    height: 115,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.pink.shade50,
                        borderRadius: BorderRadius.circular(15)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network( img,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: width * 0.025),
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "fred",
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
