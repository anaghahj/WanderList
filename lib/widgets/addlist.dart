// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:wanderlist/widgets/creategroup.dart';

// int countr = 0;
// String ued = "pfhcNryKoJOy7y9yafyQMPqkDMt2";
// FirebaseFirestore _firestore = FirebaseFirestore.instance;

// // db.Setting(PersistenceSettings(synchronizeTabs: true));
// class Items1 extends StatefulWidget {
//   const Items1({super.key, this.data, this.text});
//   final data;
//   final text;

//   @override
//   State<StatefulWidget> createState() {
//     return _Items1State();
//   }
// }

// TextEditingController xyz = TextEditingController();

// class _Items1State extends State<Items1> {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Dialog(
//       child: Container(
//         padding: EdgeInsets.all(20),
//         height: 190,
//         width: 60,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextFormField(
//               textCapitalization: TextCapitalization.words,
//               controller: xyz,
//               decoration: InputDecoration(
//                   hintText: "Enter your needs",
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(16))),
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 ElevatedButton(
//                     onPressed: () async {
//                       final data1 = {
//                         'message': xyz.text,
//                         'username': username,
//                         'timeStamp': Timestamp.now(),
//                       };
//                       print(xyz.text);
//                       await _firestore
//                           .collection("users")
//                           .doc(ued)
//                           .collection('group')
//                           .doc('anagha')
//                           .collection("chat")
//                           .doc()
//                           .set(data1);

//                       xyz.clear();
//                     },
//                     child: Text("Add")),
//                 const SizedBox(width: 8),
//                 ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                       xyz.clear();
//                     },
//                     child: Text("Cancel")),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
