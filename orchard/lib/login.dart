import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;

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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Email'),
              ),
            ),
            const Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Password'),
              ),
            ),
            TextButton(
                style: TextButton.styleFrom(
                    primary: Colors.blue[300],
                    textStyle: TextStyle(fontSize: 20),
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15.0, bottom: 0)),
                onPressed: () {},
                child: Text("Login"))
          ],
        ),
      ),
    );
  }
}
