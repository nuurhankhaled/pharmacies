import 'package:flutter/material.dart';

import '../../main.dart';

class CustomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  bool autoLeading;
  dynamic action;
  CustomeAppBar(this.title,this.autoLeading,this.action );
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: autoLeading ,
      backgroundColor: yellow,
      toolbarHeight: 75,
      title: Padding(
        padding:  EdgeInsets.only(left: 8.0),
        child: Text(title, style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22.5
        ),),
      ),
      actions: [
        Padding(padding: EdgeInsets.only(right: 8),
        child: action,)
      ],
    );
  }
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(75);
}
