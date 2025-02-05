import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String name;

  const Home({super.key, this.name = "Unknown"}); // Default value here

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ref = FirebaseDatabase.instance.ref("Users/Messages");
  final auth = FirebaseAuth.instance;
  final messageContrller = TextEditingController();
  final searchController = TextEditingController();
  final updatecont = TextEditingController();

  @override
  void dispose() {
    messageContrller.dispose();
    searchController.dispose();
    updatecont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff6A0DAD),
        title: const Text(
          "Chat App ",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: searchController,
                decoration: const InputDecoration(
                    hintText: "Search Message", border: OutlineInputBorder()),
                onChanged: (String value) {
                  setState(() {});
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: FirebaseAnimatedList(
                  defaultChild: const Center(child: CircularProgressIndicator()),
                  query: ref, // Firebase query for order
                  itemBuilder: (context, snapshot, animation, index) {
                    final title = snapshot.child("Message").value.toString();

                    if (searchController.text.isEmpty) {
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 8.0),
                        tileColor: Colors.transparent,
                        title: Align(
                          alignment: snapshot.child("Uid").value == auth.currentUser!.uid
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                              color: snapshot.child("Uid").value == auth.currentUser!.uid
                                  ? const Color(0xff6A0DAD)
                                  : const Color(0xffE0E0E0),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.child("id").value.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: snapshot.child("Uid").value == auth.currentUser!.uid
                                        ? Colors.white
                                        : Colors.black87,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  snapshot.child("Message").value.toString(),
                                  style: TextStyle(
                                    color: snapshot.child("Uid").value == auth.currentUser!.uid
                                        ? Colors.white
                                        : Colors.black87,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        trailing: snapshot.child("Uid").value == auth.currentUser!.uid
                            ? PopupMenuButton(
                                icon: const Icon(Icons.more_vert, color: Colors.black),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: 1,
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.pop(context);
                                        showupdate(title, snapshot.key!);
                                      },
                                      title: const Text("Edit"),
                                      leading: const Icon(Icons.edit, color: Colors.blue),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 2,
                                    child: ListTile(
                                      onTap: () {
                                        ref.child(snapshot.key!).remove();
                                        Navigator.pop(context);
                                      },
                                      title: const Text("Delete"),
                                      leading: const Icon(Icons.delete, color: Colors.red),
                                    ),
                                  ),
                                ],
                              )
                            : null,
                      );
                    } else if (title.toLowerCase().contains(searchController.text.toLowerCase())) {
                      return ListTile(
                        title: Text(snapshot.child("id").value.toString()),
                        subtitle: Text(snapshot.child("Message").value.toString()),
                      );
                    }
                    return const SizedBox(); // Empty widget for non-matches
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(20)),
                height: 50,
                width: 270,
                child: TextFormField(
                  controller: messageContrller,
                  decoration: InputDecoration(
                      hintText: "Send Message",
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
            String currentUserUid = auth.currentUser!.uid;

            ref.push().set({
              "id": widget.name,
              "Message": messageContrller.text,
              "Uid": currentUserUid,
              "timestamp": ServerValue.timestamp,
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
        child: const Icon(Icons.send),
      ),
    );
  }

  Future<void> showupdate(String message, String id) async {
    updatecont.text = message;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Update"),
            content: Container(
              child: TextField(
                controller: updatecont,
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    ref.child(id).update({"Message": updatecont.text});
                    Navigator.pop(context);
                  },
                  child: const Text("Update"))
            ],
          );
        });
  }
}
