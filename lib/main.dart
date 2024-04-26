import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wanderlist/screens/Login_Screen.dart';
import 'package:wanderlist/screens/Signup_screen.dart';
import 'package:wanderlist/screens/Travel_screen.dart';
import 'package:wanderlist/screens/group_Screen.dart';

import 'firebase_options.dart';

// void main() => runApp(FlashChat());
ThemeData themme = ThemeData(
    fontFamily: 'Lato',
    colorScheme:
        ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 118, 219, 245)));
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Travel());
}

class Travel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themme,
      title: "Travel",
      initialRoute: Signup.id,
      routes: {
        Login.id: (context) => Login(),
        Signup.id: (context) => const Signup(),
        group.id: (context) => group(),
        travelScreen.id: (context) => travelScreen(),
        //Splash_screen.id: (context) => Splash_screen()
      },
    );
  }
}
