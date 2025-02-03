
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  final String name;

  Home({super.key, this.name = "Unknown"}); // Default value here

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ref = FirebaseDatabase.instance.ref("Users/Messages");
  final messageContrller = TextEditingController();
  final searchController = TextEditingController();
  final updatecont = TextEditingController();

  @override
  void dispose() {
    messageContrller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff6A0DAD),
        title: Text(
          "Chat App ",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 14),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                    hintText: "Search Message", border: OutlineInputBorder()),
                onChanged: (String value) {
                  setState(() {});
                },
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: FirebaseAnimatedList(
                  defaultChild: Center(child: CircularProgressIndicator()),
                  query: ref,
                  itemBuilder: (context, snapshot, animation, index) {
                    final title = snapshot.child("Message").value.toString();
                  
                    if (searchController.text.isEmpty) {
                      return ListTile(
                          title: Text(snapshot.child("id").value.toString()),
                          subtitle:
                              Text(snapshot.child("Message").value.toString()),
                          trailing: PopupMenuButton(
                              icon: Icon(Icons.more_vert),
                              itemBuilder: (context) => [
                                    PopupMenuItem(
                                        value: 1,
                                        child: ListTile(
                                          onTap: () {
                                            Navigator.pop(context);
                                            showupdate(title, snapshot.key!);
                                          },
                                          title: Text("Edit"),
                                          leading: Icon(Icons.edit),
                                        )),
                                    PopupMenuItem(
                                        value: 1,
                                        child: ListTile(
                                          onTap: () {
                                            ref.child(snapshot.key!).remove();
                                            Navigator.pop(context);
                                          },
                                          title: Text("Delete"),
                                          leading: Icon(Icons.delete),
                                        ))
                                  ]));
                    } else if (title.toLowerCase().contains(
                        searchController.text.toLowerCase().toString())) {
                      return ListTile(
                        title: Text(snapshot.child("id").value.toString()),
                        subtitle:
                            Text(snapshot.child("Message").value.toString()),
                      );
                    }
                    return Container();
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

  Future<void> showupdate(String message, String id) async {
    updatecont.text = message;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Update"),
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
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () {
                    ref.child(id).update({"Message": updatecont.text});
                    Navigator.pop(context);
                  },
                  child: Text("Update"))
            ],
          );
        });
  }
}
