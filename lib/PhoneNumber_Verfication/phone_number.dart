import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learning/PhoneNumber_Verfication/code_verification.dart';
import 'package:flutter/material.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({super.key});

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  bool load = false;
  final numbercont = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verification"),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: numbercont,
              
              decoration: InputDecoration(hintText: "+1 234 567 8889"),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  load = true;
                });
                _auth.verifyPhoneNumber(
                    phoneNumber: numbercont.text.toString(),
                    verificationCompleted: (_) {
                      setState(() {
                        load = false;
                      });
                    },
                    verificationFailed: (e) {
                      setState(() {
                        load = false;
                      });
                      print(e.toString());
                    },
                    codeSent: (String verificationId, int? token) {
                      setState(() {
                        load = false;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CodeVerification(id: verificationId)));
                    },
                    codeAutoRetrievalTimeout: (e) {
                      setState(() {
                        load = false;
                      });
                      print(e.toString());
                    });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.purple,
                ),
                height: 50,
                width: 250,
                child: Center(
                  child: load
                      ? const CircularProgressIndicator()
                      : Text("Send Code"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
