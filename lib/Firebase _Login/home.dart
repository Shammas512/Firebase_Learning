import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_learning/Firebase%20_Login/login.dart';
import 'package:firebase_learning/Firebase_Realtime/post_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  final String name;

  Home({super.key, this.name = "Unknown"}); // Default value here

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ref = FirebaseDatabase.instance.ref("Users/Messages");
  final messageContrller = TextEditingController();

  @override
  void dispose() {
    messageContrller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 15),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Expanded(
              //     child: StreamBuilder(
              //         stream: ref.onValue,
              //         builder:
              //             (context, AsyncSnapshot<DatabaseEvent> snapshot) {
              //           if (!snapshot.hasData) {
                          
              //             return  Center(child: CircularProgressIndicator(),);
              //           } else {
              //             Map <dynamic,dynamic>map = snapshot.data!.snapshot.value as dynamic;
              //             List <dynamic>list = [];
              //             list.clear();
              //             list = map.values.toList();
              //             return ListView.builder(
              //                 itemCount:
              //                     snapshot.data!.snapshot.children.length,
              //                 itemBuilder: (context, index) {
              //                   return ListTile(
              //                     title: Text(list[index]["id"]),
              //                     subtitle: Text(list[index]["Message"]),
              //                   );
              //                 });
              //           }
              //         })),
              Expanded(
                child: FirebaseAnimatedList(
                  query: ref,
                  itemBuilder: (context, snapshot, index, animation) {
                    return ListTile(
                      title: Text(snapshot.child("id").value.toString()),
                      subtitle:
                          Text(snapshot.child("Message").value.toString()),
                    );
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(20)),
                height: 50,
                width: 280,
                child: TextFormField(
                  controller: messageContrller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10)),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (messageContrller.text.isNotEmpty) {
            ref.push().set({
              "id": widget.name,
              "Message": messageContrller.text
            }).then((value) {
              print("Success");
              messageContrller.clear();
            }).onError((error, stack) {
              print("Error: ${error.toString()}");
            });
          } else {
            print("Message cannot be empty");
          }
        },
        child: Icon(Icons.send),
      ),
    );
  }
}
