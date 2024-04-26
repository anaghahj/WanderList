import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wanderlist/screens/Signup_screen.dart';
import 'package:wanderlist/screens/group_Screen.dart';
import 'package:wanderlist/widgets/Texetbox.dart';
import 'package:wanderlist/widgets/checklist.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;

class travelScreen extends StatefulWidget {
  const travelScreen({super.key});
  static const id = "travel Screen";

  @override
  State<travelScreen> createState() => _travelScreenState();
}

class _travelScreenState extends State<travelScreen> {
  final settings = _firestore.settings.persistenceEnabled;
  void toggle(bool vlaue) {
    setState(() {
      vlaue = !vlaue;
    });
  }

  int cur = 0;
  @override
  Widget build(BuildContext context) {
    print(settings);
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade100,
      floatingActionButton: FloatingActionButton(
          isExtended: true,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => Items(),
            );
          },
          child: Icon(Icons.add)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Color.fromARGB(0, 86, 235, 255),
            padding: EdgeInsets.all(30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    Icon(
                      FontAwesomeIcons.plane,
                      color: Colors.black,
                      size: 40,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "WanderList",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      child: Text("Logout"),
                      onPressed: () {
                        _auth.signOut();
                        Navigator.of(context).pushNamed(Signup.id);
                      },
                    ),
                    SizedBox(height: 10),
                  ],
                ),
                Hero(
                  tag: Text("hero"),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, group.id);
                      },
                      icon: Icon(
                        Icons.group,
                        color: Colors.black,
                        size: 30,
                      )),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: listerw(),
              decoration: BoxDecoration(
                  color: Color.fromARGB(180, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
