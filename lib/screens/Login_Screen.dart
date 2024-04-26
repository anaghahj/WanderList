import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wanderlist/screens/Signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wanderlist/screens/Travel_screen.dart';
import 'package:wanderlist/screens/group_Screen.dart';

String? email1;
String? password1;

class Login extends StatefulWidget {
  static const id = 'Login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;
  bool is_visibility = false;
  bool is_visibility2 = false;
  String name = "";
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              controller: username,
              onChanged: (value) {
                email1 = value;
              },
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.account_circle_outlined),
                contentPadding: EdgeInsets.all(15),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                hintText: "Username",
              ),
            ),
            Padding(padding: EdgeInsets.all(10)),
            TextFormField(
              controller: password,
              onChanged: (value) {
                password1 = value;
              },
              obscureText: !is_visibility2,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
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
                          color: Colors.grey,
                        ),
                ),
                contentPadding: EdgeInsets.all(15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                hintText: "Password",
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
                onPressed: () async {
                  try {
                    await _auth.signInWithEmailAndPassword(
                        email: email1!, password: password1!);

                    Navigator.pushNamed(context, travelScreen.id);
                  } catch (e) {
                    print(e);
                  }
                  password.clear();
                  username.clear();
                },
                child: Text("Login")),
            Text("If u dont have an account"),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                child: Text("Sign in"),
                onPressed: () {
                  Navigator.pushNamed(context, Signup.id);
                }),
          ],
        ),
      )),
    );
  }
}
