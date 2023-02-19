import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../Scaffolds/User_Inreface/home.dart';
import '../../Scaffolds/User_Inreface/maps.dart';
import '../../Scaffolds/User_Inreface/search.dart';
import '../../main.dart';


var _selectedTab = 0;
class CustomedBNB extends StatefulWidget {
  const CustomedBNB({Key? key}) : super(key: key);
  @override
  State<CustomedBNB> createState() => _CustomedBNBState();
}

class _CustomedBNBState extends State<CustomedBNB> {
  //var _page = _selectedTab.
  final List<Widget> _SelectedTab = [
    const UserHome(),
    const Search(),
    ResMap(),
  ];

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: black,
      extendBody: true,
      body: Padding(
        padding: EdgeInsets.only(top: size.height * 0.035),
        child: _SelectedTab[_selectedTab],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: DotNavigationBar(
          enableFloatingNavBar: true,
          margin: const EdgeInsets.only(left: 10, right: 10),
          currentIndex: _selectedTab,
          dotIndicatorColor: Colors.white,
          unselectedItemColor: Colors.grey[300],
          // enableFloatingNavBar: false,
          onTap: _handleIndexChanged,
          items: [
            DotNavigationBarItem(
              icon: const Icon(Icons.home),
              selectedColor: yellow,
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.search),
              selectedColor: yellow,
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.map),
              selectedColor: yellow,
            ),

          ],
        ),
      ),
    );
  }
}
