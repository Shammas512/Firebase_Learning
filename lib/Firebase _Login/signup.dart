import 'package:firebase_learning/Firebase%20_Login/firebase_functions.dart';
import 'package:flutter/material.dart';

class Signup_page extends StatefulWidget {
  const Signup_page({super.key});

  @override
  State<Signup_page> createState() => _Signup_pageState();
}

class _Signup_pageState extends State<Signup_page> {
  bool loading = false;
  TextEditingController emailcon = TextEditingController();
  TextEditingController passcon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignUp Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailcon,
              decoration: const InputDecoration(
                  hintText: "Email", border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: passcon,
              decoration: const InputDecoration(
                  hintText: "Password", border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () async {
                  setState(() {
                  loading = true;  // Set loading to true when button is pressed
                });
                await myclass().SignUp(emailcon.text, passcon.text, context);
                setState(() {
                  loading = false; // Set loading to false after the operation
                });
                },
                child:  loading
                  ? const CircularProgressIndicator() // Show progress indicator when loading
                  : const Text("Signup"),
        )],
        ),
      ),
    );
  }
}
