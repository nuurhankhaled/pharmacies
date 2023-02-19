import 'package:flutter/material.dart';

class CartCard extends StatelessWidget {
  String photo;
  String name;
  String Quantity;
  String total;
  CartCard(this.photo,this.name,this.Quantity,this.total);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double price= double.parse(total)/double.parse(Quantity);
    return Container(
      width: size.width*0.95,
      height: 195,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/container.png"),
            fit: BoxFit.contain),

      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 22.0),
            child: Container(
                width: 200,
                height:170,
                child:
                Image.network(photo)),
          ),
          Padding(
            padding:  EdgeInsets.only(top: 30.0, left: 10),
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Container(
                      width:150,child: Text(name, style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "rob", fontWeight: FontWeight.bold))),),
                Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Container(
                      width: 170,
                      child: Text("Quantity: $Quantity, Price: $price ", style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: "rob", fontWeight: FontWeight.bold))),
                ),
                Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Container(
                      width:120, child: Text("Total: $total", style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: "rob", fontWeight: FontWeight.bold))),
                )
              ],),
          ),
        ],
      ),
    );
  }
}
