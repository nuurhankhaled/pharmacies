import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class PharmacyCard extends StatelessWidget {
  var height, width, size;
  late String image;
  late String name;
  final VoidCallback onTap;

  PharmacyCard(this.image, this.name, this.onTap);

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
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),

                ),
                image: DecorationImage(
                  image: NetworkImage(image, )
                      ,fit: BoxFit.cover
                )
              ),
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
                  width: 100,
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
                Container(
                    margin: const EdgeInsets.only(right: 24),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: yellow,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(5),
                        color: yellow,
                      ),
                      child: InkWell(
                        onTap: onTap,
                        child: Container(
                          width: 35,
                          height: 32,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
