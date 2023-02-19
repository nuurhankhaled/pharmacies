import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Scaffolds/shared/splash.dart';

dynamic yellow = const Color.fromRGBO(247, 180, 63 , 1);
dynamic black =  const Color.fromRGBO(37, 45, 47,1);
dynamic lightBlack =  const Color.fromRGBO(47,57,59,1);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Delivery App',
      theme: Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: const  Color.fromRGBO(247, 180, 63 , 1),
            background: Color.fromRGBO(37, 45, 47,1)
        ),
      ),
      home: Splash(),
    );
  }
}
