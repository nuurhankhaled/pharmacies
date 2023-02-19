import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class PharmacyContainerUser extends StatelessWidget {
  var height, width, size;
  late String image;
  late String name;

  PharmacyContainerUser(this.image, this.name);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          color: lightBlack,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          )),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Container(
              height: 140,
              width: 155,
              child: Image.network(image, fit: BoxFit.contain),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 8.0,
              left: 25,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 130,
                  child: Text(
                    name,
                    softWrap: false,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 15,
                        color: CupertinoColors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "alef"),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
