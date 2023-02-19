import 'package:flutter/material.dart';

import '../../main.dart';

class UserAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title="";
  UserAppBar(this.title);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      toolbarHeight: 75,
      title: Align(
        alignment: Alignment.center,
        child: Text(
          title,
          style:  const TextStyle(
            color: Colors.white ,
            fontFamily: "title",
            fontSize: 30,
          ),
        ),
      ),
      centerTitle: true,
      flexibleSpace: Container(
        decoration:  BoxDecoration(
          color: yellow,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(75.0),
          ),
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(75.0),
        ),
      ),
    );
  }
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(75);
}
