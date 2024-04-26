import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wanderlist/widgets/Texetbox.dart';
import 'package:wanderlist/widgets/addlist.dart';
import 'package:wanderlist/widgets/checklist.dart';
import 'package:wanderlist/widgets/creategroup.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;
String? uid = _auth.currentUser?.uid;
String ued = "pfhcNryKoJOy7y9yafyQMPqkDMt2";
String? texte;

class group extends StatefulWidget {
  const group({super.key});
  static const id = "groupscreen";

  @override
  State<group> createState() => _groupState();
}

class _groupState extends State<group> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          isExtended: true,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => Items1(),
            );
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
            backgroundColor: Colors.lightBlue.shade100,
            title: Text("Wander Group"),
            actions: [
              // IconButton(
              //   icon: Icon(Icons.people),
              //   onPressed: () => funct(context),
              // ),
              PopupMenuButton(
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Container(
                              width: 100, child: Text("Create Group")),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => creategroup()));
                          },
                        ),
                        PopupMenuItem(
                            child: Container(
                                width: 100, child: Text("Delete Group")),
                            onTap: () {
                              _firestore
                                  .collection('user')
                                  .doc(ued)
                                  .collection('group')
                                  .doc('anagha')
                                  .delete();
                              setState(() {});
                            })
                      ])
            ]),
        body: Hero(
          tag: Text("hero"),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                StreamBuilder(
                    stream: _firestore
                        .collection('users')
                        .doc(ued)
                        .collection('group')
                        .doc('anagha')
                        .collection('chat')
                        .snapshots(),
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
                        texte = str['message'];
                        print(texte);
                        final postlist = listile(text: texte, fun: remove());
                        postString.add(postlist);
                      }

                      return Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => postString[index],
                            itemCount: postString.length,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(
                                      height: 20,
                                    )),
                      );
                    }),
              ],
            ),
          ),
        ));
  }
}

remove() async {
  await _firestore
      .collection('users')
      .doc(ued)
      .collection('group')
      .doc('anagha')
      .collection('chat')
      .doc(texte)
      .delete();
}
// funct(context)
// {
//   showDialog(context: context, builder: (_){
//     List<String> lisd=_firestore.collection('users').doc(ued).collection('group').get(GetOptions(
        
//     ));
//     return Dialog(
//       child:Container(
//         child: ListView.builder(itemBuilder:(context,index){ListTile(title:)})
//       )
//     )
//   })
// }