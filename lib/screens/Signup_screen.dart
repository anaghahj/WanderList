import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wanderlist/screens/Login_Screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wanderlist/screens/Travel_screen.dart';
import 'package:wanderlist/screens/group_Screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

class Signup extends StatefulWidget {
  const Signup({super.key});
  static const id = 'Email';

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  String? email;
  String? password;
  String? username;
  String? newUser;
  bool is_visibility = false;
  bool is_visibility2 = false;

  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirm = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.white],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(children: [
                      Container(
                        height: 70,
                        width: 250,
                        padding: EdgeInsets.all(10),
                        child: ElevatedButton(
                            onPressed: () async {
                              await signInWithGoogle();

                              Navigator.pushNamed(context, travelScreen.id);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(FontAwesomeIcons.google),
                                SizedBox(width: 10),
                                Text("Google SignIn"),
                              ],
                            )),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _username,
                        onChanged: (value) {
                          username = value;
                        },
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.account_circle_outlined),
                          contentPadding: EdgeInsets.all(15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          hintText: "Username",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      TextFormField(
                        controller: _email,
                        onChanged: (value) {
                          print(email);
                          email = value;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined),
                          contentPadding: EdgeInsets.all(15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          hintText: "Email",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      TextFormField(
                        controller: _password,
                        obscureText: !is_visibility2,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: "Create new Password",
                            prefixIcon: Icon(Icons.password_outlined),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  is_visibility2 = !is_visibility2;
                                });
                              },
                              icon: is_visibility2
                                  ? Icon(
                                      Icons.visibility,
                                    )
                                  : Icon(
                                      Icons.visibility_off,
                                    ),
                            ),
                            contentPadding: EdgeInsets.all(15),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                            hintText: "Password"),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      TextFormField(
                        controller: _confirm,
                        obscureText: !is_visibility,
                        onChanged: (value) {
                          password = value;
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Confirm the password",
                          prefixIcon: Icon(Icons.password_outlined),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                is_visibility = !is_visibility;
                              });
                            },
                            icon: is_visibility
                                ? Icon(
                                    Icons.visibility,
                                  )
                                : Icon(
                                    Icons.visibility_off,
                                  ),
                          ),
                          contentPadding: EdgeInsets.all(15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          hintText: "Password",
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            print(email);
                            print(password);

                            UserCredential userCredential =
                                await _auth.createUserWithEmailAndPassword(
                                    email: email!, password: password!);
                            newUser = userCredential.user!.uid;
                            await _firestore
                                .collection('users')
                                .doc(username)
                                .set({
                              'username': username,
                              'email': email,
                              'password': password,
                              'time': Timestamp.now()
                            }).then((value) => Navigator.pushNamed(
                                    context, travelScreen.id));
                            // await _firestore
                            //     .collection('users/posts')
                            //     .add({'useranam': username});

                            setState(() {
                              _email.clear();
                              _confirm.clear();
                              _username.clear();
                              _password.clear();
                            });
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Text('SignUp'),
                      ),
                      SizedBox(height: 10),
                      Text("Already have an account"),
                      SizedBox(height: 10),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Login.id);
                          },
                          child: Text("Log-In"))
                    ]),
                  ),
                ),
              ),
            )));
  }
}
