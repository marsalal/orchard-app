import 'dart:js';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  late TextEditingController emailInputController;
  late TextEditingController pwdInputController;

  @override
  initState() {
    emailInputController = TextEditingController();
    pwdInputController = TextEditingController();
    super.initState();
  }

  String emailValidator(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return value != null && !regex.hasMatch(value)
        ? 'Email format is invalid'
        : '';
  }

  String pwdValidator(String? value) {
    return value != null && value.length < 8
        ? 'Password must be longer than 8 characters'
        : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orchard"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Padding(
                padding: EdgeInsets.only(top: 60.0),
                child: Center(
                  child: SizedBox(
                    width: 200,
                    height: 150,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Email*', hintText: "john.doe@gmail.com"),
                controller: emailInputController,
                keyboardType: TextInputType.emailAddress,
                validator: emailValidator,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Password*', hintText: "********"),
                controller: pwdInputController,
                obscureText: true,
                validator: pwdValidator,
              ),
            ),
            TextButton(
                style: TextButton.styleFrom(
                    primary: Colors.blue[300],
                    textStyle: const TextStyle(fontSize: 20),
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15.0, bottom: 15)),
                onPressed: () async {
                  if (_loginFormKey.currentState!.validate()) {
                    try {
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .signInWithEmailAndPassword(
                              email: emailInputController.text,
                              password: pwdInputController.text);
                      showAuthResponse(context, userCredential);
                    } on FirebaseAuthException catch (e) {
                      print(e);
                    }
                  }
                },
                child: const Text("Login")),
            const Divider(
              height: 15,
              thickness: 3.5,
              endIndent: 20,
              indent: 20,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: AlignmentDirectional.center,
                child: SizedBox(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.facebook)),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.ac_unit_rounded)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showAuthResponse(BuildContext context, UserCredential userCredential) {
  showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(content: Text('user $userCredential.user!.email')));
}

Widget buildBarItem(IconButton button) {
  return Container(
    width: 100.0,
    margin: const EdgeInsets.all(4.0),
    color: Colors.white,
    child: button,
  );
}
