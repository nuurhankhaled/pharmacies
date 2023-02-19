import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:pharmacies/Scaffolds/Admin_Interface/add_doctor.dart';
import 'package:pharmacies/Scaffolds/Admin_Interface/home_body/doctors.dart';
import 'package:pharmacies/Scaffolds/Admin_Interface/home_body/pharmacies.dart';
import 'package:pharmacies/Scaffolds/Admin_Interface/view_Pharmacies.dart';
import '../../Shared/Component/PharmacyCard.dart';
import '../../Shared/Component/appbar.dart';
import '../../main.dart';
import '../../resources/authentication_methods.dart';
import '../shared/login.dart';
import 'Add_Pharmacy.dart';

class AdminHome extends StatefulWidget {
  final _counter = ValueNotifier(0);

  AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> with TickerProviderStateMixin {



  AuthenticationMethods authenticationMethods = AuthenticationMethods();
  static const List<Tab> _tabs = [
    const Tab(child: const Text('Pharmacies')),
    const Tab( child: const Text('Doctors')),
  ];
  static const List<Widget> _views = [
    const Pharmacies(),
    const Doctors(),

  ];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this );
    _tabController.animateTo(2);
  }
  @override
  Widget build(BuildContext context) {
    final key = GlobalObjectKey<ExpandableFabState>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: black,
        appBar: AppBar(
          automaticallyImplyLeading: false ,
          backgroundColor: yellow,
          toolbarHeight: 75,
          title: Padding(
            padding:  EdgeInsets.only(left: 8.0),
            child: Text("Home", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.5
            ),),
          ),
          actions: [
            Padding(padding: EdgeInsets.only(right: 8),
              child: IconButton(onPressed: () async {
              String output = await authenticationMethods.logOutUser();
              if (output == 'success') {
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return LogIn();
                    },
                  ),
                  (_) => false,
                );
              }}, icon:  Icon(Icons.logout_rounded)),)
          ],
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            indicatorWeight: 5,
            indicatorColor: lightBlack,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab( text: "Pharmacies",),
              Tab( text: "Doctors",)
            ],

          ),
        ),
        body: TabBarView(
          children: [
            Pharmacies(),
            Doctors()
          ],
        ),
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton: ExpandableFab(
          key: key,
          duration: const Duration(seconds: 1),
          distance: 60.0,
          type: ExpandableFabType.up,
          fanAngle: 70,
          child: const Icon(
            Icons.add,
            size: 45,
          ),
          foregroundColor: Colors.white,
          backgroundColor: Color.fromRGBO(247, 180, 63, 1),
          closeButtonStyle: const ExpandableFabCloseButtonStyle(
            child: Icon(Icons.clear),
            foregroundColor: Colors.white,
            backgroundColor: Color.fromRGBO(247, 180, 63, 1),
          ),
          overlayStyle: ExpandableFabOverlayStyle(
            // color: Colors.black.withOpacity(0.5),
            blur: 5,
          ),
          onOpen: () {
            debugPrint('onOpen');
          },
          afterOpen: () {
            debugPrint('afterOpen');
          },
          onClose: () {
            debugPrint('onClose');
          },
          afterClose: () {
            debugPrint('afterClose');
          },
          children: [
            FloatingActionButton.small(
              backgroundColor: Color.fromRGBO(247, 180, 63, 1),
              heroTag: null,
              child: const Icon(Icons.local_pharmacy_rounded),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: ((context) => const AddPharmacy())));
              },
            ),
            FloatingActionButton.small(
              backgroundColor: Color.fromRGBO(247, 180, 63, 1),
              heroTag: null,
              child: const Icon(Icons.person),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: ((context) => const AddDoctor())));
              },
            ),
          ],
        ),
      ),
    );
  }
}
