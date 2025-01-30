import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class PostData extends StatefulWidget {
  const PostData({super.key});

  @override
  State<PostData> createState() => _PostDataState();
}

class _PostDataState extends State<PostData> {
  bool load = false;
  final controller = TextEditingController();
  final controller2 = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.ref("Users");
  final databaseRef2 = FirebaseDatabase.instance.ref("Message");
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
            SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: controller,
              maxLines: 1,
              decoration: InputDecoration(
                  hintText: "Write Your Name", border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: controller2,
              maxLines: 3,
              decoration: InputDecoration(
                  hintText: "What's on your mind..",
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    load = true;
                    print(load);
                  });
                  databaseRef
                      .child(DateTime.now().millisecondsSinceEpoch.toString())
                      .set({
                    "id": DateTime.now().millisecondsSinceEpoch.toString(),
                    "Message": controller.text
                  }).then((value) {
                    print(" FLUTTER : ID IS CREATED");
                  
                  }).onError((error, stackTree) {
                    print(error.toString());
                  });

                  databaseRef2
                      .child(DateTime.now().millisecondsSinceEpoch.toString())
                      .set(({"Message": controller2.text}))
                      .then((value) {
                    setState(() {
                      load = false;
                    });
                    print(" FLUTTER : MESSAGE IS GONE");
                  }).onError((error, stackTree) {
                    setState(() {
                      load = false;
                    });
                    print(error.toString());
                  });
                },
                child: load ? CircularProgressIndicator() : Text("Send")),
          ],
        ),
      ),
    );
  }
}
