import 'package:firebase_learning/Firebase%20_Login/firebase_functions.dart';
import 'package:firebase_learning/Firebase%20_Login/signup.dart';
import 'package:firebase_learning/PhoneNumber_Verfication/phone_number.dart';
import 'package:flutter/material.dart';

class Login_page extends StatefulWidget {
  const Login_page({super.key});

  @override
  State<Login_page> createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  TextEditingController emailcont = TextEditingController();
  TextEditingController passcont = TextEditingController();
  bool load = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: const Text("Login Page"),
          centerTitle: true,
          backgroundColor: Color(0xFF4169E1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(10),
              height: size.height * 0.8,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: const [
                    Color(0xFFE0E0E0), // Light Silver
                    Color(0xFFB0B0B0), // Medium Silver
                    Color(0xFF808080), // Dark Silver
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade700,
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(4, 4),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(-4, -4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(fontSize: 40, fontFamily: "PlaywriteIN"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: emailcont,
                    decoration: const InputDecoration(
                        hintText: "Email", border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: passcont,
                    decoration: const InputDecoration(
                        hintText: "Password", border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          load = true;
                        });
                        await myclass()
                            .login(emailcont.text, passcont.text, context);
                        setState(() {
                          load = false;
                        });
                      },
                      child: load
                          ? const CircularProgressIndicator()
                          : const Text("Signin")),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await myclass().googleLog(context);
                      },
                      child: const Text("Continue With Google")),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Signup_page()));
                      },
                      child: const Text("Create An Account")),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PhoneNumber()));
                    },
                    child: Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.black)),
                      child: Center(child: Text("Login With Phone")),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
