import 'package:firebase_learning/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostDataFire extends StatefulWidget {
  const PostDataFire({super.key});

  @override
  State<PostDataFire> createState() => _PostDataFireState();
}

class _PostDataFireState extends State<PostDataFire> {
  bool load = false;
  final controller2 = TextEditingController();
  final ref = FirebaseFirestore.instance.collection("Users");
  @override
  void dispose() {
    // TODO: implement dispose
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Posts  ",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Color(0xff6A0DAD),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(6), // Ye neeche curve add karega
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: controller2,
              maxLines: 3,
              decoration: InputDecoration(
                  hintText: "What's on your mind..",
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    load = true;
                    print(load);
                  });
                  String id = DateTime.now().millisecondsSinceEpoch.toString();
                  ref.doc(id).set({
                    "Title": controller2.text,
                  }).then((value) {
                    ToastHelper.showToast("Added");
                    setState(() {
                      load = false;
                    });
                    print("Sucess");
                  }).onError((error, StackTrace) {
                    ToastHelper.showToast("Something went wrong");
                    setState(() {
                      load = false;
                    });
                    print(error);
                  });
                },
                child: load ? CircularProgressIndicator() : Text("Send")),
          ],
        ),
      ),
    );
  }
}
