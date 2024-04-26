import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wanderlist/screens/group_Screen.dart';
import 'package:wanderlist/widgets/creategroup.dart';

int countr = 0;
FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;
String? user = _auth.currentUser?.email;

// db.Setting(PersistenceSettings(synchronizeTabs: true));
class Items extends StatefulWidget {
  const Items({super.key, this.data});
  final data;

  @override
  State<StatefulWidget> createState() {
    return _ItemsState();
  }
}

TextEditingController xyz = TextEditingController();

class _ItemsState extends State<Items> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(20),
        height: 190,
        width: 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              textCapitalization: TextCapitalization.words,
              controller: xyz,
              decoration: InputDecoration(
                  hintText: "Enter your needs",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16))),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      final data1 = {
                        'liste': xyz.text,
                        'username': username,
                        'timeStamp': Timestamp.now(),
                      };
                      print(xyz.text);
                      await _firestore
                          .collection('users')
                          .doc(user)
                          .collection('self')
                          .doc()
                          .set(data1);
                      countr += 1;
                      xyz.clear();
                    },
                    child: Text("Add")),
                const SizedBox(width: 8),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      xyz.clear();
                    },
                    child: Text("Cancel")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
