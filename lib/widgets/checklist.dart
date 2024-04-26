import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wanderlist/screens/group_Screen.dart';
import 'package:wanderlist/widgets/Texetbox.dart';
import 'package:wanderlist/widgets/creategroup.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;
String? uid = _auth.currentUser?.uid;

class listerw extends StatelessWidget {
  listerw({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _firestore
            .collection('users')
            .doc(user)
            .collection('self')
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
            final texte = str['liste'];
            print(texte);
            final postlist = listile(text: texte, fun: remove(texte));
            postString.add(postlist);
          }

          return ListView.separated(
              itemBuilder: (context, index) => postString[index],
              itemCount: postString.length,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                    height: 20,
                  ));
        });
  }
}

remove(String text) async {
  await _firestore
      .collection('users')
      .doc(uid)
      .collection('self')
      .doc(uid)
      .delete();
}

class listile extends StatefulWidget {
  const listile({super.key, required this.text, this.fun});
  final text;
  final fun;
  @override
  State<listile> createState() => _listileState();
}

class _listileState extends State<listile> {
  var CANCEL = TextDecoration.none;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () {
        setState(() {
          CANCEL = TextDecoration.none;
        });
      },
      onTap: () {
        setState(() {
          CANCEL = TextDecoration.lineThrough;
        });
      },
      trailing: IconButton(
        icon: Icon(FontAwesomeIcons.x, size: 15),
        onPressed: () async {
          await _firestore.collection('list').doc(widget.text).delete();
        },
      ),
      title: Text(
        widget.text,
        style: TextStyle(decoration: CANCEL, fontSize: 20),
      ),
    );
  }
}
