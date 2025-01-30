import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class CodeVerification extends StatefulWidget {
  final String id;
  const CodeVerification({super.key, required this.id});

  @override
  State<CodeVerification> createState() => _CodeVerificationState();
}

class _CodeVerificationState extends State<CodeVerification> {
  bool load = false;
  final controller = TextEditingController();
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
            SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "000000",
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () async {
                  setState(() {
                    load = true;
                  });
                  final credential = PhoneAuthProvider.credential(
                      verificationId: widget.id,
                      smsCode: controller.text.toString());

                  try {
                    await FirebaseAuth.instance
                        .signInWithCredential(credential);
                    setState(() {
                      load = false;
                    });
                  } catch (e) {
                    setState(() {
                      load = false;
                    });
                    print(
                      e.toString(),
                    );
                  }
                },
                child: load ? CircularProgressIndicator() : Text(" Verify"))
          ],
        ),
      ),
    );
  }
}
