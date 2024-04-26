import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firestore = FirebaseFirestore.instance;
String? username = _auth.currentUser?.uid;
String? groupname;

class creategroup extends StatefulWidget {
  const creategroup({super.key});

  @override
  State<creategroup> createState() => _creategroupState();
}

class _creategroupState extends State<creategroup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Group")),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(16)),
          Text("Select members"),
          SizedBox(height: 10),
          Expanded(
            child: StreamBuilder(
                stream: _firestore.collection('users').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }
                  final strf = snapshot.data?.docs;
                  List<Widget> postString = [];
                  for (var str in strf!) {
                    final texte = str['username'];
                    print(texte);
                    final postlist = listtile(
                      text1: texte,
                    );
                    postString.add(postlist);
                  }

                  return ListView.separated(
                      itemBuilder: (context, index) => postString[index],
                      itemCount: postString.length,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                            height: 20,
                          ));
                }),
          ),
          ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Container(
                          height: 150,
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Created Group Successfully"),
                              SizedBox(height: 30),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      child: Text("Done"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ])
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: Text("Submit"))
        ],
      ),
    );
  }
}

class listtile extends StatefulWidget {
  const listtile({super.key, required this.text1});
  final text1;

  @override
  State<listtile> createState() => _listtileState();
}

class _listtileState extends State<listtile> {
  bool icon = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: (() async {
          await _firestore
              .collection('users')
              .doc(username)
              .collection('group')
              .doc(widget.text1)
              .collection("chat");

          setState(
            () {
              icon = !icon;
            },
          );
        }),
        leading: Text(
          widget.text1,
          style: TextStyle(fontSize: 16),
        ),
        trailing: icon ? Icon(FontAwesomeIcons.check) : Icon(Icons.add));
  }
}
