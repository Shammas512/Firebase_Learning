import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learning/Firebase%20_Login/login.dart';
import 'package:firebase_learning/Firebase_FireStore/store_home.dart';
import 'package:flutter/material.dart';

class AuthCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Loading state
        } else if (snapshot.hasData) {
          return StoreHome(); // User logged in → HomeScreen
        } else {
          return Login_page(); // No user → LoginScreen
        }
      },
    );
  }
}