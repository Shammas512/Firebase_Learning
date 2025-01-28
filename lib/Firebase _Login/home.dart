import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_learning/Firebase%20_Login/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("You Are In Home Page"),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login_page()));
                },
                child: Text("LogOut")),
          ],
        ),
      ),
    );
  }
}
